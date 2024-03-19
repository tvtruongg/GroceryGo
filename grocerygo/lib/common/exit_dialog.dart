import 'package:flutter/services.dart';
import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/utility/export.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          confirm.text.size(22).color(redColor).fontFamily(gilroyBold).make(),
          15.heightBox,
          areYouSureYouWantToExit.text
              .size(16)
              .color(primaryText)
              .fontFamily(gilroyMedium)
              .make(),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  // Thoát
                  color: const Color.fromARGB(255, 241, 90, 56),
                  onPress: () {
                    SystemNavigator.pop(); // Yêu cầu hệ thống đóng ứng dụng
                  },
                  title: yes,
                  textColor: Colors.white,
                  width: 100,
                  height: 40,
                  radius: 10,
                  size: 16),
              CustomButton(
                  // Hủy thoát
                  color: redColor,
                  onPress: () {
                    Navigator.pop(
                        context); // tìm kiếm màn hình trước đó trong ngăn xếp điều hướng, đưa người dùng trở lại màn hình trước đó.
                  },
                  title: no,
                  textColor: Colors.white,
                  width: 100,
                  height: 40,
                  radius: 10,
                  size: 16),
            ],
          )
        ],
      ).box.white.padding(const EdgeInsets.all(20)).roundedSM.make(),
    );
  }
}
