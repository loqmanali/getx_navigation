import 'package:flutter/material.dart';
import 'package:getx_core/getx_core.dart';
import 'package:getx_navigation/getx_navigation.dart';

/// Helper function to create a BottomNavigationBar shell route
/// This provides the same functionality as go_router's ShellRoute with BottomNavigationBar
GetShellRoute createBottomNavigationShell({
  required String name,
  required List<BottomNavigationBarItem> items,
  required List<GetPage> shellChildren,
  required int Function() getCurrentIndex,
  required void Function(int index) onTap,
  BottomNavigationBarType? type,
  Color? backgroundColor,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  double? elevation,
  double? iconSize,
  TextStyle? selectedLabelStyle,
  TextStyle? unselectedLabelStyle,
  bool showSelectedLabels = true,
  bool showUnselectedLabels = true,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  return GetShellRoute(
    name: name,
    shellBuilder: (context, child) => Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: getCurrentIndex(),
        onTap: onTap,
        type: type,
        backgroundColor: backgroundColor,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        elevation: elevation,
        iconSize: iconSize ?? 24.0,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
      ),
    ),
    shellChildren: shellChildren,
    navigatorKey: navigatorKey,
  );
}

/// Helper widget for creating bottom navigation route builders
/// This helps manage the current route index for bottom navigation
class BottomNavigationRouteBuilder extends StatelessWidget {
  final List<String> routes;
  final Widget Function(BuildContext context, List<String> routes, int index)
  builder;

  const BottomNavigationRouteBuilder({
    super.key,
    required this.routes,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // Get current route from GetX
    final currentLocation = Get.currentRoute;
    final currentIndex = _getCurrentIndex(currentLocation);

    return builder(context, routes, currentIndex);
  }

  /// Method to get the current index based on the route
  int _getCurrentIndex(String currentLocation) {
    for (int i = 0; i < routes.length; i++) {
      if (currentLocation.startsWith(routes[i])) {
        return i;
      }
    }
    return 0; // Default to first route if no match
  }
}
