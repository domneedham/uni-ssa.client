class FailedToSaveException implements Exception {
  FailedToSaveException(this.cause);

  final String cause;
}
