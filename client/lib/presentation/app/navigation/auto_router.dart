import 'package:auto_route/annotations.dart';
import 'package:client/presentation/pages/auth/auth_page.dart';
import 'package:client/presentation/pages/home/home_page.dart';
import 'package:client/presentation/pages/post_detailed/post_detailed_page.dart';
import 'route_constants.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routes.auth, page: AuthPageWidget, initial: true),
    AutoRoute(path: Routes.home, page: HomePage),
    AutoRoute(path: Routes.post, page: PostDetailedPage),
    //TODO: implement routes
  ],
)
class $AppRouter {}
