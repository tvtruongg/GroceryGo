import 'package:get/get.dart';
import 'package:grocerygo/model/user_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/view/home/home_main.dart';
import 'package:grocerygo/view/start/welcome_view.dart';

class SplashViewModel extends GetxController {
  final userModel = UserModel().obs;

  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));

    if (Globs.udValueBool(Globs.userLogin)) {
      userModel.value =
          UserModel.fromJson(Globs.udValue(Globs.userPayload));
      Get.to(() => const HomeMain());
    } else {
      Get.to(() => const WelcomeView());
    }
  }

  void goAfterLoginMainTab(){
    userModel.value = UserModel.fromJson(Globs.udValue(Globs.userPayload));
    Get.to(() => const HomeMain() );
  }

  void setData() {
    userModel.value =
        UserModel.fromJson(Globs.udValue(Globs.userPayload));
    
  }

  void logout() {
    userModel.value = UserModel();
    Globs.udBoolSet(false, Globs.userLogin);
    Get.to(() => const WelcomeView());
  }
}
