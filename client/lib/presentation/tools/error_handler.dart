Future<void> launchRetrieveResult(Future Function() action,
    {Function(dynamic e)? errorHandler}) async {
  try {
    await action.call();
  } catch (e) {
    errorHandler?.call(e);
  }
}
