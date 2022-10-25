import 'package:mychat/modules/app-chat/search/domain/erros/search_erro.dart';
import 'package:mychat/modules/app-chat/search/domain/entities/users_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:mychat/modules/app-chat/search/domain/repositories/search_repostiorie.dart';
import '../datasource/serach_datasource.dart';
import '../models/users_model.dart';



class SearchRepositorie implements ISearchRepositorie{

  ISearchDataSource datasource;

  SearchRepositorie({required this.datasource});

  @override
  Future<Either<ISerachErro, List<UserEntitie>>> searchUser(String data)async{

    try {

      final users = await datasource.searchUserDs(data);
      final usersModel = convertToModel(users);
      return Right(usersModel);

    } catch (e) {
      return Left(FailureSearch(mensage: "Algum erro ocorreu"));
    }
    

  }

  List<UserEntitie> convertToModel(List<Map<String,dynamic>> users){

    final List<UserModel> usersModel = users.map((e) => UserModel.fromMap(e)).toList();
    return usersModel;

  }

}