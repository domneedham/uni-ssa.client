abstract class FailedToUpdateException implements Exception {
  FailedToUpdateException(this.cause);

  final String cause;
}

class FailedToUpdateUserException implements FailedToUpdateException {
  FailedToUpdateUserException(this.cause);

  @override
  final String cause;
}

class FailedToUpdateCategoryException implements FailedToUpdateException {
  FailedToUpdateCategoryException(this.cause);

  @override
  final String cause;
}
