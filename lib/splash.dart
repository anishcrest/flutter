import 'package:common_components/home/home.dart';
import 'package:common_components/login/login.dart';
import 'package:flutter/material.dart';

import 'services/login_service.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  LoginServices loginServices = LoginServices();

  bool? result;

  @override
  void initState() {
    //  checkUserAlreadyLogin();
    super.initState();
  }

  /*checkUserAlreadyLogin() async {
    await Future.delayed(Duration(milliseconds: 200));
    var result = await loginServices.isUserAlreadyLogin();
    sureSetState(this, () {
      this.result = result;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginServices.checkUserAlreadyLogin() ? HomeView() : LoginView(),
    );

    return Scaffold(
      body: result == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : result!
              ? HomeView()
              : LoginView(),
    );
  }
}
