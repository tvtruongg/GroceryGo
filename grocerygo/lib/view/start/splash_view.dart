import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';
import 'package:grocerygo/view/start/welcome_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashVM = Get.put(SplashViewModel());
  @override
  void initState() {
    startApp();
    super.initState();
    splashVM.loadView();
  }

  // Mở ứng dụng sau 2s
  void startApp() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const WelcomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          icLogo,
                          width: context.screenWidth * 0.1,
                          fit: BoxFit.fill,
                        ),
                        5.widthBox,
                        appname.text.white
                            .size(40)
                            .fontFamily(gilroyBold)
                            .shadowBlur(5)
                            .make(),
                      ]),
                  10.heightBox,
                  appversion.text
                      .size(14)
                      .fontFamily(gilroyMedium)
                      .white
                      .make(),
                ]),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  credits.text.white.size(14).fontFamily(gilroySemiBold).make(),
                  30.heightBox
                ],
              ),
            ),
          ],
        ));
  }
}
