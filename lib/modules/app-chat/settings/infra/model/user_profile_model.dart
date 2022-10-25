import 'package:mychat/modules/app-chat/settings/domain/entitie/user_profile.dart';

class UserProfileModel extends UserProfileEntitie{

  UserProfileModel(String name, String? imageProfile) : super(name: name, imageProfile: imageProfile);


  factory UserProfileModel.fromMap(Map<String,dynamic> user){
    return UserProfileModel(
      user["name"], 
      user["image_profile"]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "imageProfile":imageProfile
    };
  }
  
}
