import 'package:grocerygo/utility/export.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isShowSeeAllButton;
  final VoidCallback onPressed;
  final EdgeInsets? padding;

  const SectionTitle(
      {super.key,
      required this.title,
      this.isShowSeeAllButton = true,
      this.padding,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          15.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title.text
                  .size(24)
                  .color(primaryText)
                  .fontFamily(gilroyBold)
                  .make(),
              isShowSeeAllButton
                  ? TextButton(
                      onPressed: onPressed,
                      child: seeAll.text
                          .size(16)
                          .color(primary)
                          .fontFamily(gilroyBold)
                          .make(),
                    )
                  : const SizedBox.shrink(), // Không chiếm không gian
            ],
          ),
        ],
      ),
    );
  }
}
