import 'package:bloc/bloc.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_events.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_states.dart';

import '../domain/usecases/register_with_email_password_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvents,RegisterStates>{

  IRegisterWithEmailAndPassword registerUsecase;  

  RegisterBloc({required this.registerUsecase}) : super(InitRegister()){

    on<Register>((event, emit)async{

      emit(RegisterLoading());

      final result = await registerUsecase.regiterWithEmailAndPaswword(email: event.email, name: event.name, password: event.password, confirmPassword: event.confirmPassword);

      result.fold(
        (erro) => emit(RegisterFailure(erro)), 
        (user) => emit(RegisterSuccess(user))
      );


    });

  }

  

}