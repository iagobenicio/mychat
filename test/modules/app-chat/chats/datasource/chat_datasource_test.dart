import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mychat/modules/app-chat/chats/external/datasources/chat_datasource.dart';


void main(){
  
  final firestore = FakeFirebaseFirestore();
  final ds = ChatsDataSoruceIMPL(firestore: firestore);

  setUpAll(()async{

    await firestore.collection("users").doc("contactuid").set({"uid":"contactuid","name":"contact","contactImage":"some_url"});
    await firestore.collection("users").doc("myuid").set({"uid":"myuid","name":"me","contactImage":"some_url"});
    await firestore.collection("users").doc("othercontactuid").set({"uid":"othercontactuid","name":"othercontact","contactImage":"some_url"});
    
    
    await firestore.collection("chats").doc("chatuid2").set({"members":["contactuid","othercontactuid"]});
    
  });

  test("dever emitir uma lista de chat", ()async{

    expect(ds.getAllChats("myuid"), emitsInOrder([isA<List<Map<String,dynamic>>>(),isA<List<Map<String,dynamic>>>()]));
    await firestore.collection("chats").doc("chauid1").set({"members":["contactuid","myuid"]});
    
  });

  test("dever emitir uma lista de chat com tamanho 1", (){

    expect(ds.getAllChats("myuid"), emits(isA<List<Map<String,dynamic>>>().having((p0) => p0.length, "", equals(1))));
  
  });

  test("dever emitir uma lista de chat vazio", (){

    expect(ds.getAllChats("otheruser"), emits(isA<List<Map<String,dynamic>>>().having((p0) => p0, "", isEmpty)));
  
  });




}