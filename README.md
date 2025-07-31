# GetX Navigation

A powerful and flexible navigation package for Flutter applications built on top of GetX ecosystem. This package provides context-free navigation, route management, dialogs, bottom sheets, and snackbars with beautiful animations and transitions.

## Features

- **Context-Free Navigation**: Navigate without BuildContext using Get.to(), Get.off(), Get.back()
- **Advanced Route Management**: Named routes, nested routing, route middleware, and route observers
- **Custom Transitions**: 16+ built-in transition animations with custom transition support
- **Dialog System**: Material and Cupertino dialogs with custom styling and animations
- **Bottom Sheets**: Customizable bottom sheets with gesture controls and animations
- **Snackbar System**: Rich snackbars with progress indicators, actions, and custom styling
- **Route Middleware**: Implement authentication, logging, and custom logic before route changes
- **Nested Navigation**: Support for nested navigators and complex navigation hierarchies
- **Web Support**: Full web navigation support with URL management
- **Type Safety**: Strongly typed route parameters and return values

## Getting Started

### Prerequisites

- Flutter SDK: >=1.17.0
- Dart SDK: ^3.8.1

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  getx_navigation:
    git:
      url: https://github.com/loqmanali/getx_navigation.git
```

Then run:

```bash
flutter pub get
```

### Basic Setup

Replace your `MaterialApp` with `GetMaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:getx_navigation/getx_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation Demo',
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/second', page: () => SecondScreen()),
        GetPage(name: '/third', page: () => ThirdScreen()),
      ],
    );
  }
}
```

## Core Navigation

### Basic Navigation

```dart
// Navigate to a new screen
Get.to(() => SecondScreen());

// Navigate and remove current screen from stack
Get.off(() => SecondScreen());

// Navigate and clear all previous routes
Get.offAll(() => HomeScreen());

// Go back to previous screen
Get.back();

// Go back with result
Get.back(result: "Hello from second screen");
```

### Named Route Navigation

```dart
// Navigate using named routes
Get.toNamed('/second');

// Navigate with parameters
Get.toNamed('/user', parameters: {'id': '123', 'name': 'John'});

// Navigate with arguments
Get.toNamed('/profile', arguments: {'user': userObject});

// Replace current route
Get.offNamed('/login');

// Clear stack and navigate
Get.offAllNamed('/home');
```

### Navigation with Transitions

```dart
// Navigate with custom transition
Get.to(
  () => SecondScreen(),
  transition: Transition.rightToLeft,
  duration: Duration(milliseconds: 300),
);

// Available transitions:
// - fade, fadeIn
// - rightToLeft, leftToRight
// - upToDown, downToUp
// - rightToLeftWithFade, leftToRightWithFade
// - zoom, size
// - circularReveal
// - cupertino, cupertinoDialog
// - native, noTransition
```

## Route Configuration

### Defining Routes

```dart
class AppPages {
  static const INITIAL = Routes.HOME;
  
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}

class Routes {
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
}
```

### Route Parameters and Arguments

```dart
// Accessing route parameters
class UserController extends GetxController {
  void onInit() {
    super.onInit();
    
    // Get parameters from URL (/user?id=123&name=John)
    String userId = Get.parameters['id'] ?? '';
    String userName = Get.parameters['name'] ?? '';
    
    // Get arguments passed during navigation
    Map<String, dynamic> args = Get.arguments ?? {};
  }
}

// Navigate with parameters
Get.toNamed('/user?id=123&name=John');

// Navigate with arguments
Get.toNamed('/user', arguments: {'userData': user});
```

## Dialogs

### Basic Dialog

```dart
// Simple alert dialog
Get.dialog(
  AlertDialog(
    title: Text('Alert'),
    content: Text('This is a simple dialog'),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text('OK'),
      ),
    ],
  ),
);
```

### Default Dialog

```dart
// Pre-styled dialog with confirm/cancel buttons
Get.defaultDialog(
  title: 'Delete Item',
  middleText: 'Are you sure you want to delete this item?',
  textConfirm: 'Delete',
  textCancel: 'Cancel',
  confirmTextColor: Colors.white,
  onConfirm: () {
    // Delete logic here
    Get.back();
  },
  onCancel: () => Get.back(),
);
```

### Custom Dialog with Animations

```dart
// Dialog with custom transition
Get.dialog(
  CustomDialog(),
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.easeInOut,
  barrierDismissible: false,
);
```

## Bottom Sheets

### Basic Bottom Sheet

```dart
// Simple bottom sheet
Get.bottomSheet(
  Container(
    height: 200,
    color: Colors.white,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.music_note),
          title: Text('Music'),
          onTap: () => Get.back(),
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Video'),
          onTap: () => Get.back(),
        ),
      ],
    ),
  ),
);
```

### Advanced Bottom Sheet

```dart
// Bottom sheet with custom styling and behavior
Get.bottomSheet(
  BottomSheetContent(),
  backgroundColor: Colors.white,
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  isScrollControlled: true,
  enableDrag: true,
  isDismissible: true,
  enterBottomSheetDuration: Duration(milliseconds: 250),
  exitBottomSheetDuration: Duration(milliseconds: 200),
);
```

## Snackbars

### Basic Snackbar

```dart
// Simple snackbar
Get.snackbar(
  'Title',
  'This is a snackbar message',
  snackPosition: SnackPosition.BOTTOM,
);
```

### Advanced Snackbar

```dart
// Rich snackbar with custom styling
Get.snackbar(
  'Success',
  'Operation completed successfully',
  icon: Icon(Icons.check_circle, color: Colors.white),
  snackPosition: SnackPosition.TOP,
  backgroundColor: Colors.green,
  borderRadius: 20,
  margin: EdgeInsets.all(15),
  colorText: Colors.white,
  duration: Duration(seconds: 4),
  isDismissible: true,
  dismissDirection: DismissDirection.horizontal,
  forwardAnimationCurve: Curves.easeOutBack,
);
```

### Snackbar with Action Button

```dart
// Snackbar with action button
Get.snackbar(
  'Item Deleted',
  'The item has been moved to trash',
  mainButton: TextButton(
    onPressed: () {
      // Undo logic here
      Get.back();
    },
    child: Text('UNDO', style: TextStyle(color: Colors.white)),
  ),
  backgroundColor: Colors.red,
  colorText: Colors.white,
);
```

### Snackbar with Progress Indicator

```dart
// Snackbar with progress indicator
Get.snackbar(
  'Uploading',
  'Please wait while we upload your file',
  showProgressIndicator: true,
  progressIndicatorBackgroundColor: Colors.white,
  progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
  duration: Duration(seconds: 5),
);
```

## Route Middleware

### Creating Middleware

```dart
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Check if user is authenticated
    if (!AuthService.isLoggedIn) {
      return RouteSettings(name: '/login');
    }
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('Page ${page?.name} was called');
    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // Initialize bindings before page loads
    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('Page building started');
    return super.onPageBuildStart(page);
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Page built successfully');
    return super.onPageBuilt(page);
  }

  @override
  void onPageDispose() {
    print('Page disposed');
    super.onPageDispose();
  }
}
```

### Applying Middleware

```dart
GetPage(
  name: '/protected',
  page: () => ProtectedView(),
  middlewares: [
    AuthMiddleware(),
    LoggingMiddleware(),
  ],
),
```

## Nested Navigation

### Setting Up Nested Routes

```dart
class NestedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/dashboard',
      getPages: [
        GetPage(
          name: '/dashboard',
          page: () => DashboardView(),
          children: [
            GetPage(
              name: '/profile',
              page: () => ProfileView(),
            ),
            GetPage(
              name: '/settings',
              page: () => SettingsView(),
            ),
          ],
        ),
      ],
    );
  }
}
```

### Navigating in Nested Routes

```dart
// Navigate to nested route
Get.toNamed('/dashboard/profile');

// Navigate within nested navigator
Get.toNamed('/profile', id: 1); // id specifies the nested navigator
```

## Advanced Features

### Custom Transitions

```dart
class CustomTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve ?? Curves.easeInOut,
      )),
      child: child,
    );
  }
}

// Use custom transition
GetPage(
  name: '/custom',
  page: () => CustomView(),
  customTransition: CustomTransition(),
  transitionDuration: Duration(milliseconds: 400),
),
```

### Route Observers

```dart
class MyRouteObserver extends GetObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('Route popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }
}

// Add observer to GetMaterialApp
GetMaterialApp(
  navigatorObservers: [MyRouteObserver()],
  // ... other properties
)
```

### Bindings

```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<ApiService>(ApiService());
  }
}

// Use with routes
GetPage(
  name: '/home',
  page: () => HomeView(),
  binding: HomeBinding(),
),
```

## Best Practices

### 1. Route Organization

```dart
// Create a dedicated routes file
class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile/:id';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    // ... other routes
  ];
}
```

### 2. Error Handling

```dart
// Handle navigation errors
try {
  await Get.toNamed('/some-route');
} catch (e) {
  Get.snackbar('Error', 'Navigation failed: $e');
}

// Unknown route handling
GetPage(
  name: '/404',
  page: () => NotFoundView(),
),

// Set unknown route in GetMaterialApp
GetMaterialApp(
  unknownRoute: GetPage(
    name: '/notfound',
    page: () => NotFoundView(),
  ),
)
```

### 3. Performance Optimization

```dart
// Use lazy loading for heavy pages
GetPage(
  name: '/heavy-page',
  page: () => HeavyPageView(),
  binding: BindingsBuilder(() {
    Get.lazyPut<HeavyController>(() => HeavyController());
  }),
),

// Prevent duplicate routes
GetPage(
  name: '/profile',
  page: () => ProfileView(),
  preventDuplicates: true,
),
```

## Testing

### Unit Testing Navigation

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_navigation/getx_navigation.dart';

void main() {
  group('Navigation Tests', () {
    testWidgets('should navigate to second screen', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomeScreen(),
          getPages: [
            GetPage(name: '/second', page: () => SecondScreen()),
          ],
        ),
      );

      // Trigger navigation
      Get.toNamed('/second');
      await tester.pumpAndSettle();

      // Verify navigation
      expect(find.byType(SecondScreen), findsOneWidget);
    });
  });
}
```

## Migration Guide

### From Flutter Navigator

```dart
// Before (Flutter Navigator)
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => SecondScreen()),
);

// After (GetX Navigation)
Get.to(() => SecondScreen());

// Before (Named routes)
Navigator.of(context).pushNamed('/second');

// After (GetX Navigation)
Get.toNamed('/second');
```

## Troubleshooting

### Common Issues

1. **Context not found**: Make sure you're using `GetMaterialApp` instead of `MaterialApp`
2. **Routes not working**: Ensure route names start with '/'
3. **Bindings not loading**: Check that bindings are properly defined in GetPage
4. **Middleware not executing**: Verify middleware priority and return values

### Debug Mode

```dart
// Enable debug mode for detailed logs
GetMaterialApp(
  enableLog: true,
  logWriterCallback: (text, {isError = false}) {
    print('GetX Log: $text');
  },
)
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:

- Create an issue on [GitHub](https://github.com/loqmanali/getx_navigation/issues)
- Check the [documentation](https://github.com/loqmanali/getx_navigation)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes and updates.
