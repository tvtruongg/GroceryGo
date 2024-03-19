import 'package:grocerygo/utility/export.dart';

class CustomBackground extends StatelessWidget {
  final String? image;
  final bool appBar;
  final Widget? child;

  const CustomBackground({
    super.key,
    required this.image,
    required this.appBar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
        child: image != null
            ? Image.asset(
                image!,
                width: context.screenWidth,
                height: context.screenHeight,
                fit: BoxFit.cover,
              )
            : Image.asset(
                imgLogin,
                width: context.screenWidth,
                height: context.screenHeight,
                fit: BoxFit.cover,
              ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar == true
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Image.asset(
                      icBack,
                      width: 20,
                      height: 20,
                    )),
              )
            : null,
        body: child ?? const SizedBox.shrink(),
      )
    ]);
  }
}
