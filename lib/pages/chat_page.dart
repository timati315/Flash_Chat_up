import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_dubl_3/componets/chat_bubble.dart';
import 'package:flash_chat_dubl_3/componets/my_textfield.dart';
import 'package:flash_chat_dubl_3/services/auth/auth_service.dart';
import 'package:flash_chat_dubl_3/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recivertemail;
  final String recevireId;
  ChatPage({super.key, required this.recivertemail, required this.recevireId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //creat textcontroller
  final TextEditingController _messagecontoler = TextEditingController();

  //chat or auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for tefiled fokus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //case a
        //then the amout
        //then scrool dawn
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDawn(),
        );
      }
    });

    //wait a bit for listviu to
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDawn(),
    );
  }

  void dispose() {
    myFocusNode.dispose();
    _messagecontoler.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDawn() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    if (_messagecontoler.text.isNotEmpty) {
      await _chatService.sendMessage(widget.recevireId, _messagecontoler.text);

      _messagecontoler.clear();
    }
    scrollDawn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.recivertemail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),

          //users input
          _buildUsserInput()
        ],
      ),
    );
  }

  //builmessageList
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.recevireId, senderId),
      builder: (context, snapshot) {
        //eror
        if (snapshot.hasError) {
          return const Text('Error');
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading....');
        }

        //return Listviu
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //buildMessageItem
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to right if sender id the

    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: aligment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['message'],
              isCurrentUser: isCurrentUser,
            )
          ],
        ));
  }

  //build massege input
  Widget _buildUsserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              hintText: 'Type message',
              controller: _messagecontoler,
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
