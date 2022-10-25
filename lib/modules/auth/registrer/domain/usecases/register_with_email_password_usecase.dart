import 'package:dartz/dartz.dart';
import '../entities/register_entities.dart';
import '../erros/register_erros.dart';
import '../repositories/register_repository.dart';
import 'package:email_validator/email_validator.dart';

abstract class IRegisterWithEmailAndPassword{

  Future<Either<IRegisterErros,UserRegisterLoginEntity>> regiterWithEmailAndPaswword({
    required String email, required String name, required String password, required String confirmPassword
  });

}

class RegisterWithEmailAndPassword implements IRegisterWithEmailAndPassword{

  IRegisterRepository repository;

  RegisterWithEmailAndPassword({required this.repository});

  @override
  Future<Either<IRegisterErros, UserRegisterLoginEntity>> regiterWithEmailAndPaswword({
    required String email, required String name, required String password, required String confirmPassword})async{
    
    if(email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty){

      return Left(InvalidData(mensage: "Preencha todos os dados"));

    }else{
      
      if(!EmailValidator.validate(email)){

        return Left(InvalidEmail(mensage: "Digite um email válido"));

      }else{

        if (password != confirmPassword) {

          return Left(InvalidPassword(mensage: "As senhans não batem"));

        }else{

          return await repository.register(email: email, name: name, password: password, confirmPassword: confirmPassword);

        }

      }

    }

  }

}