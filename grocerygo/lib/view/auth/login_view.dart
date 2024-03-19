import 'package:grocerygo/common/custom_backgound.dart';
import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/common/custom_textfield.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/controllers/login_view_model.dart';
import 'package:grocerygo/view/auth/signup_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Get.put(LoginViewModel());

    return CustomBackground(
        image: imgLogin,
        appBar: true,
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                icLogoColor,
                width: 50,
              ),
            ),
            50.heightBox,
            login.text
                .size(24)
                .color(Colors.black)
                .fontFamily(gilroyBold)
                .make(),
            10.heightBox,
            Text(
              enterYourEmailAndPassword,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: gilroyMedium,
                  fontSize: 16),
            ),
            30.heightBox,
            CustomTextfield(
                title: email,
                titleColor: textTitle,
                textHint: emailHint,
                textHintColor: placeHolder,
                controller: authVM.txtEmail.value),
            30.heightBox,
            Obx(
              () => CustomTextfield(
                  title: password,
                  titleColor: textTitle,
                  textHint: passwordHint,
                  textHintColor: placeHolder,
                  obscureText: !authVM.isShowPasswordLogin.value,
                  rightIcon: IconButton(
                      onPressed: () {
                        authVM.showPassword();
                      },
                      icon: Icon(
                        !authVM.isShowPasswordLogin.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: textTitle,
                      )),
                  controller: authVM.txtPassword.value),
            ),
            5.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: forgotPassword.text
                      .size(16)
                      .color(textTitle)
                      .fontFamily(gilroyBold)
                      .make()),
            ),
            30.heightBox,
            CustomButton(
                width: context.screenWidth,
                height: context.screenHeight * 0.07,
                color: primary,
                title: login,
                textColor: Colors.white,
                size: 20,
                radius: 15,
                onPress: () {
                  authVM.serviceCallLogin();
                }),
            5.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                donNotHaveAnAccountYet.text
                    .size(16)
                    .color(textTitle)
                    .fontFamily(gilroyBold)
                    .make(),
                TextButton(
                    onPressed: () {
                      Get.to(() => const SignupView());
                    },
                    child: signup.text
                        .size(16)
                        .fontFamily(gilroyBold)
                        .color(primary)
                        .make())
              ],
            )
          ]),
        )));
  }
}
