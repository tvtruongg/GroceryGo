import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/utility/export.dart';

class ExploreCell extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onPressed;

  const ExploreCell(
      {super.key, required this.categoryModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
              color: categoryModel.caColor != null
                  ? Color(int.parse('0xFF${categoryModel.caColor}'))
                  : primary,
              width: 1),
          color: categoryModel.caColor != null
              ? Color(int.parse('0xFF${categoryModel.caColor}'))
                  .withOpacity(0.3)
              : primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  width: 110,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const Spacer(),
            Text(
              categoryModel.caName ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: primaryText, fontSize: 16, fontFamily: gilroyBold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
