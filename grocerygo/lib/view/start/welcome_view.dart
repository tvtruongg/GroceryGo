import 'package:flutter/services.dart';
import 'package:grocerygo/common/custom_backgound.dart';
import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/common/exit_dialog.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/view/auth/login_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    // Thay đổi giao diện người dùng của hệ thống thành màu sáng.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (disPop) async {
        if (disPop) {
          return;
        }
        showDialog(
            barrierDismissible:
                false, // ngăn dười dùng tắt hộp thoại khi click bên ngoài nó
            context: context,
            builder: (context) => const ExitDialog());
      },
      child: CustomBackground(
        image: imgWelcome,
        appBar: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight / 2, // Đặt chiều cao
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 139, 139, 139).withOpacity(0.2),
                  const Color.fromARGB(255, 139, 139, 139).withOpacity(0.5),
                  const Color.fromARGB(255, 139, 139, 139).withOpacity(0.8),
                ],
                stops: const [
                  0.0,
                  0.5,
                  1.0,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.heightBox,
                  Image.asset(
                    icLogo,
                    width: context.screenWidth * 0.15,
                    fit: BoxFit.cover,
                  ),
                  30.heightBox,
                  const Text(
                    welcomeToOurStore,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: gilroyBold,
                      fontSize: 30,
                      height: 1.2,
                    ),
                  ),
                  10.heightBox,
                  Text(
                    pleaseEnjoyOurConvenienceAndFastDelivery,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                        fontFamily: gilroyMedium,
                        height: 1.2),
                  ),
                  70.heightBox,
                  CustomButton(
                    width: context.screenWidth * 0.85,
                    height: context.screenHeight * 0.065,
                    color: primary,
                    title: getStarted,
                    textColor: Colors.white,
                    radius: 20,
                    size: 24,
                    onPress: () {
                      Get.to(() => const LoginView());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
