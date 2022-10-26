import 'package:client/presentation/app/localization/app_localization.dart';
import 'package:flutter/material.dart';

String locale(BuildContext context) {
  return AppLocalizations.of(context)!.locale.toString();
}

abstract class AppStrings {
  static String authenticationPageName(BuildContext context) {
    return AppLocalizations.of(context)!.translate('authentication_page_name');
  }

  static String wrongAuthFields(BuildContext context) {
    return AppLocalizations.of(context)!.translate('wrong_auth_fields');
  }

  static String wrongLoginFields(BuildContext context) {
    return AppLocalizations.of(context)!.translate('wrong_login_fields');
  }

  static String name(BuildContext context) {
    return AppLocalizations.of(context)!.translate('name');
  }

  static String password(BuildContext context) {
    return AppLocalizations.of(context)!.translate('password');
  }

  static String login(BuildContext context) {
    return AppLocalizations.of(context)!.translate('login');
  }

  static String signUp(BuildContext context) {
    return AppLocalizations.of(context)!.translate('sign_up');
  }

  static String userHasAccount(BuildContext context) {
    return AppLocalizations.of(context)!.translate('user_has_account');
  }

  static String userHasNoAccount(BuildContext context) {
    return AppLocalizations.of(context)!.translate('user_has_no_account');
  }

  static String successfulSignUp(BuildContext context) {
    return AppLocalizations.of(context)!.translate('successful_sign_up');
  }

  static String successfulSignUpDescription(BuildContext context) {
    return AppLocalizations.of(context)!.translate('successful_sign_up_description');
  }

  static String homePageName(BuildContext context) {
    return AppLocalizations.of(context)!.translate('home_page_name');
  }

  static String postError(BuildContext context) {
    return AppLocalizations.of(context)!.translate('post_error');
  }

  static String create(BuildContext context) {
    return AppLocalizations.of(context)!.translate('create');
  }

  static String edit(BuildContext context) {
    return AppLocalizations.of(context)!.translate('edit');
  }

  static String delete(BuildContext context) {
    return AppLocalizations.of(context)!.translate('delete');
  }

  static String title(BuildContext context) {
    return AppLocalizations.of(context)!.translate('title');
  }

  static String text(BuildContext context) {
    return AppLocalizations.of(context)!.translate('text');
  }

  static String approve(BuildContext context) {
    return AppLocalizations.of(context)!.translate('approve');
  }

  static String authError(BuildContext context) {
    return AppLocalizations.of(context)!.translate('auth_error');
  }

  static String serverErrorDescription(BuildContext context) {
    return AppLocalizations.of(context)!.translate('server_error_description');
  }
}
