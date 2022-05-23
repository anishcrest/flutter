import 'package:common_components/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  final LoginServices loginServices = LoginServices();
  final TextEditingController nameController = TextEditingController();
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
    try {
      isDataSubmitting = true;

      await Future.delayed(Duration(milliseconds: 2000));

      ///firebase
      result = await loginServices.signUpWihEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );

      isDataSubmitting = false;
    } catch (e) {
      isDataSubmitting = false;
      error = e.toString();
    }
  }
}
