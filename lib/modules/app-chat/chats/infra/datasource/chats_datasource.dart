abstract class IChatsDataSource{

  Stream<List<Map<String,dynamic>>> getAllChats(String? uidUser);
  Future<Map<String, dynamic>> getChatWithContactUid(String myUid, String contactUid);
}