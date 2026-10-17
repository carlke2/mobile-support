/// Read camelCase Express fields with snake_case fallback when docs list both.
Object? readKey(Map<dynamic, dynamic> json, String camel, [String? snake]) {
  final direct = json[camel];
  if (direct != null) {
    return direct;
  }
  if (snake != null) {
    return json[snake];
  }
  return null;
}

String? readString(Map<dynamic, dynamic> json, String camel, [String? snake]) {
  final value = readKey(json, camel, snake);
  if (value == null) {
    return null;
  }
  final text = value.toString();
  return text.isEmpty ? null : text;
}

String requireString(Map<dynamic, dynamic> json, String camel, [String? snake]) {
  return readString(json, camel, snake) ?? '';
}

int readInt(Map<dynamic, dynamic> json, String camel, [String? snake]) {
  final value = readKey(json, camel, snake);
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse('$value') ?? 0;
}

bool? readBool(Map<dynamic, dynamic> json, String camel, [String? snake]) {
  final value = readKey(json, camel, snake);
  if (value is bool) {
    return value;
  }
  return null;
}

Map<String, dynamic>? asStringKeyedMap(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}

List<Map<String, dynamic>> asObjectList(Object? value) {
  if (value is! List) {
    return const [];
  }
  final out = <Map<String, dynamic>>[];
  for (final entry in value) {
    final map = asStringKeyedMap(entry);
    if (map != null) {
      out.add(map);
    }
  }
  return out;
}
