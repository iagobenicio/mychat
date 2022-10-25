import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mychat/modules/app-chat/settings/domain/erros/profile_erros.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc_state.dart';
import '../../../../../core/user_logged.dart';
import '../../domain/usecases/update_userprofile.dart';
import '../bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/settings_bloc_events.dart';

class UserImageProfile extends StatefulWidget {

  final File imageProfileToUpdate;
  final UserLoggedInfo userLoggedInfo;
  
  const UserImageProfile({Key? key, required this.imageProfileToUpdate, required this.userLoggedInfo}) : super(key: key);

  @override
  State<UserImageProfile> createState() => _MyWidgetState();

}

class _MyWidgetState extends State<UserImageProfile> {

  final updateUserBloc = UpdateUserBloc(updateUser: GetIt.instance.get<IUpdateUserImage>(), updateUserName: GetIt.instance.get<IUpdateUserName>()); 
  

  @override
  void dispose() {
    updateUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: FileImage(widget.imageProfileToUpdate),
            maxRadius: 50,
            minRadius: 20,
          ),
          StreamBuilder(
            stream: updateUserBloc.stream,
            builder: (context, snapshot) {

            final bloc = updateUserBloc.state;

            if (bloc is Loading) {

              return CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1));

            } 
            if (bloc is SuccessUpdaUser) {
              
              return Text(bloc.mensage);

            }
            if (bloc is FailureUser) {
              final mensage = (bloc.failure as FailureUpdateUser);
              return Column(
                children: [
                  Text(mensage.mensage),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple[400])
                    ),
                    onPressed: (){
                      updateUserBloc.add(UpdateImageProfile(newImage: widget.imageProfileToUpdate, currentUser: widget.userLoggedInfo.userUid!));
                    }, 
                    child: Text("Atualizar")
                  )
                ],
              );
            }
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple[400])
              ),
              onPressed: (){
                updateUserBloc.add(UpdateImageProfile(newImage: widget.imageProfileToUpdate, currentUser: widget.userLoggedInfo.userUid!));
              }, 
              child: Text("Atualizar")
            );
          }) 
        ],
      ),
    );
  }
}