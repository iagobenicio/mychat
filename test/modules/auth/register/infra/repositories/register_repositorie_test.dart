import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mychat/modules/auth/registrer/domain/erros/register_erros.dart';
import 'package:mychat/modules/auth/registrer/domain/entities/register_entities.dart';
import 'package:mychat/modules/auth/registrer/infra/datasource/register_datasource.dart';
import 'package:mychat/modules/auth/registrer/infra/models/user_register_model.dart';
import 'package:mychat/modules/auth/registrer/infra/repositories/register_repositorie.dart';
import 'package:mocktail/mocktail.dart';


class DataSourceMock extends Mock implements IRegisterDataSource{}



void main() {

  
  final datasourceMock = DataSourceMock();
  final repository = RegisterRepositorieIMPL(datasource: datasourceMock);
  

  test("Deve retorna um objeto de UserRegister ", ()async{
    

    when(()=> datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenAnswer((_) async => UserRegisterLoginModel(
      uid: "anyuid", email: "anyemail@gmail.com"
      )
    );

    final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");
    
    expect(resultUser.fold(id, id), isA<UserRegisterLoginEntity>().having((user) => user.uid, "verifica uid do user mockado", equals("anyuid")));

  });
     
  group("Test exceptions", (){
    
      
    test("Deve retorna um AuthException com código 'email-already-in-use' ", ()async{
      
      when(() => datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenThrow(
        FirebaseAuthException(code: "email-already-in-use")
      );

      final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");

      expect(resultUser.fold(id, id), isA<InvalidEmail>().having((mensage) => mensage.mensage, "verifica mensagem de erro", equals("Este email já existe")));


    });

    test("Deve retorna um AuthException com código 'invalid-email' ", ()async{
      
      when(() => datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenThrow(
        FirebaseAuthException(code: "invalid-email")
      );

      final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");

      expect(resultUser.fold(id, id), isA<InvalidEmail>().having((mensage) => mensage.mensage, "verifica mensagem de erro", equals("Insira um email válido")));


    });

    test("Deve retorna um AuthException com código 'weak-password' ", ()async{
      
      when(() => datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenThrow(
        FirebaseAuthException(code: "weak-password")
      );

      final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");

      expect(resultUser.fold(id, id), isA<InvalidPassword>().having((mensage) => mensage.mensage, "verifica mensagem de erro", equals("Insira uma senha forte")));


    });

    test("Deve retorna um AuthException com código 'operation-not-allowed' ", ()async{
      
      when(() => datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenThrow(
        FirebaseAuthException(code: "operation-not-allowed")
      );

      final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");

      expect(resultUser.fold(id, id), isA<CreateAccountErro>().having((mensage) => mensage.mensage, "verifica mensagem de erro", equals("Não foi possivel criar uma conta")));


    });

    test("Deve retorna uma Exception ", ()async{
    
      when(() => datasourceMock.registerUser(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword")).thenThrow(
        Exception()
      );

      final resultUser = await repository.register(email: "anyemail@gmail", name: "any", password: "anypassword", confirmPassword: "anypassword");

      expect(resultUser.fold(id, id), isA<CreateAccountErro>());


    });

  });
 
}