import '../entities/mensages_entitie.dart';

abstract class IMensageRepository{
  Stream<List<MensagesEntitie>> getAllMensages(String chatUid);
  Future<void> sendMensage(String mensage, String userUid, String chatUid);
  Future<void> deleteMensage(String mensageUid, String chatUid);
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid);
}