import '../../domain/entities/mensages_entitie.dart';

class MensageModel extends MensagesEntitie{

  MensageModel({required super.mensageUid, required super.mensage, required super.sendBy, required super.timestamp});

  factory MensageModel.fromMap(Map<String,dynamic> mensages){
    return MensageModel(
      mensageUid: mensages["uidMensage"], 
      mensage: mensages["mensage"], 
      sendBy: mensages["sendby"], 
      timestamp: mensages["created"]
    );
  }

  

}