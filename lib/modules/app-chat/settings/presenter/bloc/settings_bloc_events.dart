import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfileEvents{}

abstract class ProfileUpdateEvents{}

abstract class UserProfile{

  String currentUser;


  UserProfile({required this.currentUser});

}

class UpdateUserName extends UserProfile implements ProfileUpdateEvents{

  String newUsername;
  
  UpdateUserName({required this.newUsername, required super.currentUser});

}

class UpdateImageProfile extends UserProfile implements ProfileUpdateEvents{

  File newImage;

  UpdateImageProfile({required this.newImage, required super.currentUser});

}

class UpdateUserProfileStatus implements ProfileUpdateEvents{

  TaskSnapshot taskSnapshot;

  UpdateUserProfileStatus({required this.taskSnapshot});

}

class GetUser implements ProfileEvents{
  String currentUser;

  GetUser({required this.currentUser});
}

class LogoutEvent implements ProfileEvents{}