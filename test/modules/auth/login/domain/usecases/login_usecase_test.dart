import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/login/domain/enittys/login.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';
import 'package:mychat/modules/auth/login/domain/repositories/login_repository.dart';
import 'package:mychat/modules/auth/login/domain/usecases/login_usecase.dart';


class RepositoryMock extends Mock implements ILoginRepository{}


void main() { 
  final repositorymock = RepositoryMock();
  final usecase = LoginUseCase(repository: repositorymock);

  test("Deve retornar uma entidade de UserLoginEntity", ()async{
  
  when(()=>repositorymock.login(any(),any())).thenAnswer((_) async => Right(UserLoginEntity(uid:"ib8s8sf8a8fa", email: "iagoteste@gmail.com")));


  final result = await usecase.login("aa", "aaa");
    
  expect(result.isRight(),true);


  });

  test("Deve retornar um erro de email inválido", ()async{
  
  when(()=>repositorymock.login(any(),any())).thenAnswer((_) async => Right(UserLoginEntity(uid:"ib8s8sf8a8fa", email: "iagoteste@gmail.com")));


  final result = await usecase.login("", "asdasda");
    
  expect(result.fold(id, id), isA<InvalidEmail>());

  });

  test("Deve retornar um erro de senha inválida", ()async{
  
  when(()=>repositorymock.login(any(),any())).thenAnswer((_) async => Right(UserLoginEntity(uid:"ib8s8sf8a8fa", email: "iagoteste@gmail.com")));


  final result = await usecase.login("adasda", null);
    
  expect(result.fold(id, id), isA<InvalidPassword>());

  });



}