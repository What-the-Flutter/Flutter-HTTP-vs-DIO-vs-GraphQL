import 'package:client/presentation/di/data_source_module.dart';
import 'package:client/presentation/di/interactor_module.dart';
import 'package:client/presentation/di/repository_module.dart';
import 'package:get_it/get_it.dart';

import 'navigation_module.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  initNavigationModule();
  initDataSourceModule();
  initRepositoryModule();
  initInteractorModule();
}
