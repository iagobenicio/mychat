import '../../domain/entitie/user_profile.dart';
import '../../domain/erros/profile_erros.dart';

abstract class ProfileStates{}

class InitState implements ProfileStates{}

class Loading implements ProfileStates{}

class SuccessUpdaUser implements ProfileStates{
  String mensage;

  SuccessUpdaUser({required this.mensage});
}

class FailureUser implements ProfileStates{

  FailurePorifle failure;

  FailureUser({required this.failure});

}

class LoadedUserProfile implements ProfileStates{

  UserProfileEntitie user;

  LoadedUserProfile({required this.user});
  
}
class LogoutState implements ProfileStates{}

