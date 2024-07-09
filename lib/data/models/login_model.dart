// {
//     "token": "1dbc7084bcc5b184f18e5f41d9272fea4d5d57a7",
//     "user_id": 3,
//     "message": "User logged in successfully"
// }

class LoginModel{
  
  int? userId;
  String? token;
  String? message;

  LoginModel({this.userId, this.token, this.message});
}