import '../../../search/domain/entities/users_entitie.dart';
import '../entities/user_chat_entitie.dart';
import '../repositories/chats_repositorie.dart';

abstract class IGetChatWithContactUid{
  Future<UserChatEntitie> getChatWithContactUid(String myUid, UserEntitie contact);
}

class GetChatWithContactUid implements IGetChatWithContactUid{

  IChatRepositorie repositorie;

  GetChatWithContactUid({required this.repositorie});

  @override
  Future<UserChatEntitie> getChatWithContactUid(String myUid, UserEntitie contact)async{
    return await repositorie.getChatWithContactUid(myUid, contact);
  }

}