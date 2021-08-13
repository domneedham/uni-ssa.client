class FailedToLoginException implements Exception {
  final String cause;
  FailedToLoginException(this.cause);
}
