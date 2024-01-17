import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";

/// A simplified [StatefulWidget] where state is located in a [ViewModel].
///
/// This widget allows you to keep state in a [ViewModel] without needing to
/// create a separate [State] class.
abstract class ViewModelWidget<VM extends ViewModel> extends StatefulWidget {
  const ViewModelWidget({super.key});

  @override
  @nonVirtual
  State<StatefulWidget> createState() => _ViewModelWidgetState<VM>();

  VM createViewModel();

  Widget build(BuildContext context, VM viewModel);
}

class _ViewModelWidgetState<VM extends ViewModel>
    extends State<ViewModelWidget<VM>> {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.createViewModel();
    viewModel.init();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, viewModel);
}
