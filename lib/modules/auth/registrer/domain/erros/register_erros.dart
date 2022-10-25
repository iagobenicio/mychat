abstract class IRegisterErros{}


class InvalidData implements IRegisterErros{
  String mensage;

  InvalidData({required this.mensage});
}

class InvalidEmail implements IRegisterErros{
  String mensage;

  InvalidEmail({required this.mensage});
}

class InvalidPassword implements IRegisterErros{
  String mensage;

  InvalidPassword({required this.mensage});
}

class CreateAccountErro implements IRegisterErros{
  String mensage;

  CreateAccountErro({required this.mensage});
}