# flutter admin kit

A generative, customized admin for all platforms. Nice to use and nice to extend.

<a href="https://smartnuance.com/blog/flutter-admin-kit/"><img src="https://gitlab.com/smartnuance/blog/-/raw/c0bcf702cabdcc432449d816da401a7f3e1fd6b6/src/data/blog/flutter-admin-kit/flutter-admin-kit.svg?inline=false" alt="flutter admin kit" width="80"></a>

[demo](https://admin-kit.smartnuance.com) | [introductory blog post & videos](https://smartnuance.com/blog/flutter-admin-kit/)

## A note on the backend

This project is integrated with a [compatible microservice backend built with Go](https://github.com/smartnuance/saas-kit). Since this frontend uses REST APIs, it can be used with any backend providing the necessary endpoints for authentication, UI configuration and depending on those, CRUD operations.

## Feature highlights

Declarative routing via global state:
![Login view](dashboard-view.png)

Model list view dynamically generated from config files and an inspection API:
![Model list view](model-list-view.png)

Authentication with OAuth based on auto-refreshed JWTs:
![Dashboard](login-view.png)

Debug panel for live inspection of global state

## Get started

Because of [a bug](https://github.com/rrousselGit/river_pod/issues/880) in Dart for _flutter stable channel_ we need to use the master channel for now:

> flutter channel master

> flutter upgrade

> flutter packages pub global activate webdev

To run the admin from terminal

> flutter run -d chrome

With a different backend URL and hash routing activated:

> flutter run --dart-define="HASH_ROUTER=true" --dart-define="BACKEND_URL=true" -d chrome

## Packages used

State management
- [freezed_annotation](https://pub.dev/packages/freezed_annotation)
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [shared_preferences](https://pub.dev/packages/shared_preferences)

Networking
- [http](https://pub.dev/packages/http)
- [http_interceptor](https://pub.dev/packages/http_interceptor)

Translation:
- [intl](https://pub.dev/packages/intl)
- [i18n_extension](https://pub.dev/packages/i18n_extension)

Auxiliary
- [universal_platform](https://pub.dev/packages/universal_platform)
- [yaml](https://pub.dev/packages/yaml)
- [path](https://pub.dev/packages/path)
- [url_strategy](https://pub.dev/packages/url_strategy)

Widgets
- [flutter_breadcrumb](https://pub.dev/packages/flutter_breadcrumb)
- [fl_chart](https://pub.dev/packages/fl_chart)
- [timeline_tile](https://pub.dev/packages/timeline_tile) (only used for the debug panel)

Asset handling:
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [google_fonts](https://pub.dev/packages/google_fonts)


**Fonts**

- [Poppin](https://fonts.google.com/specimen/Poppins)

## Credits

- The basic dashboard layout and responsive foundation was adopted from [Responsive Admin Panel or Dashboard - Flutter UI](https://github.com/abuanwar072/Flutter-Responsive-Admin-Panel-or-Dashboard)
