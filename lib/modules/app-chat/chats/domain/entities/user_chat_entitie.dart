class UserChatEntitie{
  
  String? contactUid;
  String chatUid;
  String contactName;
  String? contactPictureUrl;
  String? lastMensage;
  bool isNewChat;

  UserChatEntitie({this.contactUid, this.lastMensage, required this.contactName,  required this.contactPictureUrl, required this.chatUid, this.isNewChat = false});

}