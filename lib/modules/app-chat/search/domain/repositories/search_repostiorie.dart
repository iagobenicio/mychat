import 'package:dartz/dartz.dart';
import '../entities/users_entitie.dart';
import '../erros/search_erro.dart';

abstract class ISearchRepositorie{
  Future<Either<ISerachErro,List<UserEntitie>>> searchUser(String data);
}