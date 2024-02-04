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

  /// Creates the [ViewModel] of this widget.
  ///
  /// The [BuildContext] is provided to allow for dependency injection.
  VM createViewModel(BuildContext context);

  /// Forward of [State.didChangeDependencies], in case the widget needs to
  /// notify its [ViewModel] of any dependency changes.
  void didChangeDependencies(BuildContext context, VM viewModel) {}

  Widget build(BuildContext context, VM viewModel);
}

class _ViewModelWidgetState<VM extends ViewModel>
    extends State<ViewModelWidget<VM>> {
  VM? viewModel;

  /// Called once to initialize the [viewModel].
  ///
  /// Note that this method is called during [didChangeDependencies] instead of
  /// [initState] as the [BuildContext] is required for
  /// [ViewModelWidget.createViewModel].
  void initViewModel() {
    viewModel = widget.createViewModel(context);
    viewModel!.initLocalState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel!.initGlobalState();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewModel == null) initViewModel();
    widget.didChangeDependencies(context, viewModel!);
  }

  @override
  void dispose() {
    viewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, viewModel!);
}
