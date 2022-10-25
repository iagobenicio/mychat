import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/search/infra/datasource/serach_datasource.dart';
import 'package:mychat/modules/app-chat/search/infra/models/users_model.dart';
import 'package:mychat/modules/app-chat/search/infra/repositories/search_repositorie.dart';

class SearchDsMock extends Mock implements ISearchDataSource{}

void main() {

  final searchDs = SearchDsMock();
  final repository = SearchRepositorie(datasource: searchDs);


  test("deve retorna uma lista de UsersModel", ()async{

    when(()=>searchDs.searchUserDs(any())).thenAnswer((_) async => [{"uid":"uiduser","name":"Iago","email":"iagob@teste.com","image_profile":"urlimage"}]);

    final result = await repository.searchUser("any");

    expect(result.fold(id, id), isA<List<UserModel>>());

  });



}