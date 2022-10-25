abstract class RegisterEvents {}

class Register implements RegisterEvents{
  String email;
  String name;
  String password;
  String confirmPassword;


  Register({required this.email, required this.name, required this.password, required this.confirmPassword});
}