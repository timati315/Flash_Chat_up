import 'package:flash_chat_dubl_3/services/auth/auth_service.dart';
import 'package:flash_chat_dubl_3/componets/my_buttons.dart';
import 'package:flash_chat_dubl_3/componets/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirPwController = TextEditingController();
  final void Function() onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();

    // Проверяем, что пароли совпадают
    if (_passwordController.text == _confirPwController.text) {
      try {
        // Попытка регистрации пользователя
        _auth.singUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        // Обработка ошибок и вывод их в диалоговом окне
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      // Если пароли не совпадают, показываем ошибку
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Passwords do not match!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Иконка
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),
            // Текст
            Text(
              'Let\'s create an account!',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 25),
            // Поле для ввода Email
            MyTextfield(
              obscureText: false,
              hintText: 'Enter your email...',
              controller: _emailController,
            ),
            SizedBox(height: 10),
            // Поле для ввода пароля
            MyTextfield(
              obscureText: true,
              hintText: 'Enter your password...',
              controller: _passwordController,
            ),
            SizedBox(height: 10),
            // Поле для подтверждения пароля
            MyTextfield(
              obscureText: true,
              hintText: 'Confirm your password...',
              controller: _confirPwController,
            ),
            SizedBox(height: 20),
            // Кнопка для регистрации
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            SizedBox(height: 25),
            // Линия с текстом для перехода на страницу входа
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    ' Login now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
