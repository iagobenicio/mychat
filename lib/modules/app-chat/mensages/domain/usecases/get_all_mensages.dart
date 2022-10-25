import '../entities/mensages_entitie.dart';
import '../repository/mensages_repository.dart';

abstract class IGetAllMensages{
  Stream<List<MensagesEntitie>> getMensagesAndListner(String chatUid);
}


class GetAllMensagesIMPL implements IGetAllMensages{

  IMensageRepository repository;

  GetAllMensagesIMPL({required this.repository});

  @override
  Stream<List<MensagesEntitie>> getMensagesAndListner(String chatUid) {
    return repository.getAllMensages(chatUid);
  }

}