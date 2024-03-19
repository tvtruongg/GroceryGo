import 'package:grocerygo/utility/export.dart';

class CustomTextfield extends StatelessWidget {
  final String? title;
  final Color titleColor;
  final String? textHint;
  final Color textHintColor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? rightIcon;
  final TextEditingController controller;
  const CustomTextfield({
    super.key,
    required this.title,
    required this.titleColor,
    required this.textHint,
    required this.textHintColor,
    this.keyboardType,
    this.obscureText = false,
    this.rightIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title!,
          style: TextStyle(
              fontFamily: gilroyBold, fontSize: 16, color: titleColor),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
              suffixIcon: rightIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: textHint,
              hintStyle: TextStyle(
                  color: textHintColor,
                  fontFamily: gilroyRegular,
                  fontSize: 16)),
        ),
        Container(
          width: double.maxFinite,
          height: 1,
          color: const Color.fromARGB(255, 147, 147, 147).withOpacity(0.4),
        )
      ],
    );
  }
}
