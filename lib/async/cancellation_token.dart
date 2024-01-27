class CancellationToken {
  bool _isCancelled = false;

  bool isCancelled() => _isCancelled;

  void cancel() => _isCancelled = true;
}
