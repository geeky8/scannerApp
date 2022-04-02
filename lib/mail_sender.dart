import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server/sendgrid.dart';
import 'package:provider/provider.dart';
import 'package:scanner/mainscreen/store/login/login_store.dart';

class EmailSender extends StatelessWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.read<LoginStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final email = store.email;
              final token = store.accessToken;
              final server = gmailSaslXoauth2(email, token);

              // print(email);
              // print(token);

              final message = Message()
                ..from = email
                ..recipients = ['<$email>']
                ..subject = 'Hello World'
                ..text = 'Heyya';

              try {
                final sendReport = await send(message, server);
                print('Message sent: ' + sendReport.toString());
              } on MailerException catch (e) {
                print('Message not sent');
                print(e.message);
                // for (var p in e.problems) {
                //   print('Problem: ${p.code}: ${p.msg}');
                // }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              await store.signOut(context: context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'SignOut',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
