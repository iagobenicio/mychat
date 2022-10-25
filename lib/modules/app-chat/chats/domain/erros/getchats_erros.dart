abstract class IChatsErros{}

class FailureGetChats implements IChatsErros{

  String mensage;
  
  FailureGetChats({required this.mensage});
}

class FailureCreateChat implements IChatsErros{
  String mensage;

  FailureCreateChat({required this.mensage});

}
