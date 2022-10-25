import '../models/user_model.dart';

abstract class IDataSource{
  Future<UserLoginModel> siginWithEmail(String? email, String? password);
}