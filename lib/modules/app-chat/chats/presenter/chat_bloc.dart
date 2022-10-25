import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mychat/modules/app-chat/chats/domain/usecases/get_chats.dart';
import 'package:mychat/modules/app-chat/chats/presenter/chat_events.dart';
import 'package:mychat/modules/app-chat/chats/presenter/chat_states.dart';


class ChatBloc extends Bloc<ChatEvents,ChatStates>{

  IGetChatsUseCase getChatsUsecase;
  late final StreamSubscription subscription;
  
  ChatBloc({required this.getChatsUsecase}) : super(LoadingChats()){

    
    
    on<GetAllChatsAndListnen>((event, emit){
      
      subscription = getChatsUsecase.getChats(event.uidUser).listen((event) {
        add(NewChats(result: event));
      });
      
    });

    on<NewChats>((event, emit){
      event.result.fold(
        (l){emit(ChatErros(erro: l));}, 
        (r){emit(EmitChats(chats: r));}
      );
    });



  }
   
  @override
  Future<void> close()async{
    await subscription.cancel();
    await super.close();
  }
  
}