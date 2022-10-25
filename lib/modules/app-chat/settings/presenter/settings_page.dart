import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mychat/modules/app-chat/settings/presenter/bloc/settings_bloc_events.dart';
import 'package:mychat/modules/app-chat/settings/presenter/ui/username_update.dart';
import '../../../../core/user_logged.dart';
import '../../../auth/logout/external/logout.dart';
import '../domain/erros/profile_erros.dart';
import '../domain/usecases/get_userprofile.dart';
import 'bloc/settings_bloc_state.dart';
import 'ui/userimage_update.dart';
import 'settings_controller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _MyWidgetState();
}


class _MyWidgetState extends State<Profile> {


  final settingsBloc = SettingsBloc(getUser: GetIt.instance.get<IGetUserProfile>(), logout: GetIt.instance.get<Ilogout>());

  final settingsController = SettingsController();
  

  @override
  void dispose() {
    settingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userInfo = (ModalRoute.of(context)!.settings.arguments as UserLoggedInfo);
    settingsBloc.add(GetUser(currentUser: userInfo.useruid!));

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: BlocConsumer<SettingsBloc,ProfileStates>(
                listener: (context, state){
                  if (state is LogoutState) {
                    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
                  }
                },
                buildWhen: (previous, current) => current is LogoutState ? false : true,
                bloc: settingsBloc,
                builder: (context, state) {
                  if (state is FailureUser) {
                    if (state.failure is FailureGetUserProfile) {
                      final mensageErro = (state.failure as FailureGetUserProfile);
                      return Center(
                        child: Text(mensageErro.mensage),
                      );
                    }
                    return Center(
                      child: Text("algum erro ocorreu"),
                    );
                  }
                  if (state is LoadedUserProfile) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: ()async{
                                    File? newImageProfile = await settingsController.getImage();
                                    if (newImageProfile != null) {
                                      showDialog(context: context, builder: (context) => UserImageProfile(imageProfileToUpdate: newImageProfile, userLoggedInfo: userInfo,));
                                    } 
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: state.user.imageProfile != null ? NetworkImage(state.user.imageProfile!) : null,
                                    maxRadius: 46,
                                    minRadius: 20,
                                    child: state.user.imageProfile == null ? Icon(Icons.person) : null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder: (context) => UserNameUpdate(userLoggedInfo: userInfo));
                                  },
                                  child: Text(
                                    state.user.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 1.70,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(75, 68, 83, 1)
                                    )
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        Expanded(
                          flex: 2,                 
                          child: SizedBox(
                            width: constraints.maxWidth - 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [ 
                                TextButton(
                                  onPressed: (){
                                    settingsBloc.add(LogoutEvent());
                                  }, 
                                  child: Text(
                                    "Sair",
                                    style: TextStyle(
                                      color: Color.fromRGBO(75, 68, 83, 1)
                                    ), 
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1),),
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }
}