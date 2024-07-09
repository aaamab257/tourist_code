import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourease/data/models/login_model.dart';
import 'package:tourease/data/models/register_model.dart';
import 'package:tourease/data/remote/dio/dio_client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppRepo {
  final DioClient dioClient;

  final SharedPreferences sharedPreferences;
  AppRepo({required this.dioClient, required this.sharedPreferences});

  Future<LoginModel> loginRepo(String userName, String password) async {
    // try {
    //   const url = 'http://10.0.2.2:8000/api/auth/login/';
    //   final uri = Uri.parse(url);
    //   final response = await http.post(uri, body: {
    //     "username": userName,
    //     "password": password,
    //   });

    //   if (response.statusCode == 200) {
    //     final json = jsonDecode(response.body.toString());
    //     return LoginModel(
    //         token: json['token'],
    //         userId: json['userId'],
    //         message: json['message']);
    //   }else{
    //     print("failed");
    //     return LoginModel(token: "", userId: 0, message: "");
    //   }
      
    // } catch (e) {
    //   print(e.toString());
    // }
    return LoginModel(token: "", userId: 0, message: "");
  }
  

  Future<RegisterModel> registerRepo(
      String userName, String password, String email) async {
    const url = 'http://10.0.2.2:8000/api/auth/register/';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: {"username": userName, "password": password, "email": email});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString());
      
      return RegisterModel(data: json['data'], message: json['message']);
    }
    return RegisterModel(data: null, message: "");
  }
}
