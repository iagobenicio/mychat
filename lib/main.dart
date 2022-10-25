import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mychat/modules/app-chat/chats/domain/repositories/chats_repositorie.dart';
import 'package:mychat/modules/app-chat/chats/domain/usecases/get_chats.dart';
import 'package:mychat/modules/app-chat/chats/external/datasources/chat_datasource.dart';
import 'package:mychat/modules/app-chat/chats/infra/repositories/chat_repositorie.dart';
import 'package:mychat/modules/app-chat/mensages/domain/repository/mensages_repository.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/delete_mensage.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/get_all_mensages.dart';
import 'package:mychat/modules/app-chat/mensages/domain/usecases/send_mensage.dart';
import 'package:mychat/modules/app-chat/mensages/external/datasources/mensages_datasource.dart';
import 'package:mychat/modules/app-chat/mensages/infra/datasources/mensages_datasource.dart';
import 'package:mychat/modules/app-chat/mensages/infra/repositories/mensages_repository.dart';
import 'package:mychat/modules/auth/login/domain/usecases/login_usecase.dart';
import 'package:mychat/modules/auth/login/external/datasource/login_datasource.dart';
import 'package:mychat/modules/auth/login/infra/datasource/login_datasource.dart';
import 'package:mychat/modules/auth/login/presenter/ui/login_page.dart';
import 'package:mychat/modules/auth/registrer/domain/repositories/register_repository.dart';
import 'package:mychat/modules/auth/registrer/presenter/ui/register_page.dart';
import 'modules/app-chat/app_chat_widget.dart';
import 'modules/app-chat/chats/domain/usecases/get_chat_with_contact_uid.dart';
import 'modules/app-chat/chats/infra/datasource/chats_datasource.dart';
import 'modules/app-chat/search/domain/repositories/search_repostiorie.dart';
import 'modules/app-chat/search/domain/usecases/search_user.dart';
import 'modules/app-chat/search/external/datasource/search_datasource.dart';
import 'modules/app-chat/search/infra/datasource/serach_datasource.dart';
import 'modules/app-chat/search/infra/repositories/search_repositorie.dart';
import 'modules/app-chat/settings/domain/repositories/user_profile_repositorie.dart';
import 'modules/app-chat/settings/domain/usecases/get_userprofile.dart';
import 'modules/app-chat/settings/domain/usecases/update_userprofile.dart';
import 'modules/app-chat/settings/external/datasource/settings_datasource.dart';
import 'modules/app-chat/settings/infra/datasource/user_profile_datasource.dart';
import 'modules/app-chat/settings/infra/repositories/user_profile_repositorie_impl.dart';
import 'modules/auth/login/domain/repositories/login_repository.dart';
import 'modules/auth/login/infra/repositories/login_repositorie.dart';
import 'modules/auth/logout/external/logout.dart';
import 'modules/auth/registrer/domain/usecases/register_with_email_password_usecase.dart';
import 'modules/auth/registrer/external/datasource/register_datasource.dart';
import 'modules/auth/registrer/infra/datasource/register_datasource.dart';
import 'modules/auth/registrer/infra/repositories/register_repositorie.dart';
import 'firebase_options.dart';
import 'package:get_it/get_it.dart';

void main()async{

  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final getIt = GetIt.instance;

  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<IRegisterDataSource>(RegisterDataSourceIMPL(firebaseAuth: getIt.get<FirebaseAuth>(), firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<IRegisterRepository>(RegisterRepositorieIMPL(datasource: getIt.get<IRegisterDataSource>()));
  getIt.registerSingleton<IRegisterWithEmailAndPassword>(RegisterWithEmailAndPassword(repository: getIt.get<IRegisterRepository>()));

  getIt.registerSingleton<IDataSource>(DataSourceFirebase(authInstace: getIt.get<FirebaseAuth>()));
  getIt.registerSingleton<ILoginRepository>(LoginRepositoryIMPL(datasource: getIt.get<IDataSource>()));
  getIt.registerSingleton<ILoginUseCase>(LoginUseCase(repository: getIt.get<ILoginRepository>()));

  getIt.registerSingleton<IChatsDataSource>(ChatsDataSoruceIMPL(firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<IChatRepositorie>(ChatRepositorieIMPL(dataSource: getIt.get<IChatsDataSource>()));
  getIt.registerSingleton<IGetChatsUseCase>(GetChatsIMPL(repositorie: getIt.get<IChatRepositorie>()));
  getIt.registerSingleton<IGetChatWithContactUid>(GetChatWithContactUid(repositorie: getIt.get<IChatRepositorie>()));

  getIt.registerSingleton<IMensagesDataSource>(MensageDataSrocueIMPL(firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<IMensageRepository>(MensagesRepositoryIMPL(mensageDataSoruce: getIt.get<IMensagesDataSource>()));
  getIt.registerSingleton<IGetAllMensages>(GetAllMensagesIMPL(repository: getIt.get<IMensageRepository>()));
  getIt.registerSingleton<ISendMensage>(SendMensageIMPL(repository: getIt.get<IMensageRepository>()));
  getIt.registerSingleton<IDeleteMensage>(DeleteMensageIMPL(repository: getIt.get<IMensageRepository>()));

  getIt.registerSingleton<ISearchDataSource>(SearchDataSourceIMPL(firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<ISearchRepositorie>(SearchRepositorie(datasource: getIt.get<ISearchDataSource>()));
  getIt.registerSingleton<ISearchUser>(SearchUserUs(repositorie: getIt.get<ISearchRepositorie>()));

  getIt.registerSingleton<Ilogout>(LogoutIMPL(authInstace: getIt.get<FirebaseAuth>()));

  getIt.registerSingleton<IUserProfileDataSource>(SettingsDataSource(firebaseFirestore: FirebaseFirestore.instance, firebaseStorage: FirebaseStorage.instance));
  getIt.registerSingleton<IUserProfileRepositorie>(UserProfileRepositorieIMPL(userProfileDataSource: getIt.get<IUserProfileDataSource>()));
  getIt.registerSingleton<IGetUserProfile>(GetUserProfile(userProfileRepositorie: getIt.get<IUserProfileRepositorie>()));
  getIt.registerSingleton<IUpdateUserImage>(UpdateUserImageIMPL(userProfileRepositorie: getIt.get<IUserProfileRepositorie>()));
  getIt.registerSingleton<IUpdateUserName>(UpdateUserNameIMPL(userProfileRepositorie: getIt.get<IUserProfileRepositorie>()));
  

  runApp( MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/register-page": (context) => RegisterPage(),
        "/chats-page" : (context) => AppChatWidget(),
      },
    )
  );



}


