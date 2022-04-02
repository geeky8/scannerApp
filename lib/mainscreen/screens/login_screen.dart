import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scanner/enums/button_state.dart';
import 'package:scanner/enums/store_state.dart';
import 'package:scanner/mainscreen/store/login/login_store.dart';

class LoginScreen extends StatelessWidget {
  final Color primaryColor = const Color(0xff18203d);
  final Color secondaryColor = const Color(0xff232c51);

  final Color logoGreen = const Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final store = context.read<LoginStore>();
    return Provider<LoginStore>(
        create: (context) => LoginStore(),
        builder: (context, _) {
          final store = context.read<LoginStore>();
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: primaryColor,
              body: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Observer(builder: (_) {
                      final state = store.storeState;

                      switch (state) {
                        case StoreState.SUCCESS:
                          return const Text(
                            'Sign in to Scanner and continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          );

                        case StoreState.LOADING:
                          return const Text(
                            'Logging In......',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          );
                        case StoreState.ERROR:
                          return const SizedBox();
                        case StoreState.EMPTY:
                          return const SizedBox();
                      }
                    }),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () async {
                        await store.signup(context: context, store: store);
                        //Here goes the logic for Google SignIn discussed in the next section
                      },
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.login),
                          const SizedBox(width: 10),
                          Observer(builder: (_) {
                            final state = store.state;
                            switch (state) {
                              case ButtonState.LOADING:
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              case ButtonState.SUCCESS:
                                return const Text('Sign-in using Google',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16));
                              case ButtonState.APPLIED:
                                return const SizedBox();
                            }
                          }),
                        ],
                      ),
                      textColor: Colors.white,
                    ),
                    // const SizedBox(height: 100),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: _buildFooterLogo(),
                    // )
                  ],
                ),
              ));
        });
  }
}

//   _buildFooterLogo() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Image.asset(
//           'assets/tgd_white.png',
//           height: 40,
//         ),
//         Text('The Growing Developer',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.openSans(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold)),
//       ],
//     );
//   }

//   _buildTextField(
//       TextEditingController controller, IconData icon, String labelText) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//           color: secondaryColor, border: Border.all(color: Colors.blue)),
//       child: TextField(
//         controller: controller,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//             labelText: labelText,
//             labelStyle: const TextStyle(color: Colors.white),
//             icon: Icon(
//               icon,
//               color: Colors.white,
//             ),
//             // prefix: Icon(icon),
//             border: InputBorder.none),
//       ),
//     );
//   }
// }
