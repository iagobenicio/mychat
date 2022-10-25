import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';

import '../../chats/domain/entities/user_chat_entitie.dart';

abstract class IMemsagesEvents{}



class SendMensageEvent implements IMemsagesEvents{

  String mensage = "";
  final String currentUser;
  final UserChatEntitie chatInfoToSendMensage;
  

  SendMensageEvent({required this.chatInfoToSendMensage, required this.currentUser});

  void setMensage(String mensage){
    this.mensage = mensage;
  }

}

class DeleteMensageEvent implements IMemsagesEvents{

  String mensageUid;
  String chatUid;

  DeleteMensageEvent({required this.mensageUid, required this.chatUid});

}

class GetMensagesEvent implements IMemsagesEvents{

  String chatUid;

  GetMensagesEvent({required this.chatUid});

}

class NewMensagesEvent implements IMemsagesEvents{

  List<MensagesEntitie> mensages = [];

  NewMensagesEvent();

  void setNewMensages(List<MensagesEntitie> mensages){
    this.mensages = mensages;
  }

}

