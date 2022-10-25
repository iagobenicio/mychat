abstract class ISerachErro{}

class InvalidData implements ISerachErro{

  String mensage;

  InvalidData({required this.mensage});
  
}

class FailureSearch implements ISerachErro{

  String mensage;

  FailureSearch({required this.mensage});

}