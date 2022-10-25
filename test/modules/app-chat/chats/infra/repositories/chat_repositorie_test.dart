import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:mychat/modules/app-chat/chats/domain/erros/getchats_erros.dart';
import 'package:mychat/modules/app-chat/chats/infra/datasource/chats_datasource.dart';
import 'package:mychat/modules/app-chat/chats/infra/models/user_chat_model.dart';
import 'package:mychat/modules/app-chat/chats/infra/repositories/chat_repositorie.dart';


class DsMock extends Mock implements IChatsDataSource {}


void main() {

  final ds = DsMock();
  final repository = ChatRepositorieIMPL(dataSource: ds);

  test("deve retorna um lista de contatos (userchatmodel)", (){

    when((() => ds.getAllChats("some"))).thenAnswer((_) => Stream.value([{"name":"c1","contactImage":"some"},{"name":"c2","contactImage":"some"}]));
    final st = repository.getChatsRepositorie("some");
    expect(st.map((event) => event.fold(id, id)), emits(isA<List<UserChatModel>>()));

  });  


  test("deve retorna um erro", (){

    when((() => ds.getAllChats("some"))).thenThrow((_) => Stream.error(Exception()));
    final st = repository.getChatsRepositorie("some");
    expect(st.map((event) => event.fold(id, id)), emits(isA<FailureGetChats>()));

  }); 
}