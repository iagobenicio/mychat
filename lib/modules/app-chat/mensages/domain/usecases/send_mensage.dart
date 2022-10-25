import '../repository/mensages_repository.dart';

abstract class ISendMensage{
  Future<void> sendMensage(String mensage, String userUid, String chatUid);
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid);
}

class SendMensageIMPL implements ISendMensage{

  IMensageRepository repository;

  SendMensageIMPL({required this.repository});

  @override
  Future<void> sendMensage(String mensage, String userUid, String chatUid)async{
    return await repository.sendMensage(mensage, userUid, chatUid);
  }

  @override
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid)async{
    return await repository.sendMensageAndCreateNewChat(mensage, userUid, chatUid, contactUid);
  }
  

}