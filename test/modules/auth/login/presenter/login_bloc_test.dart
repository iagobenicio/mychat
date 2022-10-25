import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/login/domain/enittys/login.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';
import 'package:mychat/modules/auth/login/domain/usecases/login_usecase.dart';
import 'package:mychat/modules/auth/login/presenter/login_bloc.dart';
import 'package:mychat/modules/auth/login/presenter/login_event.dart';
import 'package:mychat/modules/auth/login/presenter/login_state.dart';


class LoginUseCaseMock extends Mock implements LoginUseCase{}


void main() {
  
  final loginUseCase = LoginUseCaseMock();
  final blocLogin = LoginBloc(loginUseCase: loginUseCase);

  test("deve emiter a ordem sem erro", (){

    when(()=>loginUseCase.login(any(), any())).thenAnswer((_) async => Right(UserLoginEntity(uid: "uid", email: "iagob@gmail.com")));

  
    expect(blocLogin.stream, emitsInOrder([
      isA<LoginLoading>(),
      isA<LoginSuccess>().having((p0) => p0.userLogin, "", isA<UserLoginEntity>())
    ]));

    blocLogin.add(Login(email: "iagob@gmail.com", password: "testeteste"));

  });

  test("deve emiter um erro de email inválido", (){

    when(()=>loginUseCase.login(any(), any())).thenAnswer((_) async => Left(InvalidEmail("email inválido")));

  
    expect(blocLogin.stream, emitsInOrder([
      isA<LoginLoading>(),
      isA<LoginFailure>().having((p0) => p0.loginErro, "", isA<InvalidEmail>())
    ]));

    blocLogin.add(Login(email: "iagob@gmail.com", password: "testeteste"));

  });

  test("deve emiter um erro de senha inválida", (){

    when(()=>loginUseCase.login(any(), any())).thenAnswer((_) async => Left(InvalidPassword("senha inválida")));

  
    expect(blocLogin.stream, emitsInOrder([
      isA<LoginLoading>(),
      isA<LoginFailure>().having((p0) => p0.loginErro, "", isA<InvalidPassword>())
    ]));

    blocLogin.add(Login(email: "iagob@gmail.com", password: "testeteste"));

  });


}