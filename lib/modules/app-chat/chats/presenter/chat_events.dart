import 'package:dartz/dartz.dart';

import '../domain/entities/user_chat_entitie.dart';
import '../domain/erros/getchats_erros.dart';

abstract class ChatEvents{}

class GetAllChatsAndListnen implements ChatEvents{
  String uidUser;

  GetAllChatsAndListnen({required this.uidUser});
}

class NewChats implements ChatEvents{
  Either<IChatsErros, List<UserChatEntitie>> result;
  NewChats({required this.result});
}
