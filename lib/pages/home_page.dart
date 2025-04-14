import 'package:flash_chat_dubl_3/componets/my_drawer.dart';
import 'package:flash_chat_dubl_3/componets/user_tile.dart';
import 'package:flash_chat_dubl_3/pages/chat_page.dart';
import 'package:flash_chat_dubl_3/services/auth/auth_service.dart';
import 'package:flash_chat_dubl_3/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:
            const Text('Chats', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: BuildUserList(),
    );
  }

  Widget BuildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _builduserItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _builduserItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recivertemail: userData['email'],
                recevireId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
