import 'package:client/presentation/app/localization/app_localization.dart';
import 'package:client/presentation/app/navigation/auto_router.gr.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final AppRouter _appRouter = i.get<AppRouter>();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Networking DI samples',
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
        ],
      ),
    );
  }
}
