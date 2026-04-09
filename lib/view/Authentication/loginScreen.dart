import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hemant_projects/constant/imagePaths.dart';
import 'package:hemant_projects/view/Authentication/registerScreen.dart';

import '../../componants/textfields.dart';
import '../../componants/validations.dart';
import 'controller/authController.dart';
import 'otpVerifyScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController=Get.put(AuthController());


  bool rememberMe = false;
  final Color primaryOrange = const Color(0xFFE65100); // UI Theme Color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<AuthController>(
        builder: (authController) {
          return Scaffold(
            backgroundColor: Colors.white,
            body:  SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400), // Max form width
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(ImagePath.loginVector),
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: authController.phoneCtrl,
                        hintText: 'Enter Mobile',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        cursorColor: primaryOrange,
                        focusBorderColor: primaryOrange,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // only numbers
                          LengthLimitingTextInputFormatter(10),   // max 10 digits
                        ],
                        onChanged: (value){
                          authController.phone.value =
                              Validations.validateMobile(authController.phoneCtrl.text);                         setState(() {});
                          authController.update();
                         },
                      ),
                      authController.phone.value.isEmpty?
                          const SizedBox.shrink():
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                  authController.phone.value,
                                style: const TextStyle(
                                  fontSize: 12,fontWeight:FontWeight.w400,color: Colors.red
                                ),
                              ),
                            ),
                          ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                              activeColor: primaryOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: ()  {
                            var valuePhone=Validations.validateMobile(authController.phoneCtrl.text);
                            authController.phone.value=valuePhone.toString();
                            authController.update();

                            if(valuePhone.isEmpty){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OtpVerifyScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryOrange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: primaryOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          )
          );
        }
      ),
    );
  }


}
