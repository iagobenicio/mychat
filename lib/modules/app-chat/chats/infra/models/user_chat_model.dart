import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';

class UserChatModel extends UserChatEntitie {


  UserChatModel({final contactName,final contactPictureUrl,final chatUid, final lastMensage}) : super(
    contactName: contactName, 
    contactPictureUrl: contactPictureUrl,
    chatUid: chatUid,
    lastMensage: lastMensage
  );

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      chatUid: map['chatUid'],
      contactName: map['name'] != null ? map['name'] as String : null,
      contactPictureUrl: map['image_profile'] != null ? map['image_profile'] as String : null,
      lastMensage: map["lastMensage"]
    );
  }

}
