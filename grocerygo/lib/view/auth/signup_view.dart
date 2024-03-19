import 'package:flutter/gestures.dart';
import 'package:grocerygo/common/custom_backgound.dart';
import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/common/custom_dialog.dart';
import 'package:grocerygo/common/custom_textfield.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/utility/lists.dart';
import 'package:grocerygo/controllers/sign_up_view_model.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final signupVM = Get.put(SignUpViewModel());

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
            30.heightBox,
            signup.text
                .size(24)
                .color(Colors.black)
                .fontFamily(gilroyBold)
                .make(),
            10.heightBox,
            Text(
              enterYourCredentialToContinue,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: gilroyMedium,
                  fontSize: 16),
            ),
            30.heightBox,
            CustomTextfield(
                title: usename,
                titleColor: textTitle,
                textHint: usenameHint,
                textHintColor: placeHolder,
                controller: signupVM.txtUsername.value),
            30.heightBox,
            CustomTextfield(
                title: email,
                titleColor: textTitle,
                textHint: emailHint,
                textHintColor: placeHolder,
                rightIcon: Image.asset(
                  icAccurate,
                  width: 20,
                ),
                controller: signupVM.txtEmail.value),
            30.heightBox,
            Obx(
              () => CustomTextfield(
                  title: password,
                  titleColor: textTitle,
                  textHint: passwordHint,
                  textHintColor: placeHolder,
                  obscureText: !signupVM.isShowPassword.value,
                  rightIcon: IconButton(
                      onPressed: () {
                        signupVM.showPassword(1);
                      },
                      icon: Icon(
                        !signupVM.isShowPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: textTitle,
                      )),
                  controller: signupVM.txtPassword.value),
            ),
            30.heightBox,
            Obx(
              () => CustomTextfield(
                  title: retypePassword,
                  titleColor: textTitle,
                  textHint: passwordHint,
                  textHintColor: placeHolder,
                  obscureText: !signupVM.isShowRetypePassword.value,
                  rightIcon: IconButton(
                      onPressed: () {
                        signupVM.showPassword(2);
                      },
                      icon: Icon(
                        !signupVM.isShowRetypePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: textTitle,
                      )),
                  controller: signupVM.txtRetypePassword.value),
            ),
            20.heightBox,
            RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14,
                        color: textTitle,
                        fontFamily: gilroyMedium,
                        height: 1.2),
                    children: [
                  const TextSpan(text: byContinuingYouAgreeToOur),
                  TextSpan(
                    text: termsOfService,
                    style: const TextStyle(
                        fontSize: 14, color: primary, fontFamily: gilroyBold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const CustomDialog(
                                  title: "Điều khoản dịch vụ",
                                  text: termsOfServiceList,
                                ));
                      },
                  ),
                  const TextSpan(text: "và "),
                  TextSpan(
                    text: privacyPolicy,
                    style: const TextStyle(
                        fontSize: 14, color: primary, fontFamily: gilroyBold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const CustomDialog(
                                  title: "Chính sách quyền riêng tư",
                                  text: privacyPolicyList,
                                ));
                      },
                  ),
                  const TextSpan(text: "của chúng tôi.")
                ])),
            20.heightBox,
            CustomButton(
                width: context.screenWidth,
                height: context.screenHeight * 0.07,
                color: primary,
                title: signup,
                textColor: Colors.white,
                size: 20,
                radius: 15,
                onPress: () {
                  signupVM.serviceCallSignUp();
                }),
            15.heightBox,
            Align(
              alignment: Alignment.center,
              child: alreadyHaveAnAccount.text
                  .size(16)
                  .color(textTitle)
                  .fontFamily(gilroyBold)
                  .make(),
            ),
          ]),
        )));
  }
}
