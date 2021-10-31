import 'dart:developer' as developer;

import 'package:admin/utils/colors.dart';
import 'package:admin/views/auth/account_view.dart';
import 'package:admin/views/auth/sign_in/sign_in_view.dart';
import 'package:admin/views/crud/model_create_view.dart';
import 'package:admin/views/crud/model_list_view.dart';
import 'package:admin/views/dashboard/dashboard_view.dart';
import 'package:admin/views/loading_view.dart';
import 'package:admin/views/messages/messages_view.dart';
import 'package:admin/views/not_found_view.dart';
import 'package:admin/views/page_layout.dart';
import 'package:admin/views/shared_scaffold.dart';
import 'package:admin/views/ui_model.dart';
import 'package:admin/views/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:url_strategy/url_strategy.dart';

final GlobalKey appKey = GlobalKey();

Future<void> main() async {
  setPathUrlStrategy();
  Translations.missingKeyCallback = (key, locale) => {};
  Translations.missingTranslationCallback = (key, locale) => {};
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: AdminApp(key: appKey),
      observers: [Logger()],
    ),
  );
}

class AdminApp extends ConsumerWidget {
  AdminApp({
    Key? key,
  }) : super(key: key);

  final AdminRouteInformationParser _routeInformationParser =
      AdminRouteInformationParser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ViewRouterDelegate delegate = ref.watch(routerDelegateProvider);
    final title = ref.watch(titleProvider).state;

    final swatch = createMaterialColor(
      // CI primary color
      const Color(0xff36d39a),
    );

    final themeDate = ThemeData(
      primarySwatch: swatch,
      // CI secondary color
      canvasColor: lighten(swatch.shade50, 0.2),
      backgroundColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      errorColor: const Color(0xffc74949),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: themeDate.copyWith(
        colorScheme:
            themeDate.colorScheme.copyWith(secondary: const Color(0xff6467f1)),
      ),
      routerDelegate: delegate,
      routeInformationParser: _routeInformationParser,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('de', 'DE'),
      ],
    );
  }
}

MaterialPage _mapViewToPage(BuildContext context, View view, WidgetRef ref) {
  return view.id.when(
    custom: (id) {
      if (view.id == dashboardView.id) {
        return _buildPage(view, const DashboardView());
      } else if (view.id == loginView.id) {
        return _buildPage(view, SignInView(
          onSignedIn: () {
            if (!ref.read(viewStackProvider.notifier).pop()) {
              ref.read(viewStackProvider.notifier).switchView(ViewId.dashboard);
            }
          },
        ));
      } else if (view.id == messageView.id) {
        return _buildPage(view, const MessagesView());
      } else if (view.id == accountView.id) {
        return _buildPage(view, AccountView());
      } else {
        return _buildAuxiliaryPage(const NotFoundView('Unknown view id.'));
      }
    },
    modelList: (id) {
      switch (view.id.id) {
        case 'events':
          return _buildPage(view, const ModelListView());
        default:
          return _buildAuxiliaryPage(const NotFoundView('Unknown view id.'));
      }
    },
    modelCreate: (id) {
      switch (view.id.id) {
        case 'events':
          return _buildPage(view, const ModelCreateView());
        default:
          return _buildAuxiliaryPage(const NotFoundView('Unknown view id.'));
      }
    },
  );
}

MaterialPage _buildAuxiliaryPage(Widget child) {
  return MaterialPage(
    child: PageLayout(child: child),
  );
}

MaterialPage _buildPage(View view, Widget child) {
  return MaterialPage(
    key: ObjectKey(view),
    child: PageLayout(child: child),
  );
}

class AdminRouteInformationParser extends RouteInformationParser<RoutedView> {
  @override
  Future<RoutedView> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    final segments = uri.pathSegments;

    // remove empty segment produced by trailing slash
    if (segments.isNotEmpty && segments.last == '') {
      segments.removeLast();
    }

    final ViewId? resolved;

    // Handle '/dashboard'
    if (segments.length == 1 && segments[0] == 'dashboard') {
      resolved = ViewId.custom('dashboard');
    }

    // Handle '/account'
    else if (segments.length == 1 && segments[0] == 'account') {
      resolved = ViewId.custom('account');
    }

    // Handle '/login'
    else if (segments.length == 1 && segments[0] == 'login') {
      resolved = ViewId.custom('login');
    }

    // Handle '/list/:model'
    else if (segments.length == 2 && segments[0] == 'list') {
      final remaining = segments[1];
      if (remaining.isEmpty) {
        resolved = null;
      } else {
        resolved = ViewId.modelList(remaining);
      }
    }

    // Handle '/create/:model'
    else if (segments.length == 2 && segments[0] == 'create') {
      final remaining = segments[1];
      if (remaining.isEmpty) {
        resolved = null;
      } else {
        resolved = ViewId.modelCreate(remaining);
      }
    } else {
      // Handle unknown routes
      resolved = null;
    }

    return resolved != null
        ? RoutedView.resolved(path: segments.join('/'), viewId: resolved)
        : RoutedView.notFound(path: segments.join('/'));
  }

  @override
  RouteInformation restoreRouteInformation(RoutedView configuration) {
    return RouteInformation(location: configuration.path);
  }
}

final _navigatorKey = GlobalKey<NavigatorState>();

class ViewRouterDelegate extends RouterDelegate<RoutedView>
    with PopNavigatorRouterDelegateMixin<RoutedView> {
  ViewRouterDelegate(
    this.ref,
  ) {
    // ignore: avoid_types_on_closure_parameters
    ref.listen(mainViewProvider, (StateController<RoutedView?> sc) {
      mainView = sc.state;
    });
  }

  late final ProviderRefBase ref;
  Map<VoidCallback, VoidCallback> listenerToProviderSubscriptions = {};
  RoutedView? mainView;

  @override
  Widget build(BuildContext context) {
    return URLNavigator(
      navigatorKey: navigatorKey,
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(RoutedView configuration) async {
    // wait until the UI is loaded from config and ready for resolving routes
    final ui = await ref.read(uiProvider.future);

    // switch view according to configuration
    configuration.when(
      loaded: (path, view) =>
          ref.read(viewStackProvider.notifier).switchView(view.id),
      resolved: (path, viewId) {
        final view = ui.views[viewId];
        if (view != null) {
          ref.read(viewStackProvider.notifier).switchView(view.id);
        } else if (path.isNotEmpty) {
          ref.read(notFoundPathProvider).state = path;
        } else {
          // leave the decision which route to navigate next to the UI
        }
      },
      notFound: (path) {
        if (path.isNotEmpty) {
          ref.read(notFoundPathProvider).state = path;
        } else {
          // leave the decision which route to navigate next to the UI
        }
      },
    );
  }

  @override
  RoutedView? get currentConfiguration => mainView;

  @override
  Future<bool> popRoute() async {
    final didPop = ref.read(viewStackProvider.notifier).pop();
    return SynchronousFuture(didPop);
  }

  @override
  void addListener(VoidCallback listener) {
    if (!listenerToProviderSubscriptions.containsKey(listener)) {
      listenerToProviderSubscriptions.putIfAbsent(
          listener,
          () => ref.listen(mainViewProvider, (_) {
                listener();
              }));
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final cancel = listenerToProviderSubscriptions.remove(listener);
    cancel?.call();
  }
}

class URLNavigator extends ConsumerWidget {
  const URLNavigator({
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewStack = ref.watch(viewStackProvider);
    final notFoundPath = ref.watch(notFoundPathProvider).state;

    final pages = viewStack.isNotEmpty
        ? viewStack.map((view) => _mapViewToPage(context, view, ref)).toList()
        : [_buildAuxiliaryPage(const LoadingView())];
    if (notFoundPath != null) {
      pages.add(_buildAuxiliaryPage(
          NotFoundView('Requested URL not found: $notFoundPath')));
    }

    return SharedScaffold(
      backgroundColor:
          viewStack.length == 1 ? Theme.of(context).canvasColor : null,
      elevation: viewStack.length * 4,
      child: Navigator(
        key: navigatorKey,
        // pages should never be empty: when viewStack is empty show a single loading view
        pages: pages,
        onPopPage: (route, dynamic result) {
          if (!route.didPop(result)) {
            return false;
          }

          final didPop = ref.read(viewStackProvider.notifier).pop();
          return didPop;
        },
      ),
    );
  }
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    developer.log(
        '''{  "provider": "${provider.name ?? provider.runtimeType}",  "newValue": "$newValue"}''');
  }
}
