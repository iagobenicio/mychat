import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mychat/core/user_logged.dart';
import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/components/bottom_component.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_events.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_state.dart';

import '../domain/usecases/delete_mensage.dart';
import '../domain/usecases/get_all_mensages.dart';
import '../domain/usecases/send_mensage.dart';
import 'components/mensage_container.dart';

class ChatPage extends StatefulWidget {

  final UserLoggedInfo user;
  final UserChatEntitie chatInfo;
  const ChatPage({Key? key,required this.chatInfo,required this.user}) : super(key: key);

  @override
  State<ChatPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChatPage> {


  final blocMensage = MensagesBloc(
    getMensagesUs: GetIt.instance.get<IGetAllMensages>(), 
    deleteMensageUs: GetIt.instance.get<IDeleteMensage>(), 
    sendMensageUs: GetIt.instance.get<ISendMensage>()
  );
  
  TextEditingController textMensageToSend = TextEditingController();
  

  @override
  void initState() {

    if (widget.chatInfo.isNewChat == false) {
      blocMensage.add(GetMensagesEvent(chatUid: widget.chatInfo.chatUid));
    }
    super.initState();
  }

  @override
  void dispose() {
    blocMensage.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final sendMensageEvent = SendMensageEvent(chatInfoToSendMensage: widget.chatInfo, currentUser: widget.user.userUid!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 248, 255, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
                  Navigator.pop(context);
                }),
                SizedBox(width:2),
                CircleAvatar(
                  backgroundImage: widget.chatInfo.contactPictureUrl == null ? null : NetworkImage(widget.chatInfo.contactPictureUrl!),
                  backgroundColor: Color.fromRGBO(135, 131, 140, 1),
                  maxRadius: 20,
                  child: widget.chatInfo.contactPictureUrl == null ? Icon(Icons.person, color: Colors.white) : null
                ),
                SizedBox(width: 12,),
                Text(
                  widget.chatInfo.contactName,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(75, 68, 83, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(249, 248, 255, 1),
        child: StreamBuilder<Object>(
          stream: blocMensage.stream,
          builder: (context, snapshot) {
            final mensage = blocMensage.state;
            
            if (mensage is ShowNewMensages) {
              return Stack(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 5,),
                    itemCount: mensage.newMensages.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context,index){
                      if (mensage.newMensages.isEmpty) {
                        return Center(
                          child: Text("Nenhuma mensagem"),
                        );
                      }
                      return Wrap(
                        children: [
                          Align(
                            alignment: mensage.newMensages[index].sendBy == widget.user.userUid ? Alignment.centerRight : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: mensage.newMensages[index].sendBy == widget.user.userUid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: mensage.newMensages[index].sendBy == widget.user.userUid 
                                  ?
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: () => blocMensage.add(DeleteMensageEvent(mensageUid: mensage.newMensages[index].mensageUid, chatUid: widget.chatInfo.chatUid)),
                                        child: Text("Deletar")
                                      )
                                    ],
                                    child: MensageContainer(
                                      mensage: mensage.newMensages[index].mensage,
                                      containerColor: Color.fromRGBO(109, 71, 186, 1) 
                                    ),
                                  )
                                  : MensageContainer(mensage: mensage.newMensages[index].mensage, containerColor: Color.fromRGBO(135, 131, 140, 1))
                                ),                      
                                Container(
                                  constraints: BoxConstraints(maxWidth: 150),
                                  alignment: mensage.newMensages[index].sendBy == widget.user.userUid ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Text(
                                    mensage.newMensages[index].timestamp,
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10
                                      )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]
                      );
                    }
                  ),
                  BottomWidget(
                    controller: textMensageToSend, 
                    onPressedFunction: (){
                      sendMensageEvent.setMensage(textMensageToSend.text);
                      blocMensage.add(sendMensageEvent);
                      textMensageToSend.clear();
                    }
                  )
                ],
              );
            }
            if (widget.chatInfo.isNewChat) {
              return BottomWidget(
                controller: textMensageToSend, 
                onPressedFunction: (){
                  sendMensageEvent.setMensage(textMensageToSend.text);
                  blocMensage.add(sendMensageEvent);
                  textMensageToSend.clear();
                }
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1)),
            );
          }
        ),
      ),
    );
  }
}