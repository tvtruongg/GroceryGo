import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/utility/export.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final List<String> text;
  const CustomDialog({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  title!.text
                      .size(20)
                      .fontFamily(gilroyBold)
                      .color(primary)
                      .make(),
                  10.heightBox,
                  SizedBox(
                    height: context.screenHeight * 0.46,
                    child: ListView.builder(
                        itemCount: text.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            subtitle: Text(text[index],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  color: textTitle,
                                  fontFamily: gilroyMedium,
                                  fontSize: 14,
                                  height: 1.5,
                                )),
                            contentPadding: const EdgeInsets.all(5),
                          );
                        }),
                  ),
                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          width: context.screenWidth * 0.2,
                          height: 40,
                          color: primary,
                          title: understood,
                          textColor: Colors.white,
                          size: 14,
                          radius: 10,
                          onPress: () {
                            Get.back();
                          })
                    ],
                  )
                ],
              ))
          .box
          .white
          .size(context.screenWidth * 0.8, context.screenHeight * 0.6)
          .roundedSM
          .shadowSm
          .make(),
    );
  }
}
