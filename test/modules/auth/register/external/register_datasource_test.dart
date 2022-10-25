import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mychat/modules/auth/registrer/external/datasource/register_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';



void main() {

  final mockFirestore = FakeFirebaseFirestore();
  var mockAuth = MockFirebaseAuth();
  var datasource = RegisterDataSourceIMPL(firebaseAuth: mockAuth, firestore: mockFirestore);

  test("deve retorna um objeto de novo User", ()async{
    
    final result = await datasource.registerUser(email: "emailmock", name: "namemock", password: "passmock", confirmPassword: "passmock");
    final collection = await mockFirestore.collection("users").doc(result.uid).get();
    final userData = collection.data();

    expect(result.email, equals("emailmock"));
    expect(userData!["name"], equals("namemock"));
    

  });

  group("test de exceptions", (){

    test("deve retorna uma exception de code: email-already-in-use", ()async{

      mockAuth = MockFirebaseAuth(authExceptions: AuthExceptions(createUserWithEmailAndPassword: FirebaseAuthException(code: "email-already-in-use")));
      datasource = RegisterDataSourceIMPL(firebaseAuth: mockAuth, firestore: mockFirestore);

      expectLater(
        datasource.registerUser(email: "emailmock", name: "namemock", password: "passmock", confirmPassword: "passmock"), 
        throwsA(isA<FirebaseAuthException>().having((p0) => p0.code, "deve bater com code mockado", equals("email-already-in-use")))
      );

    });

    test("deve retorna uma exception de code: invalid-email", ()async{

      mockAuth = MockFirebaseAuth(authExceptions: AuthExceptions(createUserWithEmailAndPassword: FirebaseAuthException(code: "invalid-email")));
      datasource = RegisterDataSourceIMPL(firebaseAuth: mockAuth, firestore: mockFirestore);

      expectLater(
        datasource.registerUser(email: "emailmock", name: "namemock", password: "passmock", confirmPassword: "passmock"), 
        throwsA(isA<FirebaseAuthException>().having((p0) => p0.code, "deve bater com code mockado", equals("invalid-email")))
      );

    });

    test("deve retorna uma exception de code: weak-password", ()async{

      mockAuth = MockFirebaseAuth(authExceptions: AuthExceptions(createUserWithEmailAndPassword: FirebaseAuthException(code: "weak-password")));
      datasource = RegisterDataSourceIMPL(firebaseAuth: mockAuth, firestore: mockFirestore);

      expectLater(
        datasource.registerUser(email: "emailmock", name: "namemock", password: "passmock", confirmPassword: "passmock"), 
        throwsA(isA<FirebaseAuthException>().having((p0) => p0.code, "deve bater com code mockado", equals("weak-password")))
      );

    });

    test("deve retorna uma exception de code: operation-not-allowed", ()async{

      mockAuth = MockFirebaseAuth(authExceptions: AuthExceptions(createUserWithEmailAndPassword: FirebaseAuthException(code: "operation-not-allowed")));
      datasource = RegisterDataSourceIMPL(firebaseAuth: mockAuth, firestore: mockFirestore);

      expectLater(
        datasource.registerUser(email: "emailmock", name: "namemock", password: "passmock", confirmPassword: "passmock"), 
        throwsA(isA<FirebaseAuthException>().having((p0) => p0.code, "deve bater com code mockado", equals("operation-not-allowed")))
      );

    });

  });
  
}