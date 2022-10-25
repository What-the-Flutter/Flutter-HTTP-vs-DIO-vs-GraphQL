import 'package:client/presentation/app/navigation/auto_router.gr.dart';
import 'package:client/presentation/base/base_state.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseStateNotifier<St extends BaseState> extends StateNotifier<St> {
  BaseStateNotifier(St initialState) : super(initialState);

  @protected
  final appRouter = i.get<AppRouter>();

  @override
  void dispose() {
    super.dispose();
    appRouter.dispose();
  }

  void pop() => appRouter.pop();

  Future<void> launchRetrieveResult(
    Function action, {
    Function(dynamic e)? errorHandler,
  }) async {
    try {
      await action.call();
    } catch (e) {
      errorHandler?.call(e);
    }
  }
}
