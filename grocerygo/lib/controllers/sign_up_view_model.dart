import 'package:flutter/foundation.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';

class SignUpViewModel extends GetxController {
  final txtUsername = TextEditingController().obs;
  final txtEmail = TextEditingController().obs;
  final txtPassword = TextEditingController().obs;
  final txtRetypePassword = TextEditingController().obs;
  final isShowPassword = false.obs;
  final isShowRetypePassword = false.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      print("SignUpViewModel Init ");
    }
    txtUsername.value.text = "User1";
    txtEmail.value.text = "user1@gmail.com";
    txtPassword.value.text = "123456";
    txtRetypePassword.value.text = "12345";
  }

  //ServiceCall
  void serviceCallSignUp() {
    if (txtUsername.value.text.isEmpty) {
      Get.snackbar(appname, "Pleaser enter username");
      return;
    }

    if (!GetUtils.isEmail(txtEmail.value.text)) {
      Get.snackbar(appname, "Pleaser enter valid email address");
      return;
    }

    if (txtPassword.value.text.length < 6) {
      Get.snackbar(appname, "Vui lòng nhập mật khẩu ít nhất 6 kí tự");
      return;
    }

    if (txtRetypePassword.value.text != txtPassword.value.text) {
      Get.snackbar(appname, "Mật khẩu nhập lại không khớp");
      return;
    }

    Globs.showHUD();

    ServiceCall.post({
      "username": txtUsername.value.text,
      "email": txtEmail.value.text,
      "password": txtRetypePassword.value.text
    }, SVKey.svSignUp, withSuccess: (resObj) async {
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        var payload = resObj[KKey.payload] as Map? ?? {};

        Globs.udSet(payload, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);

        Get.delete<SignUpViewModel>();
        Get.find<SplashViewModel>().goAfterLoginMainTab();
      } else {}

      Get.snackbar(appname, resObj["message"].toString());
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  void showPassword(int key) {
    if (key == 1) {
      isShowPassword.value = !isShowPassword.value;
    } else if (key == 2) {
      isShowRetypePassword.value = !isShowRetypePassword.value;
    }
  }
}
