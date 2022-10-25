import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../erros/profile_erros.dart';
import '../repositories/user_profile_repositorie.dart';

abstract class IUpdateUserImage{
   Stream<TaskSnapshot> updateUserImage(String currentUser, File imageProfile);
}

abstract class IUpdateUserName{
  Future<FailureUpdateUser?> updateUserName(String currentUser, String userName);
}

class UpdateUserImageIMPL implements IUpdateUserImage{

  IUserProfileRepositorie userProfileRepositorie;

  UpdateUserImageIMPL({required this.userProfileRepositorie});

  @override
   Stream<TaskSnapshot> updateUserImage(String currentUser, File imageProfile)async*{
    yield* userProfileRepositorie.updateUserImage(currentUser, imageProfile);
  }

}

class UpdateUserNameIMPL implements IUpdateUserName{

  IUserProfileRepositorie userProfileRepositorie;

  UpdateUserNameIMPL({required this.userProfileRepositorie});

  @override
  Future<FailureUpdateUser?> updateUserName(String currentUser, String userName)async{
    if(userName.isEmpty){
      return FailureUpdateUser(mensage: "Digite um nome válido");
    }
    return await userProfileRepositorie.updateUserName(currentUser, userName);
  }

}