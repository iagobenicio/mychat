import 'package:mychat/modules/app-chat/mensages/domain/entities/mensages_entitie.dart';

abstract class IMemsagesStates{}

class InitMensageState implements IMemsagesStates{}

class ShowNewMensages implements IMemsagesStates{

  List<MensagesEntitie> newMensages;

  ShowNewMensages({required this.newMensages});
  
}


