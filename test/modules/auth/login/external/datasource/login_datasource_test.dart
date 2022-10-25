import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mychat/modules/auth/login/external/datasource/login_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/auth/login/infra/models/user_model.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth{}

void main() {

  final userMock = MockUser(uid: "8fhh8f83h8h83f",email: "iagob@gmail.com");
  final firebaseuAuthMock = MockFirebaseAuth(mockUser: userMock);
  final datasourceFirebase = DataSourceFirebase(authInstace: firebaseuAuthMock);
  
  test("deve retorna um objeto de user logado", ()async{
    
    final user = await datasourceFirebase.siginWithEmail("iago@gmail.com", "123123");

    expect(user, isA<UserLoginModel>().having((p0) => p0.email, "", equals("iagob@gmail.com")));


  });

  
  test("deve retorna um exception de code user-not-found ", ()async{
   
    final firebaseuAuthMock = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword: FirebaseAuthException(
          code: 'user-not-found'
          )
        )
      );
    final datasourceFirebase = DataSourceFirebase(authInstace: firebaseuAuthMock);

    expectLater(datasourceFirebase.siginWithEmail("iagob@gmail.com", "123123"), throwsA(
        isA<FirebaseAuthException>().having((p0) => p0.code, 'deve retonrar código: user-not-found', equals("user-not-found"))
      )
    );

  });

  test("deve retorna um exception de code wrong-password", ()async{
   
    final firebaseuAuthMock = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword: FirebaseAuthException(
          code: 'wrong-password'
          )
        )
      );
    final datasourceFirebase = DataSourceFirebase(authInstace: firebaseuAuthMock);

    expectLater(datasourceFirebase.siginWithEmail("iagob@gmail.com", "123123"), throwsA(
        isA<FirebaseAuthException>().having((p0) => p0.code, 'deve retonrar código: wrong-password', equals("wrong-password"))
      )
    );

  });


}