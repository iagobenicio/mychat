import 'package:flutter/material.dart';
import 'package:mychat/modules/app-chat/search/presenter/search_user_page.dart';
import 'package:mychat/modules/app-chat/settings/presenter/settings_page.dart';

import 'chats/presenter/chat.dart';


class AppChatWidget extends StatefulWidget {
  const AppChatWidget({Key? key}) : super(key: key);

  
  @override
  State<AppChatWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppChatWidget> {

  final widgetsChat = [Chat(), SearchUser(), Profile()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsChat[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(109, 71, 186, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_rounded),label: "conversas"),
          BottomNavigationBarItem(icon: Icon(Icons.person_search_rounded),label: "pesquisar"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "perfil")
        ],
        currentIndex: currentIndex,
        onTap: (newValue) {
          setState(() {
            currentIndex = newValue;
          });
        },
      ),
    );
  }
}