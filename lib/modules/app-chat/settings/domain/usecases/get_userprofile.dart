import '../entitie/user_profile.dart';
import '../erros/profile_erros.dart';
import '../repositories/user_profile_repositorie.dart';
import 'package:dartz/dartz.dart';

abstract class IGetUserProfile{
  Future<Either<UserProfileEntitie,FailurePorifle>> getUserProfile(String currentUser);
}

class GetUserProfile implements IGetUserProfile{

  IUserProfileRepositorie userProfileRepositorie;

  GetUserProfile({required this.userProfileRepositorie});

  @override
  Future<Either<UserProfileEntitie,FailurePorifle>> getUserProfile(String currentUser)async{
    return await userProfileRepositorie.getUserProfile(currentUser);
  }

}