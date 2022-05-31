class CancelledByUser implements Exception {
  late String _message;
  CancelledByUser([String message = 'Invalid value']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
