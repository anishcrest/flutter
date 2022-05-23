import 'dart:async';

import 'package:common_components/home/home.dart';
import 'package:common_components/splash.dart';
import 'package:common_components/theme/theme.dart';
import 'package:common_components/utils/enum_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart' as UniLink;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //checkDeepLink();
  runApp(MyApp());
}

Future checkDeepLink() async {
  StreamSubscription _sub;
  try {
    print("checkDeepLink");
    await UniLink.getInitialLink();
    _sub = UniLink.linkStream.listen((val) {
      print('uri: $val');
      WidgetsFlutterBinding.ensureInitialized();
      runApp(MyApp());
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed

      print("onError");
    });
  } on PlatformException {
    print("PlatformException");
  } on Exception {
    print('Exception thrown');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {


    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    print('User granted permission: ${settings.authorizationStatus}');

    //get FCM token
    var token = await messaging.getToken();

    print(token.toString());

    ///Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    /// If the message also contains a data property with a "type" ,
    /// navigate to a specific screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    /// Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    DrawerComponentEnum? drawerComponentEnum;

    if (message.data['type'] != null) {
      drawerComponentEnum = EnumUtil.fromStringEnum(
          DrawerComponentEnum.values, message.data['type']);
    }

    ///navigate to home screen based on notification data
    _navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeView(fromNotification: drawerComponentEnum),
      ),
    );
  }

  Future initUnitLinks() async {
    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await UniLink.getInitialLink();

      /// Parse the link and warn the user, if it is not correct,
      /// but keep in mind it could be `null`.

      if (initialLink != null) {
        /// If link exists then navigate to home deeplink tab
        _navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                HomeView(fromNotification: DrawerComponentEnum.deep_link),
          ),
        );
      }
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

/*  ///Request overlay permission
  Future requestOverLayPermission()async{
    await SystemAlertWindow.requestPermissions();
  }*/

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    initUnitLinks();
    //requestOverLayPermission();

    ///reflate change them
    appStyle.addListener(() {
      //2
      setState(() {});
    });

    /* Connectivity().onConnectivityChanged.listen((ConnectivityResult  connectivityResult) {


      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        print('Mobile');
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        print('WIFI');
      }else if(connectivityResult == ConnectivityResult.none){
        print('NOT CONNECTED');
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: appStyle.currentTheme,
      home: SplashView(),
    );
  }
}
