abstract class LoginErros {}

class InvalidEmail implements LoginErros{
  String? mensage;

  InvalidEmail(this.mensage);
}

class InvalidPassword implements LoginErros{
  String? mensage;

  InvalidPassword(this.mensage);
}

class AuthError implements LoginErros{
  String? mensage;

  AuthError(this.mensage);
}