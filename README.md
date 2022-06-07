![yee](https://res.craft.do/user/preview/917c5358-5da1-1082-14ff-e4d6be9afe52/79d4bf03-09a6-49b2-862e-fc00a2bdc2e4)

# Fluid Dialog

A dialog that can switch between multiple contents and animates size and alignment dynamically.

### Video Demo

![example_2022-06-07_16-20-48_AdobeExpress.gif](https://res.craft.do/user/full/917c5358-5da1-1082-14ff-e4d6be9afe52/doc/0fff026c-74c7-498a-bd9a-55fbe241dbaa/5f1fcee7-3a1f-465f-8c47-1dd420e043c1)

### Features

- Navigate between different pages
- Animated size and alignment
- Fully customizable

### Usage

To show a FluidDialog you typically use flutters `showDialog` function. You can also use your own implementation to show the dialog.

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

To **navigate** in the dialog, use the `DialogNavigator`. It works similar to the flutter navigator.

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
