import '../entities/users_entitie.dart';
import '../repositories/search_repostiorie.dart';
import '../erros/search_erro.dart';
import 'package:dartz/dartz.dart';

abstract class ISearchUser{
  Future<Either<ISerachErro,List<UserEntitie>>> searchUser(String data);
}

class SearchUserUs implements ISearchUser{
  ISearchRepositorie repositorie;

  SearchUserUs({required this.repositorie});

  @override
  Future<Either<ISerachErro,List<UserEntitie>>> searchUser(String data)async{

    if (data.isEmpty) {
      return Left(InvalidData(mensage: "Digite um nome de usuário válido"));
    }
    return await repositorie.searchUser(data);
  }

}