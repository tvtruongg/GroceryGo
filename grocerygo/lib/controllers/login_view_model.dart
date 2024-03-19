import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';

class LoginViewModel extends GetxController {
  final txtEmail = TextEditingController().obs;
  final txtPassword = TextEditingController().obs;
  final isShowPasswordLogin = false.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    txtEmail.value.text = "tranvantruong2002@gmail.com";
    txtPassword.value.text = "truong2002";
  }

  void serviceCallLogin() {
    // Kiểm tra địng dạng email
    if (!GetUtils.isEmail(txtEmail.value.text)) {
      Get.snackbar(appname, pleaserEnterValidAEmailAddress);
      return;
    }

    if (txtPassword.value.text.length < 6) {
      Get.snackbar(appname, pleaserEnterValidPasswordMin6Character);
      return;
    }

    // Hiển thị chỉ báo tải
    Globs.showHUD();

    // Gửi yêu cầu post vs các tham số, đường dẫn, thành công, thất bại
    ServiceCall.post({
      "u_email": txtEmail.value.text,
      "u_password": txtPassword.value.text
    }, SVKey.svLogin, withSuccess: (resObj) async {
      // Tắt loading đi
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        var payload = resObj[KKey.payload] as Map? ?? {};

        Globs.udSet(payload, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);

        Get.delete<LoginViewModel>();
        Get.find<SplashViewModel>().goAfterLoginMainTab();
      } else {}

      Get.snackbar(appname, resObj["message"].toString());
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  void showPassword() {
    isShowPasswordLogin.value = !isShowPasswordLogin.value;
  }
}
