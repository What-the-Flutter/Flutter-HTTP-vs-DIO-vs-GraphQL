import 'package:auto_route/annotations.dart';
import 'package:client/presentation/pages/auth/auth_page.dart';
import 'route_constants.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routes.auth, page: AuthPageWidget, initial: true),
    //TODO: implement routes
  ],
)
class $AppRouter {}
