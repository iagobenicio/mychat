import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IUserProfileDataSource{

  Future<Map<String, dynamic>?> getUser(String currentUser);
  Stream<TaskSnapshot> updateUserImage(String currentUser, File userImage);
  Future<void> updateUserName(String currentUser, String userName);
  
}