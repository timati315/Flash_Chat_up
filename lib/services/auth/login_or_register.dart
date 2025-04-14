import 'package:flash_chat_dubl_3/pages/login_page.dart';
import 'package:flash_chat_dubl_3/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLofinPage = true;

  void togglePage() {
    setState(() {
      showLofinPage = !showLofinPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLofinPage) {
      return LoginPage(
        onTap: togglePage,
      );
    } else {
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
