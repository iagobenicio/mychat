import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mychat/modules/app-chat/mensages/presenter/mensages_page.dart';
import 'package:mychat/modules/app-chat/search/domain/erros/search_erro.dart';
import '../../../../core/user_logged.dart';
import '../../chats/domain/usecases/get_chat_with_contact_uid.dart';
import '../domain/usecases/search_user.dart';
import 'search_bloc.dart';
import 'search_bloc_events.dart';
import 'search_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchUser> {



  final searchTextController = TextEditingController();
  final searchBloc = SearchBloc(
    searchUserUseCsae: GetIt.instance.get<ISearchUser>(),
    getChatWithContactUid: GetIt.instance.get<IGetChatWithContactUid>()
  );

  @override
  void dispose(){
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = (ModalRoute.of(context)!.settings.arguments as UserLoggedInfo);
   
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color.fromRGBO(254, 247, 255, 1)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: searchTextController,
                        cursorColor: Color.fromRGBO(75, 68, 83, 1),
                        decoration: InputDecoration( 
                          focusColor: Color.fromRGBO(75, 68, 83, 1),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(75, 68, 83, 1)),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(75, 68, 83, 1)),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          )
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: IconButton(
                        onPressed: (){
                          searchBloc.add(GetUsers(data: searchTextController.text));
                        }, 
                        icon: Icon(Icons.search)
                      ),
                    ),
                  )
                ],
              )
            ),
            BlocConsumer<SearchBloc,SearchStates>(
              bloc: searchBloc,
              listener: (context, state) {
                if (state is ChatWithContactOrNew) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(chatInfo: state.chatOrNew, user: user)));
                }
              },
              buildWhen: (previous, current){
                if (current is ChatWithContactOrNew) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is UsersState) {
                  if (state.users.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text("nenhum usuário encontrado"),
                      )
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.users.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () => searchBloc.add(GetChatOrNewChat(myUid: user.userUid!, contact: state.users[index])),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: state.users[index].userPictureUrl == null ? null : NetworkImage(state.users[index].userPictureUrl!),
                            child: state.users[index].userPictureUrl == null ? Icon(Icons.person) : null
                          ),
                          title: Text(state.users[index].userName),
                        ),
                      );
                    }
                  );
                }
                if (state is FailureSearchState) {
                  return Expanded(
                    child: Center(
                      child: state.erro is FailureSearch ? Text((state as FailureSearch).mensage) : Text((state as InvalidData).mensage),
                    ),
                  );
                }
                if (state is LoadingSearch) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: Color.fromRGBO(167, 124, 228, 1), backgroundColor: Color.fromRGBO(75, 68, 83, 1)),
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: Text("pesquise por um usuário"),
                  )
                );
              },  
            ),
          ],
    
        ),
    
      ),
    );

  }
}