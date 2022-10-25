abstract class LoginEvents{}


class Login implements LoginEvents{
  String email;
  String password;

  Login({required this.email, required this.password});
}

