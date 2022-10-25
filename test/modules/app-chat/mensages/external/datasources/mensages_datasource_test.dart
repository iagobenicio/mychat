import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mychat/modules/app-chat/mensages/external/datasources/mensages_datasource.dart';



void main()async{

  final firestore = FakeFirebaseFirestore();
  final datasource = MensageDataSrocueIMPL(firestore: firestore);

  await firestore.collection("chats").doc("chatuid").collection("mensages").doc("mensageuid").set(
    {
      "mensage":"Olá",
      "sendby":"myuid",
      "created":Timestamp.now()
    }
  );

  test("deve emitir uma lista de mensagens", (){

    expectLater(datasource.getAllMensages("chatuid"), emits(isA<List<Map<String,dynamic>>>()));

  });

}