import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mail_sender.dart';
import 'package:scanner/mainscreen/screens/home_screen.dart';
import 'package:scanner/mainscreen/screens/login_screen.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn(scopes: ['https://mail.google.com/']);

  @observable
  String accessToken = '';

  @observable
  String email = '';

  @observable
  ButtonState state = ButtonState.SUCCESS;

  @observable
  StoreState storeState = StoreState.SUCCESS;

  @action
  Future<int> init({required BuildContext context}) async {
    // print(email);
    // print(accessToken);

    if (auth.currentUser != null) {
      accessToken =
          (await auth.currentUser!.getIdTokenResult()).token as String;
      email = (auth.currentUser!.email) as String;
      print(accessToken);
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const EmailSender()));
      return 1;
    } else {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      return 0;
    }
  }

  @action
  Future<void> signOut({required BuildContext context}) async {
    await auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @action
  Future<void> signup(
      {required BuildContext context, required LoginStore store}) async {
    storeState = StoreState.LOADING;

    state = ButtonState.LOADING;
    final googleSignInAccount = await googleSignIn.signIn();
    state = ButtonState.SUCCESS;

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      final result = await auth.signInWithCredential(authCredential);
      // ignore: unused_local_variable
      final token = (await result.user!.getIdTokenResult()).token;

      accessToken = token!;
      email = result.user!.email!;

      storeState = StoreState.SUCCESS;

      // print(token);
      // print(email);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              Provider.value(value: store, child: const Home())));
    }
  }
}
