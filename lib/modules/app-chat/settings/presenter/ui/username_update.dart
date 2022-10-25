import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mychat/modules/app-chat/settings/domain/erros/profile_erros.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc_state.dart';
import '../../../../../core/user_logged.dart';
import '../../domain/usecases/update_userprofile.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_bloc_events.dart';


class UserNameUpdate extends StatefulWidget {

  final UserLoggedInfo userLoggedInfo;

  const UserNameUpdate({Key? key, required this.userLoggedInfo}) : super(key: key);

  @override
  State<UserNameUpdate> createState() => _UserNameUpdateState();
}

class _UserNameUpdateState extends State<UserNameUpdate> {

  final updateUserBloc = UpdateUserBloc(updateUser: GetIt.instance.get<IUpdateUserImage>(), updateUserName: GetIt.instance.get<IUpdateUserName>()); 
  final textEdittingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Atualizar Nome",
              style: TextStyle(
                color: Color.fromRGBO(75, 68, 83, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            TextField(
              controller: textEdittingController,
              cursorColor: Color.fromRGBO(75, 68, 83, 1),
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(
                  color: Color.fromRGBO(75, 68, 83, 1)
                ),  
                focusColor: Color.fromRGBO(75, 68, 83, 1),
                focusedBorder: OutlineInputBorder(         
                  borderSide: BorderSide(
                    color: Color.fromRGBO(75, 68, 83, 1)
                  ),
                  borderRadius: BorderRadius.circular(7)
                ),
                label: Text("nome"),
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 520),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(75, 68, 83, 1)
                  ),
                  borderRadius: BorderRadius.circular(7)
                )
              ),
            ),
            StreamBuilder(
            stream: updateUserBloc.stream,
            builder: (context, snapshot){
      
              final blocState = updateUserBloc.state;
      
              if (blocState is Loading) {
      
                return CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1));
      
              }
              if (blocState is SuccessUpdaUser) {
      
                return Text("Nome alterado");
      
              }
      
              if (blocState is FailureUser) {
      
                final mensage = (blocState.failure as FailureUpdateUser);
      
                return Column(
                  children: [
                    Text(mensage.mensage),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.purple[400])
                      ),
                      onPressed: (){
                        updateUserBloc.add(UpdateUserName(currentUser: widget.userLoggedInfo.userUid!, newUsername: textEdittingController.text));
                      }, 
                      child: Text("Atualizar")
                    )
                  ]
                );
      
              }
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple[400])
                ),
                onPressed: (){
                  updateUserBloc.add(UpdateUserName(currentUser: widget.userLoggedInfo.userUid!, newUsername: textEdittingController.text));
                }, 
                child: Text("Atualizar")
              );
            }),
          ],
        ),
      ),
    );
  }
}