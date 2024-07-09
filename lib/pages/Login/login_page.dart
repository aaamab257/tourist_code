import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourease/pages/Dashboard/home.dart';
import 'package:tourease/pages/Dashboard/landmarks_model.dart';

import 'package:tourease/pages/Login/login_controller.dart';

import 'package:tourease/pages/signup/signup.dart';
import 'package:tourease/theme/app_theme.dart';
import 'package:tourease/util/_string.dart';
import 'package:tourease/util/constants.dart';
import 'package:tourease/util/resources.dart';
import 'package:tourease/widgets/Custom_Textfield.dart';
import 'package:tourease/widgets/Custombutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tourease/widgets/app_logo.dart';
import 'package:tourease/widgets/custom_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  List<LandmarksModel> landmarks = [];

  @override
  initState() {
    super.initState();
    getLandMarks();
  }

  void login(String userName, String password) async {
    try {
      const url = 'http://10.0.2.2:8000/api/auth/login/';
      final uri = Uri.parse(url);
      final response = await http.post(uri, body: {
        "username": userName,
        "password": password,
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body.toString());
        print(json['token']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(
                  landmarks: landmarks,
                )));
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<LandmarksModel>> getLandMarks() async {
    try {
      const url = 'http://10.0.2.2:8000/api/landmarks';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print("Done its 200 ");
        final json = jsonDecode(response.body) as List;
        final list = json.map((e) {
          return LandmarksModel(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              location: e['location']);
        }).toList();
        landmarks = list;
        print("Data========= > ${landmarks[2].id} ");
        return list;
      } else {
        print("failed");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  double? height;
  double? width;
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: loginController,
        builder: (cont) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: AppTheme.loginPageColor,
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppLogo(),
                      CustomTextFeild(
                          controller: _usernameCon,
                          hintText: Strings.enterUserName,
                          prefixIcon: const Icon(
                            Icons.person_4_outlined,
                            color: AppTheme.textFieldIconColor,
                          )),
                      CustomTextFeild(
                          controller: _passwordCon,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: AppTheme.textFieldIconColor,
                          ),
                          hintText: Strings.password,
                          isObscureText: loginController.isVisible,
                          suffixIcon: InkWell(
                            onTap: () {
                              loginController.isVisible =
                                  !loginController.isVisible;
                              loginController.update();
                            },
                            child: Icon(
                              loginController.isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black45,
                            ),
                          )),
                      // InkWell(
                      //   onTap: () {
                      //     Get.toNamed(AppRoute.FORGOT_PASSWORD);
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(
                      //             right: Constant.forgotPasswordRightPadding,
                      //             top: Constant.forgotPasswordTopPadding),
                      //         child: CustomText(
                      //           title: Strings.forgotPassword,
                      //           fontfamily: Strings.emptyString,
                      //           fontWight: FontWeight.bold,
                      //           color: AppTheme.colorblack45,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      CustomButton(
                          backgroundColor: AppTheme.customButtonBgColor,
                          borderColor: AppTheme.customButtonBgColor,
                          buttonTitle: Strings.login,
                          height: Constant.customButtonHeight,
                          onTap: () {
                            login(_usernameCon.text.trim(),
                                _passwordCon.text.trim());
                            // Provider.of<LoginProvider>(context, listen: false)
                            //     .login(_usernameCon.text.trim(),
                            //         _passwordCon.text.trim())
                            //     .then((value) {
                            //   Get.toNamed(AppRoute.HOME);
                            // });
                          },
                          textColor: AppTheme.colorWhite),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Constant.loginButtonTopPadding,
                            right: Constant.loginButtonRightPadding,
                            left: Constant.loginButtonLeftPadding,
                            bottom: Constant.loginButtonBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            devider(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Constant.continueWithTextPadding,
                                  right: Constant.continueWithTextPadding),
                              child: CustomText(
                                title: Strings.orContinueWith,
                                fontSize: Constant.size12,
                                fontfamily: Strings.emptyString,
                                color: AppTheme.colorblack38,
                                fontWight: FontWeight.bold,
                              ),
                            ),
                            devider(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cardButton(google),
                          cardButton(twitter),
                          cardButton(facebook)
                        ],
                      ),
                      InkWell(
                        highlightColor: AppTheme.colorTransprant,
                        splashColor: AppTheme.colorTransprant,
                        onTap: () {
                          Get.to(const SignUp());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Constant.notMamberTopPadding),
                              child: CustomText(
                                title: Strings.notAMember,
                                fontfamily: Strings.emptyString,
                                fontWight: FontWeight.bold,
                                color: AppTheme.colorblack38,
                                fontSize: Constant.notMamberTextSize,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Constant.notMamberTopPadding),
                              child: CustomText(
                                title: Strings.registerNow,
                                fontfamily: Strings.emptyString,
                                fontWight: FontWeight.bold,
                                color: AppTheme.themeColor,
                                fontSize: Constant.notMamberTextSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget devider() {
    return Container(
      height: Constant.dividerSize,
      width: width! / Constant.size5,
      color: AppTheme.colorblack12,
    );
  }

  Widget cardButton(image) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Constant.cardButtonTopPadding,
          left: Constant.cardButtonLeftPadding,
          right: Constant.cardButtonRightPadding),
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.colorWhite,
            borderRadius: BorderRadius.circular(Constant.cardButtonRadius),
            boxShadow: [
              Constant.boxShadow(color: AppTheme.colorblack, blurradius: 8),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(Constant.cardButtonPadding),
          child: Container(
            height: Constant.cardButtonHeight,
            width: Constant.cardButtonWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
