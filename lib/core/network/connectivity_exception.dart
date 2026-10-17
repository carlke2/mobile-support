import 'connection_failure.dart';

/// Thrown when the Express API cannot be reached (or returns a server error
/// without a normal API body). Carries copy for [ConnectionFailurePanel].
class ConnectivityException implements Exception {
  ConnectivityException(this.failure);

  final ConnectionFailure failure;

  @override
  String toString() => failure.message;
}
