import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hemant_projects/constant/imagePaths.dart';
import '../../componants/textfields.dart';
import '../../componants/validations.dart';
import 'controller/authController.dart';
import 'otpVerifyScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Color primaryOrange = const Color(0xFFE65100);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                // Fixed: Top Side Primary Color Box with Logo
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: primaryOrange,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                authController.clearErrors();
                                Navigator.pop(context);
                              } ,
                            ),
                          ),
                          Padding(
                            padding:  const EdgeInsets.only(left: 30,right: 30),
                            child: Image.asset(
                              ImagePath.homeServeLogo1,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.home_repair_service, size: 100, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Fixed: Sign Up Title
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

                // Scrollable: Form Fields
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Field
                        const Text(
                          'Full Name',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: authController.nameCtrl,
                          hintText: 'Enter your name',
                          prefixIcon: Icons.person_outline,
                          cursorColor: primaryOrange,
                          focusBorderColor: primaryOrange,
                          onChanged: (value) {
                            authController.name.value = Validations.validateName(value) ?? "";
                            authController.update();
                          },
                        ),
                        if (authController.name.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(authController.name.value,
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ),
                        const SizedBox(height: 20),

                        // Mobile Number Field
                        const Text(
                          'Mobile Number',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: authController.phoneCtrl,
                          hintText: 'Enter mobile number',
                          prefixIcon: Icons.phone_android_outlined,
                          keyboardType: TextInputType.phone,
                          cursorColor: primaryOrange,
                          focusBorderColor: primaryOrange,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          onChanged: (value) {
                            authController.phone.value = Validations.validateMobile(value);
                            authController.update();
                          },
                        ),
                        if (authController.phone.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(authController.phone.value,
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ),
                        const SizedBox(height: 20),

                        // Password Field
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: authController.passwordCtrl,
                          hintText: 'Enter password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          cursorColor: primaryOrange,
                          focusBorderColor: primaryOrange,
                          onChanged: (value) {
                            authController.password.value = Validations.validatePassword(value) ?? "";
                            authController.update();
                          },
                        ),
                        if (authController.password.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(authController.password.value,
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ),
                        const SizedBox(height: 20),

                        // Confirm Password Field
                        const Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: authController.confirmPasswordCtrl,
                          hintText: 'Re-enter password',
                          prefixIcon: Icons.lock_reset_outlined,
                          obscureText: true,
                          cursorColor: primaryOrange,
                          focusBorderColor: primaryOrange,
                          onChanged: (value) {
                            authController.confirmPassword.value = Validations.validateConfirmPassword(
                                    authController.passwordCtrl.text, value) ??
                                "";
                            authController.update();
                          },
                        ),
                        if (authController.confirmPassword.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(authController.confirmPassword.value,
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ),
                        const SizedBox(height: 40),

                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform all validations
                              authController.name.value = Validations.validateName(authController.nameCtrl.text) ?? "";
                              authController.phone.value = Validations.validateMobile(authController.phoneCtrl.text);
                              authController.password.value =
                                  Validations.validatePassword(authController.passwordCtrl.text) ?? "";
                              authController.confirmPassword.value = Validations.validateConfirmPassword(
                                      authController.passwordCtrl.text, authController.confirmPasswordCtrl.text) ??
                                  "";
                              authController.update();

                              // If all validations pass (empty error strings)
                              if (authController.name.value.isEmpty &&
                                  authController.phone.value.isEmpty &&
                                  authController.password.value.isEmpty &&
                                  authController.confirmPassword.value.isEmpty) {
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Already have an account? Login
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(color: Colors.black54, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color: primaryOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
