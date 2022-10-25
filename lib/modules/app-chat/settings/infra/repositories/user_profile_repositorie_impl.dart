import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mychat/modules/app-chat/settings/domain/entitie/user_profile.dart';
import 'package:mychat/modules/app-chat/settings/infra/model/user_profile_model.dart';
import '../../domain/erros/profile_erros.dart';
import '../../domain/repositories/user_profile_repositorie.dart';
import '../datasource/user_profile_datasource.dart';


class UserProfileRepositorieIMPL implements IUserProfileRepositorie{

  IUserProfileDataSource userProfileDataSource;

  UserProfileRepositorieIMPL({required this.userProfileDataSource});

  @override
  Future<Either<UserProfileEntitie,FailurePorifle>> getUserProfile(String currentUser)async{

    try {
      final user = await userProfileDataSource.getUser(currentUser);
  
      if (user == null ) {
        return Right(FailureGetUserProfile(mensage: 'nenhum usuário encontrado'));
      }

      return Left(UserProfileModel.fromMap(user));

    } catch (e) {
      return Right(FailureGetUserProfile(mensage: e.toString()));
    }

    
  }

  @override
  Stream<TaskSnapshot> updateUserImage(String currentUser, File imageProfile)async*{

    try {

      yield* userProfileDataSource.updateUserImage(currentUser, imageProfile);

    } catch (e) {
      
      throw Exception(e);

    }

    
    
  }
  
  @override
  Future<FailureUpdateUser?> updateUserName(String currentUser, String userName)async{
    try {
      await userProfileDataSource.updateUserName(currentUser, userName);
      return null;
    } catch (e) {
      return FailureUpdateUser(mensage: e.toString());
    }
  }

}