import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';
import 'package:mychat/modules/app-chat/mensages/infra/datasources/mensages_datasource.dart';
import 'package:mychat/modules/app-chat/mensages/infra/repositories/mensages_repository.dart';

class DataSourceMock extends Mock implements IMensagesDataSource{}


void main() {
  final ds = DataSourceMock();
  final repository = MensagesRepositoryIMPL(mensageDataSoruce: ds);

  test("deve retornar uma lista de mensages", (){
    
    Timestamp timestamp = Timestamp.now();
    when(()=>ds.getAllMensages("anychatuid")).thenAnswer((_) => Stream.value([
      {
        "uidMensage":"uid",
        "mensage":"Olá",
        "sendby":"uidUser",
        "created":timestamp.toDate()
      }
    ]));

    expectLater(repository.getAllMensages("anychatuid"), emits(isA<List<MensagesEntitie>>()));

  });

}