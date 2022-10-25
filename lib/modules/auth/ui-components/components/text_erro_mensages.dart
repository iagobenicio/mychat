import 'package:flutter/material.dart';
import '../../registrer/domain/erros/register_erros.dart';
import '../../registrer/presenter/register_states.dart';


class TextErroMenssage extends StatelessWidget {

  final RegisterFailure condition;

  const TextErroMenssage({Key? key, required this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (condition.registerErro is InvalidEmail) {

      final erroEmail = (condition.registerErro as InvalidEmail);
      
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(erroEmail.mensage),
      );

    }else if(condition.registerErro is InvalidPassword){
      
      final erroPassword = (condition.registerErro as InvalidPassword);

      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(erroPassword.mensage),
      );

    }else if(condition.registerErro is InvalidData){

      final erroData = (condition.registerErro as InvalidData);

      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(erroData.mensage),
      );

    }else if(condition.registerErro is CreateAccountErro){

      final erro = (condition.registerErro as CreateAccountErro);

      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(erro.mensage),
      );

    }
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: null,
    );
  }
}