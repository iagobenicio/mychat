class UserLoggedInfo{

  String? userUid;
  String? userEmail;

  UserLoggedInfo();
  
  void setUid(String? uid){
    userUid = uid;
  }

  String? get useruid => userUid;

  void setEmail(String? email){
    userEmail = email;
  }

  String? get useremail => userEmail;

}