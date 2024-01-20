import "package:dansdata_portal/app/app.viewmodel.dart";
import "package:dansdata_portal/app/conditional_wrapper.dart";
import "package:dansdata_portal/app/theme/theme.dart";
import "package:dansdata_portal/app/view_model/widget.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:signals/signals_flutter.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      home: ConditionalWrapper(
        shouldWrap: kIsWeb,
        wrapper: (child) => SelectionArea(child: child),
        child: const MyHomePage(title: "Flutter Demo Home Page"),
      ),
    );
  }
}

class MyHomePage extends ViewModelWidget<AppViewModel> {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  AppViewModel createViewModel() => AppViewModel();

  @override
  Widget build(BuildContext context, AppViewModel viewModel) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text(
              "Dansdata",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text:
                    "Dansdata is a platform for the collection and distribution of Swedish dance information.\n\nBy facilitating the industry and making data freely available to developers, we want to encourage more people to take part in this wonderful interest: DANCING!\n\n",
                style: Theme.of(context).textTheme.bodySmall!,
                children: <TextSpan>[
                  TextSpan(
                    text: "In the swing with swedish dance",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                height: constraints.maxHeight - 8,
              ),
              child: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  //
                  // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                  // action in the IDE, or press "p" in the console), to see the
                  // wireframe for each widget.
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("You have pushed the button this many times:"),
                    Watch(
                      (_) => Text(
                        "${viewModel.counter}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.incrementCounter,
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
