import '../repository/mensages_repository.dart';

abstract class IDeleteMensage{
  Future<void> deleteMensage(String mensageUid, String chatUid);
}

class DeleteMensageIMPL implements IDeleteMensage{

   IMensageRepository repository;

   DeleteMensageIMPL({required this.repository});

  @override
  Future<void> deleteMensage(String mensageUid, String chatUid)async{
    return await repository.deleteMensage(mensageUid, chatUid);
  }

}