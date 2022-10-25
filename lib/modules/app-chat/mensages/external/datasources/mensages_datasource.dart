import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychat/modules/app-chat/mensages/infra/datasources/mensages_datasource.dart';
import 'package:intl/intl.dart' show DateFormat;

class MensageDataSrocueIMPL implements IMensagesDataSource{

  FirebaseFirestore firestore;

  MensageDataSrocueIMPL({required this.firestore});

  @override
  Future<void> deleteMensage(String mensageUid, String chatUid)async{
    
    final collection = firestore.collection("chats").doc(chatUid);
   
    await collection.collection("mensages").doc(mensageUid).delete();

    final lastMensage = await collection.collection("mensages").orderBy("created",descending: true).limit(1).get();

    await collection.update({"lastMensage":lastMensage.docs[0].data()["mensage"]});

  }

  @override
  Stream<List<Map<String, dynamic>>> getAllMensages(String chatUid) {

    final streamMensages = firestore.collection("chats").doc(chatUid).collection("mensages").orderBy("created").snapshots();
    
    return streamMensages.map((event)=> event.docs.isEmpty ? [] : event.docs.map((e){
      
      final data = e.data();
      data.update("created", (value) => value != null ? DateFormat("Hm").format((value as Timestamp).toDate()) : DateFormat("Hm").format(DateTime.now()));
      data.addAll({"uidMensage":e.id});

      return data;

    }).toList());
  }

  @override
  Future<void> sendMensage(String mensage, String userUid, String chatUid)async{

    final collection = firestore.collection("chats").doc(chatUid);
    await collection.update({"lastMensage": mensage, "lastMensageTime": FieldValue.serverTimestamp()});
    final mensageDoc = collection.collection("mensages").doc();
    await mensageDoc.set({"mensage":mensage, "sendby":userUid, "created": FieldValue.serverTimestamp()});
  
  }

  @override
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid)async{

    final collection = firestore.collection("chats").doc(chatUid);
    await collection.set({"members": [userUid,contactUid], "lastMensage": mensage, "lastMensageTime": FieldValue.serverTimestamp()});

    await collection.collection("mensages").doc().set({"mensage":mensage, "sendby": userUid, "created": FieldValue.serverTimestamp()});
    
  }


}