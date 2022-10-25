import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../entitie/user_profile.dart';
import 'package:dartz/dartz.dart';

import '../erros/profile_erros.dart';

abstract class IUserProfileRepositorie{

  Future<Either<UserProfileEntitie,FailurePorifle>> getUserProfile(String currentUser);
  Stream<TaskSnapshot> updateUserImage(String currentUser, File imageProfile);
  Future<FailureUpdateUser?> updateUserName(String currentUser, String userName);
}