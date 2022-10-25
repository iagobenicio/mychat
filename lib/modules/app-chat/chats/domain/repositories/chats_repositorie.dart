import 'package:dartz/dartz.dart';
import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';

import '../../../search/domain/entities/users_entitie.dart';
import '../erros/getchats_erros.dart';


abstract class IChatRepositorie{

  Stream<Either<IChatsErros,List<UserChatEntitie>>> getChatsRepositorie(String? uidUser);
  Future<UserChatEntitie> getChatWithContactUid(String myUid, UserEntitie contact);

}