

import 'package:firebase_auth/firebase_auth.dart';

abstract class Ilogout{

  Future<void> logout();

}

class LogoutIMPL implements Ilogout{

   FirebaseAuth authInstace;

  LogoutIMPL({required this.authInstace});

  @override
  Future<void> logout()async{
    try {
      await authInstace.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }

}