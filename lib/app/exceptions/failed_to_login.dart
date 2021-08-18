class FailedToLoginException implements Exception {
  FailedToLoginException(this.cause);

  final String cause;
}
