# MYCHAT

![Frame 3](https://user-images.githubusercontent.com/52904825/207495696-0215ae47-63b6-4b2d-8b40-f165ee8f5d9e.png)

Mychat é um aplicativo de chat desenvolvido através da da tecnologia Flutter. 

O objetivo deste aplicativo foi para por em pratica meus estudos sobre firebase, arquitetura [Clean Dart](https://github.com/Flutterando/Clean-Dart), captura de imagem selecionada pelo usuário. Além disso, coloquei em prática teste unitários e utilizei como gerenciamento de estado o padrão bloc. 

No Mychat contém as seguintes funcionalidades: 

  - Autenticação e Cadastro de usuários
  - Pesquisar por usuários através do nome dele
  - Listar conversas já criadas com usuários 
  - Enviar mensagens em uma tela de bate-pao
  - Alterar foto de perfil e nome de usuário
  - Sistema de logout

# Mais Informações

Neste projeto eu comecei desenvolvendo primeiro os testes unitários e em seguida a criação das telas com as funcionalidades. 

O recebimento e envio de mensagens ocorrem através de Streams, fazendo assim a reatividade da aplicação. 

---------------------------------------------

Para clonar este projeto, siga estes passos:

Antes de tudo, certifique-se de estar com o ambiente preparado - Flutter e Dart

1 - Copie a url para clonar - https://github.com/iagobenicio/mychat.git

2 - Em uma pasta, clone o proje através do comando: git clone https://github.com/iagobenicio/mychat.git, utilizando o git.

3 - Abra o projeto e baixe todas as dependências através do comando: flutter pub get

4 - Execute o projeto em um dispositivo.

OBS: Aplicativo testado apenas em dispositivo android.

---------------------------------------------

pacotes utilizados:

https://pub.dev/packages/firebase_core

https://pub.dev/packages/cloud_firestore

https://pub.dev/packages/firebase_auth

https://pub.dev/packages/firebase_storage

https://pub.dev/packages/image_picker

https://pub.dev/packages/bloc

https://pub.dev/packages/flutter_bloc

https://pub.dev/packages/get_it

https://pub.dev/packages/dartz

https://pub.dev/packages/email_validator

https://pub.dev/packages/intl

https://pub.dev/packages/google_fonts

pacotes utilizados para testes:

https://pub.dev/packages/fake_cloud_firestore

https://pub.dev/packages/firebase_auth_mocks

https://pub.dev/packages/mocktail






