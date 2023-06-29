![cover](https://github.com/RoundedInfinity/fluid_dialog/blob/main/images/cover.png?raw=true)

# Fluid Dialog

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A dialog that can switch between multiple contents and animates size and alignment dynamically.

### Video Demo

![video demo](https://github.com/RoundedInfinity/fluid_dialog/blob/main/images/video.gif?raw=true)

### Features 🎉

- Navigate between different pages
- Animated size and alignment
- Fully customizable

### Usage 🧪

To show a FluidDialog you typically use Flutter's `showDialog` function. You can also use your implementation to show the dialog.

Here's an example:

```dart
showDialog(
 context: context,
 builder: (context) => FluidDialog(
  // Set the first page of the dialog.
  rootPage: FluidDialogPage(
    alignment: Alignment.bottomLeft, //Aligns the dialog to the bottom left.
    builder: (context) => const TestDialog(), // This can be any widget.
  ),
 ),
);
```

To **navigate** in the dialog, use the `DialogNavigator`. It works similarly to the flutter navigator.

This only works for widgets in the FluidDialog

```dart
TextButton(
  onPressed: () => DialogNavigator.of(context).push(
    FluidDialogPage(
      builder: (context) => const SecondDialogPage(),
    ),
  ),
  child: const Text('Go to next page'),
),
```

Take a look at the [example](https://github.com/RoundedInfinity/fluid_dialog/blob/main/example/lib/main.dart) or [demo](https://github.com/RoundedInfinity/fluid_dialog/blob/main/example/lib/demo.dart) for more code.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
