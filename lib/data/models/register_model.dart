class RegisterModel {
//   {
//     "message": "User registered successfully",
//     "data": {
//         "id": 5,
//         "username": "ahmed2",
//         "email": "ahmed@badr.com"
//     }
// }

  int? userId;
  String? message;
  Data? data;

  RegisterModel({this.data, this.message});
}

class Data {
  String? username;
  String? email;
  int? id;
  Data({this.username, this.email, this.id});
}
