import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';

import '../domain/erros/getchats_erros.dart';

abstract class ChatStates{}

class LoadingChats implements ChatStates{}

class ChatErros implements ChatStates{

  IChatsErros erro;

  ChatErros({required this.erro});

}

class EmitChats implements ChatStates{

  List<UserChatEntitie> chats;

  EmitChats({required this.chats});

}

class ChatsEmpty implements ChatStates{}
