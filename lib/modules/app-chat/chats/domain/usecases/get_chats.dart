import 'package:mychat/modules/app-chat/chats/domain/repositories/chats_repositorie.dart';
import 'package:mychat/modules/app-chat/chats/domain/erros/getchats_erros.dart';
import '../entities/user_chat_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class IGetChatsUseCase{

  Stream<Either<IChatsErros,List<UserChatEntitie>>> getChats(String? uidUser);

}

class GetChatsIMPL implements IGetChatsUseCase{

  IChatRepositorie repositorie;

  GetChatsIMPL({required this.repositorie});

  @override
  Stream<Either<IChatsErros,List<UserChatEntitie>>> getChats(String? uidUser){
    return repositorie.getChatsRepositorie(uidUser);
  }


}