import '../../chats/domain/entities/user_chat_entitie.dart';
import '../../chats/domain/erros/getchats_erros.dart';
import '../domain/entities/users_entitie.dart';
import '../domain/erros/search_erro.dart';

abstract class SearchStates{}

class SearchInitState implements SearchStates {}

class UsersState implements SearchStates{

  List<UserEntitie> users;

  UsersState({required this.users});

}

class FailureSearchState implements SearchStates{

  ISerachErro erro;

  FailureSearchState({required this.erro});

}
class ChatWithContactOrNew implements SearchStates{

  UserChatEntitie chatOrNew;

  ChatWithContactOrNew({required this.chatOrNew});
  

}

class LoadingSearch implements SearchStates{}

class SuccessCreateChatBySearch implements SearchStates{

  String mensage;

  SuccessCreateChatBySearch({required this.mensage});

}

class FailureCreateChatBySearch implements SearchStates{

  FailureCreateChat failure;

  FailureCreateChatBySearch({required this.failure});

}