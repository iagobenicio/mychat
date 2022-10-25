import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/modules/auth/registrer/domain/erros/register_erros.dart';
import 'package:mychat/modules/auth/registrer/domain/entities/register_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:mychat/modules/auth/registrer/domain/repositories/register_repository.dart';
import 'package:mychat/modules/auth/registrer/infra/datasource/register_datasource.dart';


class RegisterRepositorieIMPL implements IRegisterRepository{

  IRegisterDataSource datasource;
  RegisterRepositorieIMPL({required this.datasource});

  @override
  Future<Either<IRegisterErros, UserRegisterLoginEntity>> register({required String email, required String name, required String password, required String confirmPassword})async{
    
    try {
      
      final userInfo = await datasource.registerUser(email: email, name: name, password: password, confirmPassword: confirmPassword);
      
      return Right(userInfo);

    } on FirebaseAuthException catch(e){
      
      if (e.code == "email-already-in-use") {

        return Left(InvalidEmail(mensage: "Este email já existe"));

      }else if (e.code == "invalid-email"){

        return Left(InvalidEmail(mensage: "Insira um email válido"));

      }else if (e.code == "weak-password"){

        return Left(InvalidPassword(mensage: "Insira uma senha forte"));

      }else{

        return Left(CreateAccountErro(mensage: "Não foi possivel criar uma conta"));
        
      }

    }
    catch (e) {
      
      return Left(CreateAccountErro(mensage: e.toString()));

    }


  }


}