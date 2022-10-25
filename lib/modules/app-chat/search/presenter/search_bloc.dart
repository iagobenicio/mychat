import 'package:bloc/bloc.dart';
import '../../chats/domain/usecases/get_chat_with_contact_uid.dart';
import 'search_bloc_events.dart';
import 'search_bloc_states.dart';
import '../domain/usecases/search_user.dart';

class SearchBloc extends Bloc<SearchEvents,SearchStates>{

  ISearchUser searchUserUseCsae;
  IGetChatWithContactUid getChatWithContactUid;
  
  SearchBloc({required this.searchUserUseCsae, required this.getChatWithContactUid}) : super(SearchInitState()){

    on<GetUsers>((event, emit)async{

      emit(LoadingSearch());
      final users = await searchUserUseCsae.searchUser(event.data);

      users.fold(
        (l) => emit(FailureSearchState(erro: l)), 
        (r) => emit(UsersState(users: r))
      );

    });

    on<GetChatOrNewChat>((event, emit)async{

      final chatOrNewChat = await getChatWithContactUid.getChatWithContactUid(event.myUid, event.contact);
      emit(ChatWithContactOrNew(chatOrNew: chatOrNewChat));

    });

  }

  

}