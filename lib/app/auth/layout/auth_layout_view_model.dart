import "package:flutter/material.dart";

class AuthLayoutViewModel with ChangeNotifier {
  AppBar? _appBar;
  AppBar? get appBar => _appBar;

  void updateAppBar(AppBar? newAppBar) {
    if (appBar == null && newAppBar == null) return;

    _appBar = newAppBar;
    notifyListeners();
  }

  void clearAppBar() => updateAppBar(null);

  List<FloatingActionButton> _fabs = List.empty();
  List<FloatingActionButton> get fabs => _fabs;

  void updateFabs(List<FloatingActionButton> newFabs) {
    _fabs = newFabs;
    notifyListeners();
  }

  void clearFabs() {
    if (fabs.isEmpty) return;

    _fabs = List.empty();
    notifyListeners();
  }

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
