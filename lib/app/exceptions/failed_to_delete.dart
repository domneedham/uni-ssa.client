class FailedToDeleteCategoryException implements Exception {
  FailedToDeleteCategoryException(this.cause);

  final String cause;
}
