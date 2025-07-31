# GetX Navigation API Documentation

This document provides comprehensive API documentation for the GetX Navigation package.

## Table of Contents

- [Core Navigation API](#core-navigation-api)
- [Route Configuration API](#route-configuration-api)
- [Dialog API](#dialog-api)
- [Bottom Sheet API](#bottom-sheet-api)
- [Snackbar API](#snackbar-api)
- [Middleware API](#middleware-api)
- [Transition API](#transition-api)
- [Observer API](#observer-api)

## Core Navigation API

### Get Class Methods

#### Navigation Methods

```dart
// Navigate to a new screen
static Future<T?> to<T>(
  Widget Function() page, {
  bool? opaque,
  Transition? transition,
  Curve? curve,
  Duration? duration,
  int? id,
  String? routeName,
  bool fullscreenDialog = false,
  Object? arguments,
  List<BindingsInterface> bindings = const [],
  bool preventDuplicates = true,
  PopGestureEnable? popGesture,
  double Function(BuildContext context)? gestureWidth,
})

// Navigate and remove current screen
static Future<T?> off<T>(
  Widget Function() page, {
  bool? opaque,
  Transition? transition,
  Curve? curve,
  Duration? duration,
  int? id,
  String? routeName,
  bool fullscreenDialog = false,
  Object? arguments,
  List<BindingsInterface> bindings = const [],
  bool preventDuplicates = true,
  PopGestureEnable? popGesture,
  double Function(BuildContext context)? gestureWidth,
})

// Navigate and clear all previous routes
static Future<T?> offAll<T>(
  Widget Function() page, {
  bool Function(Route<dynamic>)? predicate,
  bool? opaque,
  Transition? transition,
  Curve? curve,
  Duration? duration,
  int? id,
  String? routeName,
  bool fullscreenDialog = false,
  Object? arguments,
  List<BindingsInterface> bindings = const [],
  bool preventDuplicates = true,
  PopGestureEnable? popGesture,
  double Function(BuildContext context)? gestureWidth,
})

// Go back to previous screen
static void back<T>({
  T? result,
  bool closeOverlays = false,
  bool canPop = true,
  int? id,
})

// Close current screen until predicate returns true
static void until(RoutePredicate predicate, {int? id})

// Navigate using named routes
static Future<T?> toNamed<T>(
  String page, {
  Object? arguments,
  int? id,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
})

// Replace current route with named route
static Future<T?> offNamed<T>(
  String page, {
  Object? arguments,
  int? id,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
})

// Clear all routes and navigate to named route
static Future<T?> offAllNamed<T>(
  String newRouteName, {
  RoutePredicate? predicate,
  Object? arguments,
  int? id,
  Map<String, String>? parameters,
})
```

#### Route Information

```dart
// Get current route name
static String? get currentRoute

// Get previous route name
static String? get previousRoute

// Get route arguments
static dynamic get arguments

// Get route parameters
static Map<String, String> get parameters

// Check if can go back
static bool get canPop

// Get routing history
static List<String> get routingHistory
```

## Route Configuration API

### GetPage Class

```dart
class GetPage<T> extends Page<T> {
  GetPage({
    required String name,
    required GetPageBuilder page,
    String? title,
    bool? participatesInRootNavigator,
    double Function(BuildContext context)? gestureWidth,
    bool maintainState = true,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Map<String, String>? parameters,
    bool opaque = true,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? popGesture,
    BindingsInterface? binding,
    List<BindingsInterface> bindings = const [],
    List<Bind> binds = const [],
    Transition? transition,
    CustomTransition? customTransition,
    bool fullscreenDialog = false,
    List<GetPage> children = const <GetPage>[],
    List<GetMiddleware> middlewares = const [],
    GetPage? unknownRoute,
    Object? arguments,
    bool showCupertinoParallax = true,
    bool preventDuplicates = true,
    PreventDuplicateHandlingMode preventDuplicateHandlingMode = PreventDuplicateHandlingMode.reorderRoutes,
    Completer<T?>? completer,
    bool inheritParentPath = true,
    LocalKey? key,
    bool? canPop,
    PopInvokedWithResultCallback<T>? onPopInvoked,
    String? restorationId,
  })
}
```

### GetMaterialApp Configuration

```dart
class GetMaterialApp extends StatelessWidget {
  GetMaterialApp({
    Key? key,
    GlobalKey<NavigatorState>? navigatorKey,
    Widget? home,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    RouteFactory? onGenerateRoute,
    InitialRouteListFactory? onGenerateInitialRoutes,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver>? navigatorObservers,
    TransitionBuilder? builder,
    String title = '',
    GenerateAppTitle? onGenerateTitle,
    Color? color,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    LocaleListResolutionCallback? localeListResolutionCallback,
    LocaleResolutionCallback? localeResolutionCallback,
    Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
    bool debugShowMaterialGrid = false,
    bool showPerformanceOverlay = false,
    bool checkerboardRasterCacheImages = false,
    bool checkerboardOffscreenLayers = false,
    bool showSemanticsDebugger = false,
    bool debugShowCheckedModeBanner = true,
    Map<LogicalKeySet, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    String? restorationScopeId,
    ScrollBehavior? scrollBehavior,
    
    // GetX specific properties
    List<GetPage>? getPages,
    GetPage? unknownRoute,
    RouteInformationProvider? routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    BackButtonDispatcher? backButtonDispatcher,
    bool enableLog = kDebugMode,
    LogWriterCallback? logWriterCallback,
    bool popGesture = GetPlatform.isIOS,
    SmartManagement smartManagement = SmartManagement.full,
    List<BindingsInterface> initialBinding = const [],
    Locale? fallbackLocale,
    Class? translationsKeys,
    Translations? translations,
    bool defaultPopGesture = GetPlatform.isIOS,
    bool defaultOpaqueRoute = true,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    List<GetMiddleware>? routingCallback,
    Transition? defaultTransition,
    VoidCallback? onInit,
    VoidCallback? onReady,
    VoidCallback? onDispose,
    bool? enableLog,
    bool? popGesture,
    SmartManagement? smartManagement,
    BindingsInterface? initialBinding,
  })
}
```

## Dialog API

### Get.dialog Method

```dart
static Future<T?> dialog<T>(
  Widget widget, {
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useSafeArea = true,
  GlobalKey<NavigatorState>? navigatorKey,
  Object? arguments,
  Duration? transitionDuration,
  Curve? transitionCurve,
  String? name,
  RouteSettings? routeSettings,
  String? id,
})
```

### Get.defaultDialog Method

```dart
static Future<T?> defaultDialog<T>({
  String title = "Alert",
  EdgeInsetsGeometry? titlePadding,
  TextStyle? titleStyle,
  Widget? content,
  String? id,
  EdgeInsetsGeometry? contentPadding,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  VoidCallback? onCustom,
  Color? cancelTextColor,
  Color? confirmTextColor,
  String? textConfirm,
  String? textCancel,
  String? textCustom,
  Widget? confirm,
  Widget? cancel,
  Widget? custom,
  Color? backgroundColor,
  bool barrierDismissible = true,
  Color? buttonColor,
  String middleText = "\n",
  TextStyle? middleTextStyle,
  double radius = 20.0,
  List<Widget>? actions,
  PopInvokedWithResultCallback<T>? onWillPop,
  GlobalKey<NavigatorState>? navigatorKey,
})
```

### Get.generalDialog Method

```dart
static Future<T?> generalDialog<T>({
  required RoutePageBuilder pageBuilder,
  bool barrierDismissible = false,
  String? barrierLabel,
  Color barrierColor = const Color(0x80000000),
  Duration transitionDuration = const Duration(milliseconds: 200),
  RouteTransitionsBuilder? transitionBuilder,
  GlobalKey<NavigatorState>? navigatorKey,
  RouteSettings? routeSettings,
  String? id,
})
```

## Bottom Sheet API

### Get.bottomSheet Method

```dart
static Future<T?> bottomSheet<T>(
  Widget bottomsheet, {
  Color? backgroundColor,
  double? elevation,
  bool persistent = true,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool? ignoreSafeArea,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? settings,
  Duration? enterBottomSheetDuration,
  Duration? exitBottomSheetDuration,
  Curve? curve,
})
```

## Snackbar API

### Get.snackbar Method

```dart
static GetSnackBar snackbar(
  String title,
  String message, {
  Color? colorText,
  Duration? duration = const Duration(seconds: 3),
  SnackPosition? snackPosition,
  Widget? titleText,
  Widget? messageText,
  Widget? icon,
  bool? shouldIconPulse,
  double? maxWidth,
  EdgeInsets? margin,
  EdgeInsets? padding,
  double? borderRadius,
  Color? borderColor,
  double? borderWidth,
  Color? backgroundColor,
  Color? leftBarIndicatorColor,
  List<BoxShadow>? boxShadows,
  Gradient? backgroundGradient,
  Widget? mainButton,
  OnTap? onTap,
  OnHover? onHover,
  bool? isDismissible,
  bool? showProgressIndicator,
  DismissDirection? dismissDirection,
  AnimationController? progressIndicatorController,
  Color? progressIndicatorBackgroundColor,
  Animation<Color>? progressIndicatorValueColor,
  SnackStyle? snackStyle,
  Curve? forwardAnimationCurve,
  Curve? reverseAnimationCurve,
  Duration? animationDuration,
  double? barBlur,
  double? overlayBlur,
  Color? overlayColor,
  Form? userInputForm,
})
```

### GetSnackBar Class

```dart
class GetSnackBar extends StatefulWidget {
  const GetSnackBar({
    Key? key,
    this.title,
    this.message,
    this.titleText,
    this.messageText,
    this.icon,
    this.shouldIconPulse = true,
    this.maxWidth,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 0.0,
    this.borderColor,
    this.borderWidth = 1.0,
    this.backgroundColor = const Color(0xFF303030),
    this.leftBarIndicatorColor,
    this.boxShadows,
    this.backgroundGradient,
    this.mainButton,
    this.onTap,
    this.onHover,
    this.duration,
    this.isDismissible = true,
    this.dismissDirection,
    this.showProgressIndicator = false,
    this.progressIndicatorController,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorValueColor,
    this.progressIndicatorTheme,
    this.snackPosition = SnackPosition.BOTTOM,
    this.snackStyle = SnackStyle.FLOATING,
    this.forwardAnimationCurve = Curves.easeOut,
    this.reverseAnimationCurve = Curves.fastOutSlowIn,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.barBlur = 0.0,
    this.overlayBlur = 0.0,
    this.overlayColor,
    this.userInputForm,
    this.snackbarStatus,
    this.hitTestBehavior,
  })
}
```

## Middleware API

### GetMiddleware Class

```dart
abstract class GetMiddleware {
  /// The priority of the middleware. Lower values have higher priority.
  int? get priority => 0;

  /// Called when the route is being called
  RouteSettings? redirect(String? route);

  /// Called when the page is being called
  GetPage? onPageCalled(GetPage? page);

  /// Called when bindings are starting
  List<Bindings>? onBindingsStart(List<Bindings>? bindings);

  /// Called when page building starts
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page);

  /// Called when page is built
  Widget onPageBuilt(Widget page);

  /// Called when page is disposed
  void onPageDispose();
}
```

### Example Middleware Implementation

```dart
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!AuthService.isLoggedIn && route != '/login') {
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
  Widget onPageBuilt(Widget page) {
    print('Page built successfully');
    return super.onPageBuilt(page);
  }
}
```

## Transition API

### Transition Enum

```dart
enum Transition {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  topLevel,
  noTransition,
  cupertino,
  cupertinoDialog,
  size,
  circularReveal,
  native,
}
```

### CustomTransition Class

```dart
abstract class CustomTransition {
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}
```

### Example Custom Transition

```dart
class SlideFromBottomTransition extends CustomTransition {
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
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve ?? Curves.easeInOut,
      )),
      child: child,
    );
  }
}
```

## Observer API

### GetObserver Class

```dart
class GetObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Custom logic here
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Custom logic here
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // Custom logic here
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    // Custom logic here
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    // Custom logic here
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    // Custom logic here
  }
}
```

## Bindings API

### Bindings Interface

```dart
abstract class Bindings {
  void dependencies();
}
```

### BindingsBuilder

```dart
class BindingsBuilder extends Bindings {
  final VoidCallback builder;
  
  BindingsBuilder(this.builder);
  
  @override
  void dependencies() => builder();
}
```

### Example Binding

```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<ApiService>(ApiService());
  }
}
```

## Utility Classes

### SnackPosition Enum

```dart
enum SnackPosition { TOP, BOTTOM }
```

### SnackStyle Enum

```dart
enum SnackStyle { FLOATING, GROUNDED }
```

### SnackbarStatus Enum

```dart
enum SnackbarStatus { OPEN, OPENING, CLOSED, CLOSING }
```

### DismissDirection Enum

```dart
enum DismissDirection {
  vertical,
  horizontal,
  endToStart,
  startToEnd,
  up,
  down,
  none,
}
```

## Type Definitions

```dart
typedef GetPageBuilder = Widget Function();
typedef RoutePageBuilder = Widget Function(BuildContext, Animation<double>, Animation<double>);
typedef OnTap = void Function(GetSnackBar snack);
typedef OnHover = void Function(GetSnackBar snack, SnackHoverState snackHoverState);
typedef SnackbarStatusCallback = void Function(SnackbarStatus? status);
typedef LogWriterCallback = void Function(String text, {bool isError});
```

## Constants

```dart
// Default dialog transition duration
const Duration defaultDialogTransitionDuration = Duration(milliseconds: 200);

// Default dialog transition curve
const Curve defaultDialogTransitionCurve = Curves.easeInOut;

// Default transition duration
const Duration defaultTransitionDuration = Duration(milliseconds: 300);
```

This API documentation provides a comprehensive reference for all the classes, methods, and properties available in the GetX Navigation package. Use this as a reference when implementing navigation features in your Flutter applications.
