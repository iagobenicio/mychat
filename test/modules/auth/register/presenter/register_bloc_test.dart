import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/registrer/domain/entities/register_entities.dart';
import 'package:mychat/modules/auth/registrer/domain/usecases/register_with_email_password_usecase.dart';
import 'package:mychat/modules/auth/registrer/domain/erros/register_erros.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_bloc.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_events.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_states.dart';


class RegisterUseCaseMock extends Mock implements IRegisterWithEmailAndPassword {}


void main() {
  
  final useCase = RegisterUseCaseMock();
  final registerBloc = RegisterBloc(registerUsecase: useCase);

  test("deve emitir em ordem resultando em novo user", ()async{
    
    when(()=>useCase.regiterWithEmailAndPaswword(email: "anyemail", name: "any", password: "any", confirmPassword: "any")).thenAnswer((_) async => 
      Right(UserRegisterLoginEntity(uid: "uidUser", email: "newUser"))
    );

    expectLater(registerBloc.stream, emitsInOrder(
      [
        isA<RegisterLoading>(),
        isA<RegisterSuccess>().having((p0) => p0.userRegister.uid, "verifica uid do user", equals("uidUser"))
      ]
    ));

    registerBloc.add(Register(email: "anyemail", name: "any", password: "any", confirmPassword: "any"));
    

  });

  test("deve emitir em ordem resultando em um erro", ()async{
    
    when(()=>useCase.regiterWithEmailAndPaswword(email: "anyemail", name: "any", password: "any", confirmPassword: "any")).thenAnswer((_) async => 
      Left(InvalidData(mensage: "preencha todos os campos"))
    );

    expectLater(registerBloc.stream, emitsInOrder(
      [
        isA<RegisterLoading>(),
        isA<RegisterFailure>().having((p0) => p0.registerErro, "verifica o tipo de erro", isA<InvalidData>())
      ]
    ));

    registerBloc.add(Register(email: "anyemail", name: "any", password: "any", confirmPassword: "any"));
    

  });


}