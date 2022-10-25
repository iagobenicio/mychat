import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychat/modules/app-chat/search/infra/datasource/serach_datasource.dart';

class SearchDataSourceIMPL implements ISearchDataSource{


  FirebaseFirestore firestore; 

  SearchDataSourceIMPL({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> searchUserDs(String data)async{

    final users = await firestore.collection("users").where("name",isEqualTo: data).get();

    return users.docs.map((e) => e.data()).toList();

  }

}