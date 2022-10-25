import '../domain/entities/register_entities.dart';
import '../domain/erros/register_erros.dart';

abstract class RegisterStates{}

class InitRegister implements RegisterStates{}

class RegisterLoading implements RegisterStates{}

class RegisterSuccess implements RegisterStates{

  UserRegisterLoginEntity userRegister;

  RegisterSuccess(this.userRegister);

}

class RegisterFailure implements RegisterStates{
  IRegisterErros registerErro;

  RegisterFailure(this.registerErro);
}