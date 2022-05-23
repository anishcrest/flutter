import 'package:common_components/component/progress_component.dart';
import 'package:common_components/home/home.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../sure_set_state.dart';
import 'sign_up_store.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpStore signUpStore;
  List<ReactionDisposer> _disposer = [];

  @override
  void initState() {
    super.initState();
    signUpStore = SignUpStore();

    _disposer = [
      reaction(
          (_) => signUpStore.error, (String? result) => showSnackBar(result!)),
      reaction((_) => signUpStore.result, (bool? result) {
        if (result != null && result) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeView()));
        }
      }),
    ];
  }

  @override
  void dispose() {
    _disposer.map((e) => e.reaction.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.sign_up),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: signUpStore.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/crest_logo.png',
                    scale: 1.2,
                  ),
                  TextFormField(
                    controller: signUpStore.nameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: AppString.hint_name,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: signUpStore.emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      } else if (!RegExp(ConstantUtil.email_pattern)
                          .hasMatch(val)) {
                        return AppString.invalid_email;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: AppString.hint_email,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: signUpStore.passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: AppString.hint_password,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    fillColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (signUpStore.formKey.currentState!.validate()) {
                        signUpStore.submitData(context);
                      } else {
                        sureSetState(this, () {});
                      }
                    },
                    child: Text(
                      AppString.submit,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Observer(builder: (context) {
            return ProgressComponent(
              isVisible: signUpStore.isDataSubmitting,
            );
          }),
        ],
      ),
    );
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
