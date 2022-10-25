import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mychat/modules/app-chat/chats/domain/entities/user_chat_entitie.dart';
import 'package:mychat/modules/app-chat/chats/domain/erros/getchats_erros.dart';
import 'package:mychat/modules/app-chat/chats/domain/usecases/get_chats.dart';
import 'package:mychat/modules/app-chat/chats/presenter/chat_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mychat/modules/app-chat/chats/presenter/chat_events.dart';
import 'package:mychat/modules/app-chat/chats/presenter/chat_states.dart';


class MockUseCase extends Mock implements IGetChatsUseCase{}


void main() {

  final mockUseCase = MockUseCase();
  final bloc = ChatBloc(getChatsUsecase: mockUseCase);

  test("deve emitir em ordem com uma lista de userchats", (){

    when(()=>mockUseCase.getChats("myuid")).thenAnswer((_) => Stream.value(Right([UserChatEntitie(chatUid: "uidchat", contactName: "contato",contactPictureUrl: "some_image")])));

    expect(bloc.stream, emitsInOrder([
      isA<LoadingChats>(),
      isA<EmitChats>()
    ]));

    bloc.add(GetAllChatsAndListnen(uidUser: "myuid"));


  });

  test("deve emitir em ordem com um erro", (){

    when(()=>mockUseCase.getChats("myuid")).thenAnswer((_) => Stream.value(Left(FailureGetChats(mensage: "Some erro"))));

    expect(bloc.stream, emitsInOrder([
      isA<LoadingChats>(),
      isA<ChatErros>()
    ]));

    bloc.add(GetAllChatsAndListnen(uidUser: "myuid"));


  });



}