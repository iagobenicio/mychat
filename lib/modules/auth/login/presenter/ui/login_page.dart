import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mychat/modules/auth/login/domain/erros/login_errors.dart';
import 'package:mychat/modules/auth/login/presenter/login_bloc.dart';
import 'package:mychat/modules/auth/login/presenter/login_event.dart';
import 'package:mychat/modules/auth/login/presenter/login_state.dart';
import 'package:mychat/modules/auth/ui-components/components/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/user_logged.dart';
import '../../../ui-components/components/custon_button.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  final bloc = LoginBloc(loginUseCase: GetIt.instance.get<ILoginUseCase>());


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
        padding: EdgeInsets.fromLTRB(18,0,18,18),
        child: SingleChildScrollView(
          child: Column( 
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 174),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                    child: SizedBox(
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color.fromRGBO(75, 68, 83, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: CustomTextField(fieldIcon: Icons.email, fieldControllerText: email,)
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomTextField(fieldIcon: Icons.key, fieldDataObscure: true, fieldControllerText: password,)
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: BlocConsumer<LoginBloc,LoginStates>(
                  bloc: bloc,
                  listener: (context, state)async{
                    if (state is LoginSuccess) {
                      await bloc.close().then(
                        (value){
                          final userlogged = UserLoggedInfo();
                          userlogged.setUid(state.userLogin.uid);
                          userlogged.setEmail(state.userLogin.email);
                          Navigator.of(context).pushNamedAndRemoveUntil("/chats-page", (route) => false, arguments: userlogged);
                        }
                      );
                    }
                  },
                  buildWhen: (previous, current){
                    if (previous is LoginLoading && current is LoginSuccess) {
                      return false;
                    } 
                    return true;
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1),);
                    }
                    if (state is LoginFailure) {
                      if (state.loginErro is InvalidEmail) {
                        final invalidEmail = (state.loginErro as InvalidEmail);
                        return Column(
                          children: [
                            ButtonAction(
                              buttonName: "ENTRAR",
                              action: (){
                                bloc.add(Login(email: email.text, password: password.text));
                              }
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(invalidEmail.mensage.toString(),style: TextStyle(color: Color.fromARGB(255, 231, 79, 79)))
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "/register-page");
                                }, 
                                child: Text("Cadastre-se ",style: TextStyle(color: Color.fromRGBO(75, 68, 83, 1))),
                              )
                            ),
                          ]
                        );
                      }
                      if (state.loginErro is InvalidPassword) {
                        final invalidPassword = (state.loginErro as InvalidPassword);
                        return Column(
                          children: [
                            ButtonAction(
                              buttonName: "ENTRAR",
                              action: (){
                                bloc.add(Login(email: email.text, password: password.text));
                              }
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(invalidPassword.mensage.toString(),style: TextStyle(color: Color.fromARGB(255, 231, 79, 79)))
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "/register-page");
                                }, 
                                child: Text("Cadastre-se ",style: TextStyle(color: Color.fromRGBO(75, 68, 83, 1))),
                              )
                            ),
                          ]
                        );
                      }
                    }
                    return Column(
                      children: [
                        ButtonAction(
                          buttonName: "ENTRAR",
                          action: (){
                            bloc.add(Login(email: email.text, password: password.text));
                          }
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, "/register-page");
                            }, 
                            child: Text("Cadastre-se ",style: TextStyle(color: Color.fromRGBO(75, 68, 83, 1))),
                          )
                        ),
                      ]
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}