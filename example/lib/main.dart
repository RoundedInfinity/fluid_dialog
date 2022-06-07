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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        useMaterial3: true, colorSchemeSeed: Colors.amberAccent,
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
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FluidDialog(
                rootPage: FluidDialogPage(
                  alignment: Alignment.bottomCenter,
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
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hello there',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
                'And nothing in this Constitution shall be so construed as to Prejudice any Claims of the States concerned'),
            TextButton(
              onPressed: () => DialogNavigator.of(context).push(
                FluidDialogPage(
                  builder: (context) => const TestDialog2(),
                ),
              ),
              child: const Text('Push'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestDialog2 extends StatefulWidget {
  const TestDialog2({Key? key}) : super(key: key);

  @override
  State<TestDialog2> createState() => _TestDialog2State();
}

class _TestDialog2State extends State<TestDialog2> {
  double size = 25.0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing More',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'And nothing in this Union a Republican Form of Government, and shall protect each of them against Invasion. In Case of the Union, suppress Insurrections and repel Invasions. The Times, Places and Manner of holding Elections for Senators and Representatives, shall be apportioned among the several States, and of the sixth Year, so that one-third may be chosen every second Year by the People of the several States, when called into the actual Service of the Army and Navy of the United States, shall call a Convention for proposing Amendments, which, in either Case, shall be eligible to that Office who shall not have attained to the Age of thirty-five Years, and been seven Years a Resident within the United States, except in Cases of Rebellion or Invasion the public Acts, Records, and judicial Officers, both of the United States. All Debts contracted and Engagements entered into, before the Adoption of this Constitution, when ratified by the Legislatures of two thirds, expel a Member. The House of Representatives shall immediately chuse by Ballot one of them for President. A Person charged in any State be formed or erected within the United States. To Controversies between two or more States, or of any other State.',
            ),
            TextButton(
              onPressed: () => DialogNavigator.of(context).pop(),
              child: const Text('pop'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('close'),
            ),
            TextButton(
              onPressed: () => DialogNavigator.of(context).push(FluidDialogPage(
                builder: (context) => const TestDialog(),
              )),
              child: const Text('Push'),
            ),
            AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: size,
                width: size,
                color: Theme.of(context).colorScheme.primaryContainer),
            TextButton(
              onPressed: () {
                setState(() {
                  size += 25.0;
                });
              },
              child: const Text('state'),
            ),
          ],
        ),
      ),
    );
  }
}
