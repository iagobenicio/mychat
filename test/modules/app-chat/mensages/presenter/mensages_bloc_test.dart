import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/delete_mensage.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/get_all_mensages.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/send_mensage.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_bloc.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_events.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_state.dart';


class GetMensagesUsMock extends Mock implements IGetAllMensages{}
class DeleteMensageUsMock extends Mock implements IDeleteMensage{}
class SendMensageUsMock extends Mock implements ISendMensage{}
class MocMensages extends Mock implements MensagesEntitie{}

void main() {

  final getMensagesUsMock = GetMensagesUsMock();
  final deleteMensageUsMock = DeleteMensageUsMock();
  final sendMensageUsMock = SendMensageUsMock();

  final bloc = MensagesBloc(getMensagesUs: getMensagesUsMock, deleteMensageUs: deleteMensageUsMock, sendMensageUs: sendMensageUsMock);

  test("deve emitir um estado ShowNewMensages", (){

    when(()=>getMensagesUsMock.getMensagesAndListner("uidchat")).thenAnswer((_) => Stream.value([MocMensages(),MocMensages()]));

    expectLater(bloc.stream, emits(isA<ShowNewMensages>().having((p0) => p0.newMensages.length, "", equals(2))));

    bloc.add(GetMensagesEvent(chatUid: "uidchat"));

  });

}