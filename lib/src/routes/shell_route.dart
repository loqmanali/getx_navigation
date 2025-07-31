import 'package:flutter/material.dart';
import 'package:getx_navigation/getx_navigation.dart';

/// A shell route that provides a persistent UI shell around child routes.
/// Similar to go_router's ShellRoute, this allows displaying a persistent
/// navigation structure (like BottomNavigationBar) that remains visible
/// while navigating between child routes.
class GetShellRoute extends GetPage {
  /// The builder function that creates the shell UI.
  /// This typically contains persistent navigation elements like
  /// BottomNavigationBar, AppBar, or side navigation.
  final Widget Function(BuildContext context, Widget child) shellBuilder;

  /// List of child routes that will be displayed within this shell.
  /// These routes will be rendered inside the shell's child widget.
  final List<GetPage> shellChildren;

  /// Optional navigator key for the shell's inner navigator.
  /// If not provided, a default key will be generated.
  final GlobalKey<NavigatorState>? navigatorKey;

  static void _defaultPopInvokedHandler(bool didPop, Object? result) {}

  GetShellRoute({
    required super.name,
    required this.shellBuilder,
    required this.shellChildren,
    this.navigatorKey,
    bool super.participatesInRootNavigator = false,
    super.title,
    super.parameters,
    super.transition,
    super.curve,
    super.alignment,
    super.maintainState,
    super.opaque,
    super.binding,
    super.bindings,
    super.customTransition,
    super.transitionDuration,
    super.reverseTransitionDuration,
    super.fullscreenDialog,
    super.middlewares,
    super.unknownRoute,
    super.arguments,
    super.showCupertinoParallax,
    super.preventDuplicates,
    super.preventDuplicateHandlingMode,
    super.completer,
    super.inheritParentPath,
    super.canPop,
    PopInvokedWithResultCallback? onPopInvoked,
    super.restorationId,
    super.key,
  }) : super(
         page: () => _ShellRouteWidget(
           shellBuilder: shellBuilder,
           navigatorKey: navigatorKey,
           shellChildren: shellChildren,
         ),
         children: shellChildren,
         onPopInvoked: onPopInvoked ?? _defaultPopInvokedHandler,
       );
}

/// Internal widget that handles the shell route rendering
class _ShellRouteWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Widget child) shellBuilder;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<GetPage> shellChildren;

  const _ShellRouteWidget({
    required this.shellBuilder,
    required this.navigatorKey,
    required this.shellChildren,
  });

  @override
  Widget build(BuildContext context) {
    return shellBuilder(
      context,
      GetRouterOutlet.pickPages(
        navigatorKey: navigatorKey,
        pickPages: (config) {
          // Find the current route within shell children
          final currentRoute = config.currentTreeBranch.lastWhere(
            (page) => shellChildren.any((child) => child.name == page.name),
            orElse: () => shellChildren.first,
          );

          // Return the matching child route
          return [currentRoute];
        },
        emptyPage: (delegate) => shellChildren.first,
      ),
    );
  }
}
