import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mainscreen/screens/home_screen.dart';
import 'package:scanner/mainscreen/store/orders/orders_store.dart';

void main() {
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
      home: MultiProvider(providers: [
        Provider(create: (_) => OrdersStore()..init()),
      ], child: const Home()),
    );
  }
}
