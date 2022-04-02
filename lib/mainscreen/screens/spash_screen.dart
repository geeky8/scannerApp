import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mail_sender.dart';
import 'package:scanner/mainscreen/screens/home_screen.dart';
import 'package:scanner/mainscreen/screens/login_screen.dart';
import 'package:scanner/mainscreen/store/login/login_store.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';
import 'package:scanner/mainscreen/utils/constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // @override
  // void initState() {
  //   _checkAuth();
  //   super.initState();
  // }

  void _checkAuth({
    required BuildContext context,
    required LoginStore store,
  }) async {
    // final store = widget.context.read<LoginStore>();
    // await store.init(context: widget.context);
    final accessToken = await store.init(context: context);
    if (accessToken == 1) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              Provider.value(value: store, child: const Home())));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final store = context.read<LoginStore>();
    return Scaffold(
      backgroundColor: primaryColor,
      body: Provider<LoginStore>(
          create: (_) => LoginStore(),
          builder: (context, _) {
            final store = context.read<LoginStore>();
            _checkAuth(context: context, store: store);
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/images/notes.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: '\nScanner',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ])),
                  ]),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => LoginScreen()));
              //   },
              //   child: const Text('Push Now'),
              // )
            );
          }),
    );
  }
}
