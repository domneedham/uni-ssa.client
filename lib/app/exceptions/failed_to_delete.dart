class FailedToDeleteCategoryException implements Exception {
  final String cause;
  FailedToDeleteCategoryException(this.cause);
}
