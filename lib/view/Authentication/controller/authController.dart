import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

  class AuthController extends GetxController{
  var loadingCtrl=false.obs;
  var phone="".obs;
  var otp="".obs;
  var name="".obs;
  var password="".obs;
  var confirmPassword="".obs;
  TextEditingController phoneCtrl=TextEditingController();
  TextEditingController otpCtrl=TextEditingController();
  TextEditingController nameCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmPasswordCtrl=TextEditingController();

  clearErrors(){
    otp.value="";
    phone.value="";
    name.value="";
    password.value="";
    confirmPassword.value="";
    phoneCtrl.clear();
    otpCtrl.clear();
    nameCtrl.clear();
    passwordCtrl.clear();
    confirmPasswordCtrl.clear();
    update();
  }
}