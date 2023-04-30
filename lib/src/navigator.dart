import 'package:flutter/widgets.dart';

/// {@template dialog_navigator_provider_docs}
/// This widget provides a [DialogNavigator] to its children.
///
/// This allows you to call the [DialogNavigator]
/// with `DialogNavigator.of(context)`.
///
/// See also:
/// - [DialogNavigator] for more information about navigating a dialog.
/// - [FluidDialogPage] for creating pages for a dialog.
/// - `FluidDialog` for creating a dialog.
/// {@endtemplate}
class DialogNavigatorProvider extends InheritedWidget {
  /// {@macro dialog_navigator_provider_docs}
  const DialogNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  });

  /// The [DialogNavigator] provided by this widget.
  final DialogNavigator navigator;

  /// The state from the closest instance of this
  /// class that encloses the given context.
  static DialogNavigatorProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<DialogNavigatorProvider>();
    assert(result != null, 'No DialogNavigatorProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DialogNavigatorProvider oldWidget) =>
      navigator != oldWidget.navigator;
}

/// {@template dialog_navigator_docs}
/// This class is used to navigate a `FluidDialog`
///
/// This can be used to add or remove pages and set the alignment of the dialog.
///
/// [push] and [pop] are can be used for this.
///
/// {@macro dialog_navigator_example}
/// {@endtemplate}
class DialogNavigator {
  /// {@macro dialog_navigator_docs}
  const DialogNavigator({
    required this.pages,
    required this.context,
  });

  /// The pages stored in the navigation stack.
  ///
  /// This should not be changed manually. Use [push] and [pop] instead.
  final ValueNotifier<List<FluidDialogPage>> pages;

  /// `BuildContext` used for navigation.
  final BuildContext context;

  /// Gets the next [DialogNavigator] from the context.
  ///
  /// This should only be used in a [FluidDialogPage] or
  /// when a [DialogNavigatorProvider] is manually added to the widget tree.
  ///
  /// For info how to use this, see [DialogNavigator].
  static DialogNavigator of(BuildContext context) {
    return DialogNavigatorProvider.of(context).navigator;
  }

  /// Pushes a new [FluidDialogPage] onto the navigation stack.
  ///
  /// Size and alignment will be changed automatically.
  ///
  /// {@template dialog_navigator_example}
  /// **Example:**
  /// ```dart
  /// DialogNavigator.of(context).push(
  ///   FluidDialogPage(
  ///     builder: (context) => Text('Gday'),
  ///  ),
  /// );
  /// ```
  /// {@endtemplate}
  void push(FluidDialogPage page) {
    pages.value = pages.value.toList()..add(page);
  }

  /// Goes back one page.
  ///
  /// Size and alignment will be changed automatically.
  void pop() {
    pages.value = pages.value.toList()..removeLast();
  }

  /// Closes the entire dialog.
  ///
  /// Same as using `Navigator.of(context).pop();`
  void close() {
    Navigator.of(context).pop();
  }

  /// Returns the widget of the last page and wraps it in a [Builder].
  Widget getCurrentWidget() {
    try {
      return Builder(
        builder: (context) => pages.value.last.builder(context),
      );
      // ignore: avoid_catching_errors
    } on StateError {
      throw Exception(
        // ignore: lines_longer_than_80_chars
        'No widget found in pages. Make sure that there is at least one element in the pages list.',
      );
    }
  }
}

/// {@template fluid_dialog_page}
/// A page for the `FluidDialog`.
///
/// This contains the widget shown in the dialog
/// and the alignment of the dialog.
/// {@endtemplate}
class FluidDialogPage {
  /// {@macro fluid_dialog_page}
  const FluidDialogPage({
    required this.builder,
    this.decoration,
    this.alignment = Alignment.center,
  });

  /// A builder for the widget shown in the dialog.
  ///
  /// The `context` contains a [DialogNavigator],
  /// which you can access with `DialogNavigator.of(context)`.
  ///
  /// This can be used to push new pages to the dialog.
  final Widget Function(BuildContext context) builder;

  /// The alignment of the dialog.
  ///
  /// This is `Alignment.center` by default.
  final Alignment alignment;

  /// The [Decoration] used for this page.
  ///
  /// Typically a [BoxDecoration].
  final Decoration? decoration;
}
