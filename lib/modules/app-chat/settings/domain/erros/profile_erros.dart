abstract class FailurePorifle{}

class FailureGetUserProfile implements FailurePorifle{
  String mensage;

  FailureGetUserProfile({required this.mensage});
}

class FailureUpdateUser implements FailurePorifle{

   String mensage;

   FailureUpdateUser({required this.mensage});

}