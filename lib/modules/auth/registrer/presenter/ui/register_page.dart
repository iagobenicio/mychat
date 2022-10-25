import 'package:flutter/material.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_bloc.dart';
import 'package:mychat/modules/auth/registrer/presenter/register_events.dart';
import 'package:mychat/modules/auth/ui-components/components/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/user_logged.dart';
import '../../../ui-components/components/custon_button.dart';
import '../../../ui-components/components/text_erro_mensages.dart';
import '../../domain/usecases/register_with_email_password_usecase.dart';
import '../register_states.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final bloc = RegisterBloc(registerUsecase: GetIt.instance.get<IRegisterWithEmailAndPassword>());


  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color.fromRGBO(254, 247, 255, 1)),
        padding: EdgeInsets.fromLTRB(18,10,18,18),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 80),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
              CustomTextField(fieldIcon: Icons.email, fieldControllerText: email),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: CustomTextField(fieldIcon: Icons.person, fieldControllerText: name)
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: CustomTextField(fieldIcon: Icons.key, fieldDataObscure: true, fieldControllerText: password)
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: CustomTextField(fieldIcon: Icons.key, fieldDataObscure: true, fieldControllerText: confirmPassword)
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: BlocConsumer<RegisterBloc,RegisterStates>(
                  bloc: bloc,
                  listener: (context, state)async{
                    if (state is RegisterSuccess) {
                      await bloc.close().then(
                        (value){
                          final userlogged = UserLoggedInfo();
                          userlogged.setUid(state.userRegister.uid);
                          userlogged.setEmail(state.userRegister.email);
                          Navigator.of(context).pushNamedAndRemoveUntil("/chats-page", (route) => false,arguments: userlogged);
                        }
                      );
                    }
                  },
                  buildWhen: (previous, current){
                    if (previous is RegisterLoading && current is RegisterSuccess) {
                      return false;
                    } 
                    return true;
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1),);
                    }
                    if (state is RegisterFailure) {
                      return Column(
                        children: [
                          ButtonAction(
                            buttonName: "CADASTRAR",
                            action: (){
                              bloc.add(Register(email: email.text, name: name.text, password: password.text, confirmPassword: confirmPassword.text));
                            }
                          ),
                          TextErroMenssage(condition: state,),
                        ]
                      );
                    }
                    return Column(
                      children: [
                        ButtonAction(
                           buttonName: "CADASTRAR",
                          action: (){
                            bloc.add(Register(email: email.text, name: name.text, password: password.text, confirmPassword: confirmPassword.text));
                          }
                        ),
                      ]
                    );
                  },
                )
              )
            ],
          ),
        ),
    
      ),
    );
  }
}