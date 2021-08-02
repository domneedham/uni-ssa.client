class FailedToSaveException implements Exception {
  final String cause;
  FailedToSaveException(this.cause);
}
