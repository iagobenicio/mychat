import '../models/user_register_model.dart';


abstract class IRegisterDataSource{

  Future<UserRegisterLoginModel> registerUser({required String email, required String name, required String password, required String confirmPassword});

}