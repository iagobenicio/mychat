import 'package:mychat/modules/auth/login/infra/datasource/login_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/modules/auth/login/infra/models/user_model.dart';


class DataSourceFirebase implements IDataSource{

  FirebaseAuth authInstace;

  DataSourceFirebase({required this.authInstace});

  @override
  Future<UserLoginModel> siginWithEmail(String? email, String? password)async{
    
    final user = await authInstace.signInWithEmailAndPassword(email: email!, password: password!);
    final userData = user.user;
    
    return UserLoginModel(
      uid: userData!.uid, 
      email: userData.email, 
    );
  
  
  }
  

}


