import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/user_logged.dart';
import '../../mensages/presenter/mensages_page.dart';
import '../domain/erros/getchats_erros.dart';
import '../domain/usecases/get_chats.dart';
import 'chat_bloc.dart';
import 'chat_events.dart';
import 'chat_states.dart';

class Chat extends StatefulWidget {


  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  
  final bloc = ChatBloc(getChatsUsecase: GetIt.instance.get<IGetChatsUseCase>());
  
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = (ModalRoute.of(context)!.settings.arguments as UserLoggedInfo);
    bloc.add(GetAllChatsAndListnen(uidUser: user.userUid!));
    
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color.fromRGBO(254, 247, 255, 1)),
        child: StreamBuilder(
          stream: bloc.stream,
          builder: ((context, snapshot) {
            final state = bloc.state;

            if (state is EmitChats) {
              final listChat = state.chats;
              if (state.chats.isEmpty) {
                return Center(child: Text("Você não tem nenhuma conversa"),);
              }
              return ListView.builder(
                itemCount: listChat.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ChatPage(user:user,chatInfo: listChat[index])
                        )
                      );
                    },
                    child: ListTile(
                      title: Text(
                        listChat[index].contactName,
                        style: GoogleFonts.inter()
                      ),
                      subtitle: Text(listChat[index].lastMensage ?? ""),
                      leading: CircleAvatar(
                        backgroundImage: listChat[index].contactPictureUrl == null ? null : NetworkImage(listChat[index].contactPictureUrl!),
                        child: listChat[index].contactPictureUrl == null ? Icon(Icons.person) : null
                      ),
                    ),
                  );
                })
              );
            }

            if (state is ChatErros) {
              final error = (state.erro as FailureGetChats);
              return Center(
                child: Text(error.mensage),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(167, 124, 228, 1),
              ),
            );
          })
        ),
      ),
    );
  }
}