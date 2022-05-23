import 'package:common_components/component/progress_component.dart';
import 'package:common_components/home/home.dart';
import 'package:common_components/login/login_store.dart';
import 'package:common_components/sign_up/sign_up.dart';
import 'package:common_components/sure_set_state.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<ReactionDisposer> _disposer = [];

  late LoginStore loginStore;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    loginStore = LoginStore();

    _disposer = [
      reaction(
          (_) => loginStore.error, (String? result) => showSnackBar(result!)),
      reaction((_) => loginStore.result, (bool? result) {
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
      /*appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.white,
        ),
      ),*/
      key: loginStore.globalKey,
      body: Form(
        key: loginStore.formKey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
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
                      controller: loginStore.emailController,
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
                      controller: loginStore.passwordController,
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
                      height: 30,
                    ),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (loginStore.formKey.currentState!.validate()) {
                          loginStore.submitData(context);
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpView()));
                      },
                      child: Text(AppString.sign_up),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RawMaterialButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.white,
                      onPressed: () {
                        loginStore.signWithGoogle();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/search.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(AppString.login_google,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RawMaterialButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        loginStore.signWithFacebook();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            AppString.login_facebook,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Observer(builder: (context) {
              return ProgressComponent(
                isVisible: loginStore.isDataSubmitting,
              );
            }),
          ],
        ),
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
