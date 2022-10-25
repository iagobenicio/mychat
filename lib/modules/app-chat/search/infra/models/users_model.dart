import 'package:mychat/modules/app-chat/search/domain/entities/users_entitie.dart';

class UserModel extends UserEntitie{

  UserModel({required final userUid, required final userName, required final userPictureUrl}) : 
  super(userUid: userUid, userName: userName, userPictureUrl: userPictureUrl);

  factory UserModel.fromMap(Map<String,dynamic> user){

    return UserModel(
      userUid: user["uid"], 
      userName: user["name"], 
      userPictureUrl: user["image_profile"]
    );

  }

}