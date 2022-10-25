import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';
import 'package:mychat/modules/auth/login/domain/enittys/login.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasource/login_datasource.dart';


class LoginRepositoryIMPL implements ILoginRepository{


  IDataSource datasource;

  LoginRepositoryIMPL({required this.datasource});

  
  @override
  Future<Either<LoginErros, UserLoginEntity>> login(String? email, String? password)async{

    try {

      final userinfo = await datasource.siginWithEmail(email, password);
      return Right(userinfo);

    } on FirebaseAuthException catch(e){

      if (e.code == "user-not-found") {
        
        return Left(InvalidEmail("Este email não existe"));

      } else {

        if (e.code == "wrong-password") {

           return Left(InvalidPassword("A senha está incorreta"));

        }else{

          if (e.code == "invalid-email") {
            return Left(InvalidEmail("Digite um email válido"));
          } 

          return Left(InvalidEmail("Este email está desabilitado"));

        }
      
      }
      
    }catch (e){

      return Left(AuthError(e.toString()));

    }

  }

}