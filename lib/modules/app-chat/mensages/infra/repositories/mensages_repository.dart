import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';
import 'package:mychat/modules/app-chat/mensages/domain/repository/mensages_repository.dart';
import 'package:mychat/modules/app-chat/mensages/infra/models/mensages_model.dart';
import '../datasources/mensages_datasource.dart';


class MensagesRepositoryIMPL implements IMensageRepository{

  IMensagesDataSource mensageDataSoruce;

  MensagesRepositoryIMPL({required this.mensageDataSoruce});

  @override
  Stream<List<MensagesEntitie>> getAllMensages(String chatUid) {
    final mensages = mensageDataSoruce.getAllMensages(chatUid);
    return mensages.map((event) => event.isEmpty ? [] : event.map((e) => MensageModel.fromMap(e)).toList());
  }

  @override
  Future<void> deleteMensage(String mensageUid, String chatUid)async{
    await mensageDataSoruce.deleteMensage(mensageUid, chatUid);
  }

  @override
  Future<void> sendMensage(String mensage, String userUid, String chatUid)async{

    await mensageDataSoruce.sendMensage(mensage, userUid, chatUid);

  }

  @override
  Future<void> sendMensageAndCreateNewChat(String mensage, String userUid, String chatUid, String contactUid)async{

    await mensageDataSoruce.sendMensageAndCreateNewChat(mensage, userUid, chatUid, contactUid);

  }

  
}