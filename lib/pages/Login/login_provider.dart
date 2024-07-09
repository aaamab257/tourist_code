import 'package:flutter/foundation.dart';
import 'package:tourease/data/models/login_model.dart';
import 'package:tourease/data/models/register_model.dart';
import 'package:tourease/repo/app_repo.dart';

class LoginProvider with ChangeNotifier {
  final AppRepo appRepo;
  LoginProvider({required this.appRepo});

  LoginModel? loginData;
  LoginModel? get loginModel => loginData;

  RegisterModel? registerData;
  RegisterModel? get registerModel => registerData;

  Future<void> login(String username, String password) async {
    
    // notifyListeners();
    // final response = await appRepo.loginRepo(username, password);
    // loginData = response;

    // notifyListeners();
  }

  Future<RegisterModel> register(
      String username, String password, String email) async {
    notifyListeners();
    final response = await appRepo.registerRepo(username, password, email);
    registerData = response;
    notifyListeners();
    return response;
  }
}
