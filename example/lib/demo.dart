import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

const String placeholder = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Scripta periculis ei eam, te pro movet reformidans. Eos verear percipit ex, eos ne eligendi inimicus. Pri posse graeco definitiones cu, id eam populo quaestio adipiscing, usu quod malorum te. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. Pri viderer tamquam ei. Partiendo adversarium no mea. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. No vis iuvaret appareat. Scripta periculis ei eam, te pro movet reformidans. Scripta periculis ei eam, te pro movet reformidans. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. Ad doctus gubergren duo, mel te postea suavitate. Liber nusquam insolens has ei, appetere accusamus intellegam id ius.
''';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
        actions: [
          IconButton(
            onPressed: () {
              // The `showModal` function from the animations package is used instead of showDialog
              // because it has a cooler animation.
              showModal(
                context: context,
                builder: (context) => FluidDialog(
                  // A curve from the sprung package is used to give the transition a bouncy effect.
                  alignmentCurve: Sprung.criticallyDamped,
                  // Setting custom durations for all animations.
                  sizeDuration: const Duration(milliseconds: 300),
                  alignmentDuration: const Duration(milliseconds: 800),
                  transitionDuration: const Duration(milliseconds: 200),
                  reverseTransitionDuration: const Duration(milliseconds: 100),
                  // Here we use another animation from the animations package instead of the default one.
                  transitionBuilder: (child, animation) => SharedAxisTransition(
                    transitionType: SharedAxisTransitionType.scaled,
                    animation: animation,
                    secondaryAnimation: ReverseAnimation(animation),
                    fillColor: Colors.transparent,
                    child: child,
                  ),
                  // Configuring how the dialog looks.
                  dialogDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // Setting the first dialog page.
                  rootPage: FluidDialogPage(
                    alignment: Alignment.topRight,
                    builder: (context) => const InfoDialog(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Placeholder(),
            Text(placeholder),
          ],
        ),
      ),
    );
  }
}

/// A simple example of a dialog
class InfoDialog extends StatelessWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Style'),
              leading: const Icon(Icons.color_lens_outlined),
              iconColor: Theme.of(context).colorScheme.onSurface,
            ),
            ListTile(
              title: const Text('Format'),
              leading: const Icon(Icons.text_format_rounded),
              iconColor: Theme.of(context).colorScheme.onSurface,
              // Transform to the next dialog when this is pressed.
              onTap: () => DialogNavigator.of(context).push(
                FluidDialogPage(
                  alignment: Alignment.topRight,
                  builder: (context) => const FormatPage(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings_outlined),
              iconColor: Theme.of(context).colorScheme.onSurface,
            ),
            ListTile(
              title: const Text('About'),
              leading: const Icon(Icons.info_outline),
              iconColor: Theme.of(context).colorScheme.onSurface,
              onTap: () => DialogNavigator.of(context).push(
                FluidDialogPage(
                  // This dialog is shown in the center of the screen.
                  alignment: Alignment.center,
                  builder: (context) => const AboutPage(),
                ),
              ),
            ),
            const Divider(),
            const Text('Words: 420'),
            const Text('Reading Time: 6min 9s'),
          ],
        ),
      ),
    );
  }
}

class FormatPage extends StatelessWidget {
  const FormatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              // Go back to the previous page when the back button is pressed.
              onPressed: () => DialogNavigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.onSurface,
            ),
            ListTile(
              title: Text(
                'Format',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: const Text('Change the format of the page.'),
            ),
            SwitchListTile(
              value: true,
              title: const Text('Enable Something'),
              onChanged: (val) {},
            ),
            SwitchListTile(
              value: false,
              title: const Text('Enable another thing'),
              onChanged: (val) {},
            ),
            const Divider(),
            ListTile(
              title: const Text('Alignment'),
              leading: const Icon(Icons.format_align_left_outlined),
              iconColor: Theme.of(context).colorScheme.onSurface,
            ),
            ListTile(
              title: const Text('Color'),
              leading: const Icon(Icons.format_color_fill_outlined),
              iconColor: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => DialogNavigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                IconButton(
                  // Close the dialog completely.
                  onPressed: () => DialogNavigator.of(context).close(),
                  icon: const Icon(Icons.close),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            Text(
              'Fluid Dialog Demo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text(placeholder)
          ],
        ),
      ),
    );
  }
}
