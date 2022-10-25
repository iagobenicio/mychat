import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';
import 'package:mychat/modules/app-chat/mensages/domain/repository/mensages_repository.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/get_all_mensages.dart';



class RepoMock extends Mock implements IMensageRepository{}
class MockObject extends Mock implements MensagesEntitie{}

void main() {

  final repoMock = RepoMock();
  final getMensages = GetAllMensagesIMPL(repository: repoMock);


  test("deve retornar uma lista de mensagens", (){

    when(()=>repoMock.getAllMensages("anychatuid")).thenAnswer((_) => Stream.value([MockObject()]));

    expect(getMensages.getMensagesAndListner("anychatuid"), emits(isA<List<MockObject>>()));


  });
  

}