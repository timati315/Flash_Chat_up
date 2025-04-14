import 'package:flash_chat_dubl_3/services/auth/auth_service.dart';
import 'package:flash_chat_dubl_3/componets/my_buttons.dart';
import 'package:flash_chat_dubl_3/componets/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function() onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  //для того чтобы кнопка работала
  void login(BuildContext context) async {
    final authService = AuthService();

    //try login
    try {
      await authService.singInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    }

    //если получилось
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
  //если не получилось

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //для того чтобы иконка была видна на темном фоне
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),
            //для того чтобы текст Welcome back был виден на темном фоне
            Text(
              'Welcome back,you\'ve been missed!',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 25),
            //для того чтобы текст Email был виден на темном фоне
            MyTextfield(
              obscureText: false,
              hintText: 'Enter your email...',
              controller: _emailController,
            ),
            //для того чтобы текст Pasword был виден на темном фоне
            const SizedBox(height: 10),
            MyTextfield(
              obscureText: true,
              hintText: 'Enter your password...',
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Log in',
              onTap: () => login(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    ' Register now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
