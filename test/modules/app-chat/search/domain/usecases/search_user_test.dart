import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/search/domain/entities/users_entitie.dart';
import 'package:mychat/modules/app-chat/search/domain/repositories/search_repostiorie.dart';
import 'package:mychat/modules/app-chat/search/domain/usecases/search_user.dart';
import 'package:mychat/modules/app-chat/search/domain/erros/search_erro.dart';


class SearchRepo extends Mock implements ISearchRepositorie{}

void main() {

  final searchRepo = SearchRepo();
  final serachUserUs = SearchUserUs(repositorie: searchRepo);  


  test("deve retorna um lista de usuários", ()async{

    when((() => searchRepo.searchUser(any()))).thenAnswer((_) async => Right([UserEntitie(userUid: "any",userName: "user", userPictureUrl: "any")]));
    
    final result = await serachUserUs.searchUser("user");
    expectLater(result.fold(id, id), isA<List<UserEntitie>>());

  });

  test("deve rtornar uma falha de nome inválido", ()async{

    final result = await serachUserUs.searchUser("");
    expectLater(result.fold(id, id), isA<InvalidData>());

  });

  

}