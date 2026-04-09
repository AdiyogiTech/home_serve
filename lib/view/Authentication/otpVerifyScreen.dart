import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../componants/validations.dart';
import '../home/dashboardScreen.dart';
import 'controller/authController.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  AuthController authController=Get.put(AuthController());


  final Color primaryOrange = const Color(0xFFE65100);

  @override
  Widget build(BuildContext context) {
    // Styling attributes for the pinput (OTP text field)
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryOrange),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
      ),
    );

    return GestureDetector(
      onTap: () {
        // Unfocus keyword board when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<AuthController>(
        builder: (authController) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  authController.clearErrors();
                  Navigator.pop(context);
                } ,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Enter the 6-digit code sent to your mobile number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // 6 Digit Pinput
                      Pinput(
                        length: 6,
                        controller: authController.otpCtrl,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        cursor: Container(
                          width: 2,
                          height: 24,
                          color: primaryOrange,
                        ),
                        onChanged: (value){
                          authController.otp.value = Validations.pinputOtp(authController.otpCtrl.text);                         setState(() {});
                          authController.update();
                        },
                        onCompleted: (pin) {
                          print("Entered OTP: \$pin");
                        },
                      ),

                      authController.otp.value.isEmpty?
                      const SizedBox.shrink():
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            authController.otp.value,
                            style: const TextStyle(
                                fontSize: 12,fontWeight:FontWeight.w400,color: Colors.red
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            var valueOtp=Validations.pinputOtp(authController.otpCtrl.text);
                            authController.otp.value=valueOtp.toString();
                            authController.update();

                            if(valueOtp.isEmpty){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
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
                            'Verify',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Resend Code text
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement resend logic
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Didn't receive the code? ",
                            style: const TextStyle(color: Colors.black54, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Resend',
                                style: TextStyle(
                                  color: primaryOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
