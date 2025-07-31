# GetX Navigation ShellRoute Feature

This feature provides support for multiple Navigators via ShellRoute, similar to `go_router`'s ShellRoute functionality. You can display an inner Navigator that displays its own pages based on the matched route, with a persistent BottomNavigationBar that stays visible at the bottom of the screen.

## Features

- **GetShellRoute**: A route that can contain child routes with a persistent shell widget
- **BottomNavigationBar Support**: Helper functions to easily create persistent bottom navigation
- **Multiple Navigator Support**: Each shell can have its own Navigator instance
- **Compatible with existing GetX Navigation**: Doesn't break any existing functionality

## Usage

### Basic ShellRoute

```dart
GetShellRoute(
  name: '/shell',
  shellBuilder: (context, child) => Scaffold(
    body: child,
    bottomNavigationBar: BottomNavigationBar(
      // Your bottom navigation configuration
    ),
  ),
  shellChildren: [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/search', page: () => SearchPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ],
)
```

### Using the Helper Function

```dart
createBottomNavigationShell(
  name: '/shell',
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
  getCurrentIndex: () => _currentIndex,
  onTap: (index) {
    setState(() => _currentIndex = index);
    // Navigate to corresponding route
    switch (index) {
      case 0: Get.toNamed('/home'); break;
      case 1: Get.toNamed('/search'); break;
      case 2: Get.toNamed('/profile'); break;
    }
  },
  shellChildren: [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/search', page: () => SearchPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ],
)
```

### Complete Example

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        createBottomNavigationShell(
          name: '/shell',
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          getCurrentIndex: () => _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 0: Get.toNamed('/home'); break;
              case 1: Get.toNamed('/search'); break;
              case 2: Get.toNamed('/profile'); break;
            }
          },
          shellChildren: [
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/search', page: () => SearchPage()),
            GetPage(name: '/profile', page: () => ProfilePage()),
          ],
        ),
      ],
    );
  }
}
```

## API Reference

### GetShellRoute

A route that provides a shell around child routes.

**Properties:**

- `name`: The route name
- `shellBuilder`: Function that builds the shell widget around child pages
- `shellChildren`: List of child routes that will be displayed within the shell
- `navigatorKey`: Optional navigator key for the shell's navigator

### createBottomNavigationShell

Helper function to create a shell route with BottomNavigationBar.

**Parameters:**

- `name`: Route name
- `items`: List of BottomNavigationBarItem
- `getCurrentIndex`: Function that returns the current selected index
- `onTap`: Callback when a tab is tapped
- `shellChildren`: List of child routes
- `type`, `backgroundColor`, `selectedItemColor`, etc.: Standard BottomNavigationBar properties

### BottomNavigationRouteBuilder

Helper widget for managing route-based navigation state.

**Properties:**

- `routes`: List of route paths
- `builder`: Function that builds the widget based on current route and index

## Migration from go_router

If you're coming from `go_router`, the migration is straightforward:

**go_router ShellRoute:**

```dart
ShellRoute(
  builder: (context, state, child) => ScaffoldWithNavBar(child: child),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/search', builder: (context, state) => SearchPage()),
  ],
)
```

**GetX Navigation equivalent:**

```dart
GetShellRoute(
  name: '/shell',
  shellBuilder: (context, child) => ScaffoldWithNavBar(child: child),
  shellChildren: [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/search', page: () => SearchPage()),
  ],
)
```

## Notes

- This feature is fully compatible with existing GetX Navigation functionality
- No breaking changes to existing code
- Supports all standard GetX Navigation features like middleware, transitions, etc.
- The shell widget persists across route changes within the shell
- Each shell maintains its own Navigator instance
