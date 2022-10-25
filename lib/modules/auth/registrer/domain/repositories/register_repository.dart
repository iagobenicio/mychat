

import 'package:dartz/dartz.dart';
import '../entities/register_entities.dart';
import '../erros/register_erros.dart';

abstract class IRegisterRepository{
  Future<Either<IRegisterErros,UserRegisterLoginEntity>> register({required String email, required String name, required String password, required String confirmPassword});
}