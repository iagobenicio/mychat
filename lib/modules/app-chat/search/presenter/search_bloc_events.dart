import 'package:mychat/modules/app-chat/search/domain/entities/users_entitie.dart';

abstract class SearchEvents{}

class GetUsers implements SearchEvents{

  String data;

  GetUsers({required this.data});

}

class CreateChatWithUserBySearch implements SearchEvents{

  String myUid;
  String uidUser;

  CreateChatWithUserBySearch({required this.myUid, required this.uidUser});

}

class GetChatOrNewChat implements SearchEvents{

  String myUid;
  UserEntitie contact;

  GetChatOrNewChat({required this.myUid, required this.contact});

}


