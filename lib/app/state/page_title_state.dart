import "package:portal/app/state/state.dart";

class PageTitleState extends State<String> {
  static const String titleSlug = "Dansdata Portal";
  String _value = titleSlug;

  @override
  String get value => _value;

  @override
  Future<void> update(String newValue) async {
    _value = newValue.isEmpty ? titleSlug : "$newValue | $titleSlug";
    notifyListeners();
  }
}
