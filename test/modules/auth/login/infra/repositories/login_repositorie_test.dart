import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/login/domain/enittys/login.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';
import 'package:mychat/modules/auth/login/infra/datasource/login_datasource.dart';
import 'package:mychat/modules/auth/login/infra/models/user_model.dart';
import 'package:mychat/modules/auth/login/infra/repositories/login_repositorie.dart';

class DataSourceMock extends Mock implements IDataSource{}

void main() {

  final datasourceMock = DataSourceMock();
  final repository = LoginRepositoryIMPL(datasource: datasourceMock);

  test("Deve retornar um objeto de UserLogin", ()async{

    when(()=>datasourceMock.siginWithEmail(any(),any())).thenAnswer((_) async => UserLoginModel(uid:"ib8s8sf8a8fa", email: "iagoteste@gmail.com",));


    final result = await repository.login("iagob@gmail.com", "000000");
      
    expect(result.fold(id, id), isA<UserLoginEntity>());


  });

  test("Deve retornar um InvalidEmail de email não existente", ()async{

    when(()=>datasourceMock.siginWithEmail(any(), any())).thenThrow(FirebaseAuthException(code: "user-not-found"));

    final result = await repository.login("iagob@gmail.com", "000000");

    expect(result.fold(id, id), isA<InvalidEmail>());
    expect(result.fold(id, id), isA<InvalidEmail>().having((p0) => p0.mensage, "", equals("Este email não existe")));
    
  });


  test("Deve retornar um InvalidPassword de senha incorreta", ()async{

    when(()=>datasourceMock.siginWithEmail(any(), any())).thenThrow(FirebaseAuthException(code: "wrong-password"));

    final result = await repository.login("iagob@gmail.com", "000000");

    expect(result.fold(id, id), isA<InvalidPassword>());
    expect(result.fold(id, id), isA<InvalidPassword>().having((p0) => p0.mensage, "", equals("A senha está incorreta")));
    
  });

  test("Deve retornar um InvalidEmail de email inválido", ()async{

    when(()=>datasourceMock.siginWithEmail(any(), any())).thenThrow(FirebaseAuthException(code: "invalid-email"));

    final result = await repository.login("iagob@gmail.com", "000000");

    expect(result.fold(id, id), isA<InvalidEmail>());
    expect(result.fold(id, id), isA<InvalidEmail>().having((p0) => p0.mensage, "", equals("Digite um email válido")));
    
  });

  test("Deve retornar um InvalidEmail de email desabilitado", ()async{

    when(()=>datasourceMock.siginWithEmail(any(), any())).thenThrow(FirebaseAuthException(code: ""));

    final result = await repository.login("iagob@gmail.com", "000000");

    expect(result.fold(id, id), isA<InvalidEmail>());
    expect(result.fold(id, id), isA<InvalidEmail>().having((p0) => p0.mensage, "", equals("Este email está desabilitado")));
    
  });

  test("Deve retornar um throw exception", ()async{

    when(()=>datasourceMock.siginWithEmail(any(), any())).thenThrow(Exception());

    final result = await repository.login("iagob@gmail.com", "000000");

    expect(result.fold(id,id), isA<AuthError>());

  });

}

  
