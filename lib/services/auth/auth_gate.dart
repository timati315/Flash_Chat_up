import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_dubl_3/services/auth/login_or_register.dart';
import 'package:flash_chat_dubl_3/pages/home_page.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //если пользователь авторизован
          if (snapshot.hasData) {
            return HomePage();
          }
          //если пользователь не авторизован
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
