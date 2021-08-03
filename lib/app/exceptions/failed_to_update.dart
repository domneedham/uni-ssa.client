class FailedToUpdateException implements Exception {
  final String cause;
  FailedToUpdateException(this.cause);
}

class FailedToUpdateUserException extends FailedToUpdateException
    implements Exception {
  final String cause;
  FailedToUpdateUserException(this.cause) : super(cause);
}

class FailedToUpdateCategoryException extends FailedToUpdateException
    implements Exception {
  final String cause;
  FailedToUpdateCategoryException(this.cause) : super(cause);
}
