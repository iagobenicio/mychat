import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../infra/datasource/user_profile_datasource.dart';

class SettingsDataSource implements IUserProfileDataSource{

  FirebaseStorage firebaseStorage;
  FirebaseFirestore firebaseFirestore;

  SettingsDataSource({required this.firebaseStorage, required this.firebaseFirestore});

  @override
  Future<Map<String, dynamic>?> getUser(String currentUser)async{

    final user = await firebaseFirestore.collection("users").doc(currentUser).get();
    return user.data();

  }

  @override
  Stream<TaskSnapshot> updateUserImage(String currentUser, File userImage)async*{
    
    final storageRef = firebaseStorage.ref().child(currentUser);

    final userRef = firebaseFirestore.collection("users").doc(currentUser);

    final taskSate = storageRef.putFile(userImage);
    
    yield* taskSate.snapshotEvents.asyncMap((event)async{

      if (event.state == TaskState.success){
        final photoUrl = await event.ref.getDownloadURL();
        await userRef.update({"image_profile":photoUrl});
      }
      return event;
    });

  }

  @override
  Future<void> updateUserName(String currentUser, String userName)async{

    final firestoreReference = firebaseFirestore.collection("users").doc(currentUser);
    
    await firestoreReference.update({"name":userName});

  }
  
}