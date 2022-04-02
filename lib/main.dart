import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mail_sender.dart';
import 'package:scanner/mainscreen/screens/home_screen.dart';
import 'package:scanner/mainscreen/screens/login_screen.dart';
import 'package:scanner/mainscreen/screens/spash_screen.dart';
import 'package:scanner/mainscreen/store/login/login_store.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<OrdersStore>(
            create: (_) => OrdersStore()..init(),
          ),
          Provider<LoginStore>(
            create: (_) => LoginStore(),
          )
        ],
        child: const Splash(),
      ),
    );
  }
}
