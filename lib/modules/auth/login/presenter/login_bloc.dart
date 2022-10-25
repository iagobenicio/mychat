import 'package:bloc/bloc.dart';
import '../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvents,LoginStates>{

  ILoginUseCase loginUseCase;


  LoginBloc({required this.loginUseCase}) : super(InitLogin()){

    on<Login>((event, emit)async{

      emit(LoginLoading());

      final result = await loginUseCase.login(event.email, event.password);
      
      result.fold(
        (left) => emit(LoginFailure(left)), 
        (right) => emit(LoginSuccess(right))
      );

    });

  }

}