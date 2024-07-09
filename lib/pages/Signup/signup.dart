import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tourease/routes/app_routes.dart';
import 'package:tourease/theme/app_theme.dart';
import 'package:tourease/util/_string.dart';
import 'package:tourease/util/constants.dart';
import 'package:tourease/widgets/Custombutton.dart';
import 'package:tourease/widgets/_appbar.dart';
import 'package:tourease/widgets/custom_text.dart';
import 'package:tourease/widgets/no_appbar.dart';
import '../../widgets/Custom_Textfield.dart';
import 'signup_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();

  void register(String userName, String password, String email) async {
    try {
      const url = 'http://10.0.2.2:8000/api/auth/register/';
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: {"username": userName, "password": password, "email": email});

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body.toString());
        print("Data ============ >  ${json['data']["email"]}");
        Get.toNamed(AppRoute.HOME);
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final singupController = Get.put(SignupController());
  double height = Constant.zero;
  double width = Constant.zero;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: singupController,
        builder: (con) {
          return Scaffold(
            appBar: NoAppBar(),
            backgroundColor: AppTheme.signupBodyColor,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(top: Constant.signupBodyTopPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(
                          title: Strings.createAccount,
                          space: Constant.SIZE50,
                          onTap: () {
                            Get.back();
                          },
                          leftPadding: Constant.signUpeAppbarLeftPadding,
                          rightPadding: Constant.signUpeAppbarRightPadding,
                          bottomPadding: Constant.signUpeAppbarBottomPadding),
                      CustomTextFeild(
                        controller: _usernameCon,
                        hintText: Strings.username,
                        prefixIcon: const Icon(
                          Icons.person_4_outlined,
                          color: AppTheme.colorblack38,
                        ),
                      ),
                      CustomTextFeild(
                        controller: _emailCon,
                        hintText: Strings.email,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppTheme.colorblack38,
                        ),
                      ),
                      CustomTextFeild(
                        controller: _passwordCon,
                        hintText: Strings.password,
                        prefixIcon: const Icon(
                          Icons.password,
                          color: AppTheme.colorblack38,
                        ),
                        isObscureText: singupController.passwordObsecured,
                        suffixIcon: InkWell(
                            onTap: () {
                              singupController.passwordObsecured =
                                  !singupController.passwordObsecured;
                              singupController.update();
                            },
                            child: Icon(
                              singupController.passwordObsecured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black38,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Constant.termsTextLeftPadding,
                            right: Constant.termsTextRightPadding,
                            top: Constant.termsTextTopPadding,
                            bottom: Constant.termsTextBottomPadding),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: Strings.byContinuingYouAgree,
                              style: const TextStyle(
                                  color: AppTheme.colorblack38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constant.termsTextSize,
                                  height: Constant.termsTextHeight),
                              children: [
                                TextSpan(
                                    text: Strings.termsOfService,
                                    style: TextStyle(
                                      color: AppTheme.themeColor,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: Strings.and,
                                          style: const TextStyle(
                                            color: AppTheme.colorblack38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: Strings.privacyPolicy,
                                                style: TextStyle(
                                                  color: AppTheme.themeColor,
                                                ))
                                          ])
                                    ])
                              ]),
                        ),
                      ),
                      CustomButton(
                        backgroundColor: AppTheme.themeColor,
                        borderColor: AppTheme.themeColor,
                        buttonTitle: Strings.signUp,
                        height: Constant.customButtonHeight,
                        textColor: AppTheme.colorWhite,
                        onTap: () {
                          register(_usernameCon.text.trim(),
                                  _passwordCon.text.trim(),
                                  _emailCon.text.trim());
                          // Provider.of<LoginProvider>(context, listen: false)
                          //     .register(
                          //         _usernameCon.text.trim(),
                          //         _passwordCon.text.trim(),
                          //         _emailCon.text.trim())
                          //     .then((value) {
                          //   print(
                          //       'Register Data ============= ? ====> ${value.message}');
                          //   Get.toNamed(AppRoute.HOME);
                          // });
                        },
                      ),
                      InkWell(
                        highlightColor: AppTheme.colorTransprant,
                        splashColor: AppTheme.colorTransprant,
                        onTap: () {
                          Get.toNamed(AppRoute.LOGIN);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Constant.alreadyMamberTextPadding),
                              child: CustomText(
                                title: Strings.alreadyAccount,
                                fontfamily: Strings.emptyString,
                                fontWight: FontWeight.bold,
                                color: AppTheme.colorblack38,
                                fontSize: Constant.alreadyMamberTextSize,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Constant.alreadyMamberTextPadding),
                              child: CustomText(
                                title: Strings.loginNew,
                                fontfamily: Strings.emptyString,
                                fontSize: Constant.alreadyMamberTextSize,
                                fontWight: FontWeight.bold,
                                color: AppTheme.themeColor,
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
}
