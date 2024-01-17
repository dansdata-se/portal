import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:signals/signals.dart";

class AppViewModel extends ViewModel {
  final counter = signal(0);

  void incrementCounter() {
    counter.value++;
  }
}
