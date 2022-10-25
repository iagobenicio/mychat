import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mychat/modules/app-chat/settings/domain/erros/profile_erros.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc_events.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc_state.dart';
import '../../../../auth/logout/external/logout.dart';
import '../../domain/usecases/get_userprofile.dart';
import '../../domain/usecases/update_userprofile.dart';

class SettingsBloc extends Bloc<ProfileEvents,ProfileStates>{
  
  IGetUserProfile getUser;
  Ilogout logout;

  SettingsBloc({required this.getUser, required this.logout}) : super (Loading()){

    on<GetUser>((event, emit)async{

      final user = await getUser.getUserProfile(event.currentUser);
      user.fold(
        (user) => emit(LoadedUserProfile(user: user)),
        (failure) => emit(FailureUser(failure: failure))
      );
      
    });

    on<LogoutEvent>((event, emit)async{
      emit(Loading());
      await logout.logout();
      emit(LogoutState());
    });

  }
  
}

class UpdateUserBloc extends Bloc<ProfileUpdateEvents,ProfileStates>{

  IUpdateUserImage updateUser;
  IUpdateUserName updateUserName;
  late final StreamSubscription subscription;

  UpdateUserBloc({required this.updateUser, required this.updateUserName}) : super(InitState()){

    on<UpdateUserName>((event, emit)async{

      emit(Loading());

      final result = await updateUserName.updateUserName(event.currentUser, event.newUsername);

      if (result == null) {
        
        emit(SuccessUpdaUser(mensage: "Nome alterado"));
        
      }else{

        emit(FailureUser(failure: FailureUpdateUser(mensage: result.mensage)));

      }

    });

    on<UpdateImageProfile>((event, emit){

      subscription = updateUser.updateUserImage(event.currentUser, event.newImage).listen((currentSnapshot){
        add(UpdateUserProfileStatus(taskSnapshot: currentSnapshot));
      });

    });

    on<UpdateUserProfileStatus>((event, emit){

      if (event.taskSnapshot.state == TaskState.running) {
        emit(Loading());
      }else{
        if (event.taskSnapshot.state == TaskState.success){
          emit(SuccessUpdaUser(mensage: "Foto alterada"));
        }else{
          emit(FailureUser(failure: FailureUpdateUser(mensage: "Não foi possível alterar a foto")));
        }
      }

    });

  }
  
  @override
  Future<void> close()async{
    await subscription.cancel();
    return super.close();
  }

}


