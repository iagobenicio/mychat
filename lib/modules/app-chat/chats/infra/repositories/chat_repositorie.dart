import 'dart:async';

import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:mychat/modules/app-chat/chats/domain/erros/getchats_erros.dart';
import 'package:mychat/modules/app-chat/chats/domain/repositories/chats_repositorie.dart';
import 'package:mychat/modules/app-chat/chats/infra/models/user_chat_model.dart';

import '../../../search/domain/entities/users_entitie.dart';
import '../datasource/chats_datasource.dart';


class ChatRepositorieIMPL implements IChatRepositorie{

  IChatsDataSource dataSource;

  ChatRepositorieIMPL({required this.dataSource});


  @override
  Stream<Either<IChatsErros, List<UserChatEntitie>>> getChatsRepositorie(String? uidUser){
    
    try {
      final resultStream = dataSource.getAllChats(uidUser);
      
      return resultStream.map((chats) => Right(_covertToUserChat(chats)));
    } catch (e){
      return Stream.value(Left(FailureGetChats(mensage: "some erro")));
    }
   
  }

  @override
  Future<UserChatEntitie> getChatWithContactUid(String myUid, UserEntitie contact)async{
    
    final chat = await dataSource.getChatWithContactUid(myUid,contact.userUid);
    
    return UserChatEntitie(chatUid: chat["chatUid"], contactUid: contact.userUid, contactName: contact.userName, contactPictureUrl: contact.userPictureUrl, isNewChat: chat["isNewChat"]);

  }

  List<UserChatModel> _covertToUserChat(List<Map<String,dynamic>> contacts){
    
    return contacts.map((e) => UserChatModel.fromMap(e)).toList();

  }

  
}