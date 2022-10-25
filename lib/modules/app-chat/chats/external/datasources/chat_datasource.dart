import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychat/modules/app-chat/chats/infra/datasource/chats_datasource.dart';


class ChatsDataSoruceIMPL implements IChatsDataSource{

  FirebaseFirestore firestore;
  List<String> lastContacts = [];
  ChatsDataSoruceIMPL({required this.firestore});
  
  @override
  Stream<List<Map<String,dynamic>>> getAllChats(String? uidUser) {

    final collection = firestore.collection("chats").where("members",arrayContains: uidUser).orderBy("lastMensageTime",descending: true).snapshots(includeMetadataChanges: true);
    
    return collection.asyncMap((event) async => event.docs.isNotEmpty ?  await _getContacts(event.docs,uidUser!,lastContacts) : []);

  }
  
  @override
  Future<Map<String, dynamic>> getChatWithContactUid(String myUid, String contactUid)async{
    
    final getChat = await firestore.collection("chats").where("members", whereIn: [
        [contactUid, myUid],
        [myUid, contactUid], 
      ]).get();

    if (getChat.docs.isEmpty) {
      
      final newChat = await _createNewDocumentForChat(myUid, contactUid);
      return {"chatUid":newChat.id, "isNewChat":true};
      
    }
    return {"chatUid":getChat.docs[0].id, "isNewChat":false};
  }

  Future<DocumentReference<Map<String, dynamic>>> _createNewDocumentForChat(String myUid, String uidUser)async{
    final newChatReference = firestore.collection("chats").doc();
    return newChatReference;
  }


  Future<List<Map<String,dynamic>>> _getContacts(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs, String uiduser, List<String> lastContacts)async{
    
    final List<String> contacts = docs.map((chatDocument){

      if (chatDocument.data()["members"][0] == uiduser) {
        return chatDocument.data()["members"][1].toString();
      }
      return chatDocument.data()["members"][0].toString();
    }).toList();


    final usersContact = await _getContactsFromServerOrCache(contacts, lastContacts);

  
    Map<String, dynamic> userChat;
    
    final usersChats = docs.map((e){

      if (e.data()["members"][0] == uiduser) {

        userChat = usersContact.docs.firstWhere((element) => element.id == e.data()["members"][1]).data();
        userChat.addAll({"lastMensage":e.data()["lastMensage"]});
        userChat.addAll({"chatUid":e.id});
        return userChat;

      }

      userChat = usersContact.docs.firstWhere((element) => element.id == e.data()["members"][0]).data();
      userChat.addAll({"lastMensage":e.data()["lastMensage"]});
      userChat.addAll({"chatUid":e.id});
      return userChat;

    }).toList();

    return usersChats;

  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getContactsFromServerOrCache(List<String> contacts, List<String> lastContacts)async{

    if (lastContacts.isEmpty || contacts.length > lastContacts.length) {
      
      this.lastContacts = contacts;

      return await firestore.collection("users").where("uid", whereIn: contacts).get();

    }

    return await firestore.collection("users").where("uid", whereIn: contacts).get(GetOptions(source: Source.cache));

  }


}