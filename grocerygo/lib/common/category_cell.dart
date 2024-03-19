import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/utility/export.dart';

class CategoryCell extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onPressed;

  const CategoryCell(
      {super.key, required this.categoryModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: categoryModel.caColor != null
              ? Color(int.parse('0xFF${categoryModel.caColor}'))
                  .withOpacity(0.8)
              : primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: categoryModel.caImage ?? "",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
                10.widthBox,
                Expanded(
                  child: Text(categoryModel.caName ?? "")
                      .text
                      .size(16)
                      .color(primaryText.withOpacity(0.8))
                      .fontFamily(gilroyBold)
                      .make(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
