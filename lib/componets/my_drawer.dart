import 'package:flash_chat_dubl_3/OpenAI/My_icons.dart';
import 'package:flash_chat_dubl_3/pages/openai_page.dart';
import 'package:flash_chat_dubl_3/services/auth/auth_service.dart';
import 'package:flash_chat_dubl_3/pages/setings_page.dart';
import 'package:flutter/material.dart';

//для значка меню

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() async {
    final auth = AuthService();
    auth.signOut();
  }

  void openChatGpt(BuildContext context) {
    // Navigate to the ChatGPT page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatGpt(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //для знака
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              //для текста Home
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  title: const Text(
                    'H O M E',
                  ),
                  leading: const Icon(
                    Icons.home,
                  ),
                  onTap: () {
                    //действие при нажатии
                    Navigator.pop(context);
                  },
                ),
              ),
              //для настроки
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  title: const Text(
                    'S E T T I N G S',
                  ),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  onTap: () {
                    //действие при нажатии
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetingsPage()));
                  },
                ),
              ),
              //для выхода
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  title: const Text(
                    'L O G O U T',
                  ),
                  leading: const Icon(
                    Icons.logout,
                  ),
                  onTap: logout,
                  //действие при нажатии
                ),
              ),
              //для ChatGPT
              GestureDetector(
                onTap: () => openChatGpt(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 170, top: 26),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(MyIcons.openAI, width: 50, height: 50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
