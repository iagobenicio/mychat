import 'package:dartz/dartz.dart';
import '../enittys/login.dart';
import '../erros/login_errors.dart';

abstract class ILoginRepository{
  Future<Either<LoginErros,UserLoginEntity>> login(String? email, String? password);
}