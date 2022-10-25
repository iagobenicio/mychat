import 'package:mychat/modules/auth/login/domain/enittys/login.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';

abstract class LoginStates{}

class InitLogin implements LoginStates{}

class LoginLoading implements LoginStates{}

class LoginSuccess implements LoginStates{

  UserLoginEntity userLogin;

  LoginSuccess(this.userLogin);

}

class LoginFailure implements LoginStates{
  LoginErros loginErro;

  LoginFailure(this.loginErro);
}

