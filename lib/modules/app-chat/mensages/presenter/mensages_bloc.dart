import 'dart:async';

import 'package:bloc/bloc.dart';
import '../domain/usecases/delete_mensage.dart';
import '../domain/usecases/get_all_mensages.dart';
import '../domain/usecases/send_mensage.dart';
import 'mensages_events.dart';
import 'mensages_state.dart';

class MensagesBloc extends Bloc<IMemsagesEvents,IMemsagesStates>{

  IGetAllMensages getMensagesUs;
  IDeleteMensage deleteMensageUs;
  ISendMensage sendMensageUs;
  late final StreamSubscription mensagesStream;
  
  MensagesBloc({required this.getMensagesUs, required this.deleteMensageUs, required this.sendMensageUs}) : super(InitMensageState()){

    on<SendMensageEvent>(((event, emit)async{

      if (event.chatInfoToSendMensage.isNewChat) {

        await sendMensageUs.sendMensageAndCreateNewChat(

          event.mensage, event.currentUser, event.chatInfoToSendMensage.chatUid, event.chatInfoToSendMensage.contactUid!

        ).then((value){
          event.chatInfoToSendMensage.isNewChat = false;
          add(GetMensagesEvent(chatUid: event.chatInfoToSendMensage.chatUid));
        });

      }
      else{
        await sendMensageUs.sendMensage(event.mensage, event.currentUser, event.chatInfoToSendMensage.chatUid);
      }

    }));

    on<DeleteMensageEvent>(((event, emit)async{
      await deleteMensageUs.deleteMensage(event.mensageUid, event.chatUid);
    }));

    on<GetMensagesEvent>(((event, emit){

      final newMensages = NewMensagesEvent();

      mensagesStream = getMensagesUs.getMensagesAndListner(event.chatUid).listen((event){

        newMensages.setNewMensages(event);
        add(newMensages);

      });

    }));
    

    on<NewMensagesEvent>((event, emit){
      emit(ShowNewMensages(newMensages: event.mensages));
    });

  }

  @override
  Future<void> close()async{
    await mensagesStream.cancel();
    return super.close();
  }

}
