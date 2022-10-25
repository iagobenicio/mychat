abstract class IMensagesDataSource{
  Stream<List<Map<String,dynamic>>> getAllMensages(String chatUid);
  Future<void> sendMensage(String mensage, String userUid, String chatUid);
  Future<void> deleteMensage(String mensageUid, String chatUid);
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid);
}