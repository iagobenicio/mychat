import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/modules/auth/registrer/infra/datasource/register_datasource.dart';
import 'package:mychat/modules/auth/registrer/infra/models/user_register_model.dart';

class RegisterDataSourceIMPL implements IRegisterDataSource{

  FirebaseAuth firebaseAuth;
  FirebaseFirestore firestore;

  RegisterDataSourceIMPL({required this.firebaseAuth, required this.firestore});


  @override
  Future<UserRegisterLoginModel> registerUser({required String email, required String name, required String password, required String confirmPassword})async{
    
    final resultInfo = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await firestore.collection("users").doc(resultInfo.user!.uid).set({"uid":resultInfo.user!.uid, "email":email, "name":name, "image_profile":null});

    return UserRegisterLoginModel(
      uid: resultInfo.user!.uid, 
      email: resultInfo.user!.email
    );

  }
}