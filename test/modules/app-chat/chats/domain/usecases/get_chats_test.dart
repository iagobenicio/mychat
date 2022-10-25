import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';
import 'package:mychat/modules/app-chat/chats/domain/repositories/chats_repositorie.dart';
import 'package:mychat/modules/app-chat/chats/domain/usecases/get_chats.dart';
import 'package:mychat/modules/app-chat/chats/domain/erros/getchats_erros.dart';


class RepositorieMock extends Mock implements IChatRepositorie{}

void main() { 

  final repoMock = RepositorieMock();
  final chatUs = GetChatsIMPL(repositorie: repoMock);

  test("deve retornar uma lista de UserChatEntitie ", (){

    when(()=>repoMock.getChatsRepositorie(any())).thenAnswer((_) => Stream.value(Right([UserChatEntitie(chatUid: "chatuid", contactName: "contato",contactPictureUrl: "someurl")])));

    chatUs.getChats("someuid").listen((event) {
      expect(event.fold(id, id),isA<List<UserChatEntitie>>());
    });
    
  });

  test("deve retornar um erro ", (){

    when(()=>repoMock.getChatsRepositorie(any())).thenAnswer((_) => Stream.value(Left(FailureGetChats(mensage: "some erro"))));

    chatUs.getChats("someuid").listen((event) {
      expect(event.fold(id, id),isA<FailureGetChats>());
    });
    
  });
  


}