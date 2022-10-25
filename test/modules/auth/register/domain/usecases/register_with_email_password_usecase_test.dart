import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/registrer/domain/entities/register_entities.dart';
import 'package:mychat/modules/auth/registrer/domain/erros/register_erros.dart';
import 'package:mychat/modules/auth/registrer/domain/repositories/register_repository.dart';
import 'package:mychat/modules/auth/registrer/domain/usecases/register_with_email_password_usecase.dart';


class RegisterRepositryMock extends Mock implements IRegisterRepository {}



void main() {
  
  final repositoryRegisterMock = RegisterRepositryMock();
  final usecase = RegisterWithEmailAndPassword(repository: repositoryRegisterMock);

  String emailTeste = "teste@teste.com";
  String nameteste = "teste";
  String passwordteste = "testepassword";
  String confirmPassworteste = "testepassword";

  test("Deve retornar um erro de InvalidData", ()async{

    final result = await usecase.regiterWithEmailAndPaswword(email: emailTeste, name: nameteste, password: "", confirmPassword: confirmPassworteste);

    expect(result.fold(id, id), isA<InvalidData>().having((erro) => erro.mensage, "", isNotEmpty));

  });

  test("Deve retorna um erro de InvalidEmail",()async{

    final result = await usecase.regiterWithEmailAndPaswword(email: "teste", name: nameteste, password: passwordteste, confirmPassword: confirmPassworteste);

    expect(result.fold(id, id), isA<InvalidEmail>().having((erro) => erro.mensage, "", isNotEmpty));

  });

  test("Deve retorna um erro de InvalidPassword", ()async{

    final result = await usecase.regiterWithEmailAndPaswword(email: emailTeste, name: nameteste, password: passwordteste, confirmPassword: "passwordnotequals");

    expect(result.fold(id, id), isA<InvalidPassword>().having((erro) => erro.mensage, "", isNotEmpty));

  });

  test("Deve retorna um UserRegisterLoginEntity", ()async{

    when(()=>repositoryRegisterMock.register(email: emailTeste, name: nameteste, password: passwordteste, confirmPassword: confirmPassworteste)).
    thenAnswer((_) async => Right(UserRegisterLoginEntity(uid: "uidany", email: "email@any.com")));

    final result = await usecase.regiterWithEmailAndPaswword(email: emailTeste, name: nameteste, password: passwordteste, confirmPassword: confirmPassworteste);

    expect(result.isRight(), true);

  });


}