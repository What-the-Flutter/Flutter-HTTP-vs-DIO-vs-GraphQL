import 'package:client/presentation/app/navigation/auto_router.gr.dart';
import 'injector.dart';

void initNavigationModule() {
  i.registerSingleton<AppRouter>(
    AppRouter(),
  );
}
