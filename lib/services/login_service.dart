import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  late SharedPreferences preferences;

  LoginServices() {
    _init();
  }

  _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///Share preference
  Future<bool> isUserAlreadyLogin() async{
    await Future.delayed(Duration(milliseconds: 1000));

    return preferences.getString(ConstantUtil.preference_user_email_key) != null
        ? preferences
        .getString(ConstantUtil.preference_user_email_key)!
        .isNotEmpty
        ? true
        : false
        : false;
  }

  bool loginWithEmailPassword(String email, String password) {
    if (email == 'test@gmail.com' && password == '123456') {
      preferences.setString(ConstantUtil.preference_user_email_key, email);
      return true;
    } else {
      return false;
    }
  }

  logout() {
    preferences.setString(ConstantUtil.preference_user_email_key, '');
  }

  ///Firebase
  Future<bool> signUpWihEmailPassword(
      String email, String password, String name) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      return await FirebaseFirestore.instance
          .collection(ConstantUtil.user)
          .doc(value.user!.uid)
          .set({
        'email': email,
        'name': name,
      }).then((value) {
        return true;
      }).catchError((e) {
        throw e;
      });
    }).catchError((e) {
      throw e;
    });
  }

  Future<bool> signInWithEmailPassword(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return true;
    }).catchError((e) {
      throw e;
    });
  }

  bool checkUserAlreadyLogin() {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  firebaseLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> googleSignIn() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();

      var googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return false;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      var dbUser = await FirebaseFirestore.instance
          .collection(ConstantUtil.user)
          .doc(userCredential.user!.uid)
          .get();

      if (!dbUser.exists) {
        return FirebaseFirestore.instance
            .collection(ConstantUtil.user)
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
        }).then((value) {
          return true;
        }).catchError((e) {
          throw e;
        });
      } else {
        return true;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> facebookLogin() async {
    try {
      var facebookLogin = FacebookLogin();

      var facebookResult = await facebookLogin.logIn(permissions: [
        FacebookPermission.email,
        FacebookPermission.userAboutMe,
      ]);

      if (facebookResult.status == FacebookLoginStatus.cancel) {
        return false;
      } else if (facebookResult.status == FacebookLoginStatus.success) {
        if (facebookResult.accessToken != null) {
          final AuthCredential authCredential = FacebookAuthProvider.credential(
              facebookResult.accessToken!.token);
          var credential =
              await FirebaseAuth.instance.signInWithCredential(authCredential);

          var dbUser = await FirebaseFirestore.instance
              .collection(ConstantUtil.user)
              .doc(credential.user!.uid)
              .get();

          if (!dbUser.exists) {
            return FirebaseFirestore.instance
                .collection(ConstantUtil.user)
                .doc(credential.user!.uid)
                .set({
              'email': credential.user!.email,
              'name': credential.user!.displayName,
            }).then((value) {
              return true;
            }).catchError((e) {
              throw e;
            });
          } else {
            return true;
          }
        } else {
          return false;
        }
      }

      return false;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
