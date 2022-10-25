import '../enittys/login.dart';
import 'package:dartz/dartz.dart';

import '../erros/login_errors.dart';
import '../repositories/login_repository.dart';

abstract class ILoginUseCase{
  Future<Either<LoginErros,UserLoginEntity>> login(String? email, String? password);
}

class LoginUseCase implements ILoginUseCase{

  ILoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<LoginErros,UserLoginEntity>> login(String? email, String? password)async{
    
    if (email == null || email.isEmpty) {
      return Left(InvalidEmail("Email está inválido"));
    }else{
      if(password == null || password.isEmpty){
        return Left(InvalidPassword("Senha está inválida"));
      }
      return await repository.login(email,password);
    }
  }

}