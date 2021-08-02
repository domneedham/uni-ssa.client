class FailedToUpdateUserException implements Exception {
  final String cause;
  FailedToUpdateUserException(this.cause);
}
