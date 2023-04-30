import 'package:fluid_dialog/src/navigator.dart';
import 'package:flutter/material.dart';

/// {@template fluid_dialog_docs}
/// A dialog that  can switch between multiple contents
/// and animates size and alignment dynamically.
///
/// You can control the dialog with the [DialogNavigator].
/// To use it, get it from the context: `DialogNavigator.of(context)`.
///
/// The content of the dialog is stored in [FluidDialogPage]s.
/// The [rootPage] is the first page in the navigation stack.
/// To change pages and alignment use the [DialogNavigator].
///
/// The size of the dialog is determined by its child elements.
///
/// **Example:**
/// ```dart
/// //Shows a simple dialog.
/// showDialog(
///  context: context,
///  builder: (context) => FluidDialog(
///   // Set the first page of the dialog.
///   rootPage: FluidDialogPage(
///     alignment: Alignment.bottomLeft, //Aligns the dialog to the bottom left.
///     builder: (context) => const TestDialog(), // This can be any widget.
///   ),
///  ),
/// );
///
/// ```
///
/// See also:
/// - [DialogNavigator] for more information about navigating a dialog.
/// - [FluidDialogPage] for creating pages for a dialog.
/// {@endtemplate}
class FluidDialog extends StatelessWidget {
  /// {@macro fluid_dialog_docs}
  const FluidDialog({
    required this.rootPage,
    super.key,
    this.edgePadding = const EdgeInsets.all(12),
    this.alignmentDuration = const Duration(milliseconds: 500),
    this.alignmentCurve = const Cubic(0.2, 0, 0, 1),
    this.sizeDuration = const Duration(milliseconds: 300),
    this.sizeCurve = const Cubic(0.2, 0, 0, 1),
    this.transitionBuilder,
    this.transitionDuration = const Duration(milliseconds: 600),
    this.reverseTransitionDuration = const Duration(milliseconds: 100),
    this.transitionCurve = Curves.easeInOutCubicEmphasized,
    this.reverseTransitionCurve = Curves.easeInOutCubicEmphasized,
    this.defaultDecoration,
  });

  /// The initial page that is shown by the dialog.
  /// This page is shown when the dialog is first created.
  ///
  /// See also:
  /// - [DialogNavigator] for opening pages within a dialog.
  /// - [FluidDialogPage] for creating pages for a dialog.
  final FluidDialogPage rootPage;

  /// The minimum padding on the edges of the screen.
  /// Limits the size of the dialog.
  ///
  /// When this is 0, the dialog can take up the entire screen.
  final EdgeInsetsGeometry edgePadding;

  /// The time it takes for the dialog to change its alignment.
  ///
  /// See also:
  /// - [FluidDialogPage] for setting the alignment of the dialog.
  final Duration alignmentDuration;

  /// The [Curve] used by the alignment animation.
  final Curve alignmentCurve;

  /// The time it takes for the dialog to change its size.
  final Duration sizeDuration;

  /// The [Curve] used by the size change animation.
  final Curve sizeCurve;

  /// The time it takes for the new page to appear.
  final Duration transitionDuration;

  /// The time it takes for the old page to disappear.
  final Duration reverseTransitionDuration;

  /// The [Curve] used for the animation of the appearing page.
  final Curve transitionCurve;

  /// The [Curve] used for the animation of the disappearing page.
  final Curve reverseTransitionCurve;

  /// A builder for the transition used to switch between the different pages.
  ///
  /// This uses a [ZoomPageTransitionsBuilder] by default.
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  /// The default style of the dialog.
  ///
  /// Typically a [BoxDecoration].
  final Decoration? defaultDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgePadding,
      child: DialogNavigatorProvider(
        navigator: DialogNavigator(
          context: context,
          pages: ValueNotifier([rootPage]),
        ),
        // Builder used to get new context for DialogNavigatorProvider.
        child: Builder(
          builder: (context) {
            return ValueListenableBuilder(
              valueListenable: DialogNavigator.of(context).pages,
              builder: (context, List<FluidDialogPage> value, child) {
                final page = value.last;

                return AnimatedAlign(
                  duration: alignmentDuration,
                  curve: alignmentCurve,
                  alignment: page.alignment,
                  child: Material(
                    borderOnForeground: false,
                    color: Colors.transparent,
                    child: AnimatedContainer(
                      duration: transitionDuration,
                      curve: transitionCurve,
                      decoration: page.decoration ??
                          defaultDecoration ??
                          BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                      child: AnimatedSize(
                        duration: sizeDuration,
                        curve: sizeCurve,
                        reverseDuration: sizeDuration,
                        child: AnimatedSwitcher(
                          duration: transitionDuration,
                          reverseDuration: reverseTransitionDuration,
                          switchInCurve: transitionCurve,
                          switchOutCurve: reverseTransitionCurve,
                          transitionBuilder: transitionBuilder ??
                              (child, animation) {
                                // Use default animation
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },

                          // Use the current page from the DialogNavigator
                          child: page.builder(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
