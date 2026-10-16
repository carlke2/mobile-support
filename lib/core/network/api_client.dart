import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';
import 'unauthorized_hub.dart';

/// HTTP client for the Express API. Every call goes to [AppConfig.apiBaseUrl].
class ApiClient {
  ApiClient({
    required this.baseUrl,
    required this.readToken,
    required this.clearToken,
    http.Client? httpClient,
    this.receiveTimeout = const Duration(seconds: 20),
    this.onUnauthorized,
  }) : _http = httpClient ?? http.Client();

  final String baseUrl;
  final Future<String?> Function() readToken;
  final Future<void> Function() clearToken;
  final Duration receiveTimeout;
  final Future<void> Function()? onUnauthorized;
  final http.Client _http;

  void close() => _http.close();

  Future<Map<String, dynamic>> get(String path, {String? token}) {
    return _send('GET', path, token: token);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) {
    return _send('POST', path, body: body, token: token);
  }

  Future<Map<String, dynamic>> patch(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) {
    return _send('PATCH', path, body: body, token: token);
  }

  Future<Map<String, dynamic>> delete(String path, {String? token}) {
    return _send('DELETE', path, token: token);
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = <String, String>{'Accept': 'application/json'};
    final auth = token ?? await readToken();
    final hadBearer = auth != null && auth.isNotEmpty;
    if (hadBearer) {
      headers['Authorization'] = 'Bearer $auth';
    }
    if (body != null) {
      headers['Content-Type'] = 'application/json';
    }

    final request = http.Request(method, uri)..headers.addAll(headers);
    if (body != null) {
      request.body = jsonEncode(body);
    }

    late http.StreamedResponse streamed;
    try {
      streamed = await _http.send(request).timeout(receiveTimeout);
    } on TimeoutException {
      throw const ApiException.timeout(
        message: 'The server took too long to respond.',
      );
    } on http.ClientException {
      throw const ApiException.network(message: 'Unable to reach the server.');
    } on Object {
      throw const ApiException.network(message: 'Unable to reach the server.');
    }

    final text = await streamed.stream.bytesToString();
    Object? decoded;
    if (text.trim().isEmpty) {
      decoded = <String, dynamic>{};
    } else {
      try {
        decoded = jsonDecode(text);
      } on Object {
        throw ApiException.unknown(
          message: 'Expected a JSON object.',
          statusCode: streamed.statusCode,
        );
      }
    }

    if (streamed.statusCode == 401) {
      if (hadBearer) {
        await clearToken();
        await onUnauthorized?.call();
      }
      final map = asJsonMap(decoded);
      throw ApiException.backend(
        message: map == null ? 'Request failed' : messageFromBody(map),
        statusCode: 401,
      );
    }

    if (streamed.statusCode >= 400) {
      final map = asJsonMap(decoded);
      throw ApiException.backend(
        message: map == null ? 'Request failed' : messageFromBody(map),
        statusCode: streamed.statusCode,
      );
    }
    return parseSuccessBody(decoded, statusCode: streamed.statusCode);
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final storage = ref.watch(tokenStorageProvider);
  final hub = ref.watch(unauthorizedHubProvider);
  final client = ApiClient(
    baseUrl: config.apiBaseUrl,
    readToken: storage.read,
    clearToken: storage.clear,
    receiveTimeout: config.receiveTimeout,
    onUnauthorized: hub.notify,
  );
  ref.onDispose(client.close);
  return client;
});
