import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

import 'demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluid Dialog Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.redAccent,
      ),
      home: const DemoPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FluidDialog(
                rootPage: FluidDialogPage(
                  alignment: Alignment.bottomLeft,
                  builder: (context) => const TestDialog(),
                ),
              ),
            );
          },
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }
}

class TestDialog extends StatelessWidget {
  const TestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hello there',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(
              'This is a dialog. It can transition in from the top, bottom, left, or right. The size is also animated.'),
          TextButton(
            onPressed: () => DialogNavigator.of(context).push(
              FluidDialogPage(
                builder: (context) => const SecondDialogPage(),
              ),
            ),
            child: const Text('Go to next page'),
          ),
        ],
      ),
    );
  }
}

class SecondDialogPage extends StatelessWidget {
  const SecondDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'And a bigger dialog',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(placeholder),
            TextButton(
              onPressed: () => DialogNavigator.of(context).pop(),
              child: const Text('Go back'),
            ),
            TextButton(
              onPressed: () => DialogNavigator.of(context).close(),
              child: const Text('Close the dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
