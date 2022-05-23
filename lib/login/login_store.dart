import 'package:common_components/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginServices loginServices = LoginServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @observable
  bool isDataSubmitting = false;

  @observable
  String? error;

  @observable
  bool? result;

  @action
  submitData(BuildContext context) async {
    ///Share Preference
    //bool result = loginServices.loginWithEmailPassword(emailController.text.trim(), passwordController.text.trim());

    try {
      isDataSubmitting = true;

      await Future.delayed(Duration(milliseconds: 2000));

      ///firebase
      result = await loginServices.signInWithEmailPassword(
          emailController.text.trim(), passwordController.text.trim());

      isDataSubmitting = false;
    } catch (e) {
      isDataSubmitting = false;
      error = e.toString();
    }
  }

  @action
  signWithGoogle() async {
    try {
      isDataSubmitting = true;

      result = await loginServices.googleSignIn();

      isDataSubmitting = false;
    } catch (e) {
      isDataSubmitting = false;
      error = e.toString();
    }
  }

  @action
  signWithFacebook() async {
    try {
      isDataSubmitting = true;

      result = await loginServices.facebookLogin();

      isDataSubmitting = false;
    } catch (e) {
      isDataSubmitting = false;
      error = e.toString();
    }
  }
}
