import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoriteRow extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onPressed;

  const FavoriteRow(
      {super.key, required this.productModel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: productModel.iImage ?? "",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (productModel.pName ?? "")
                          .text
                          .size(16)
                          .fontFamily(gilroyBold)
                          .color(primaryText)
                          .make(),
                      5.heightBox,
                      ("${productModel.pUnitValue} ${productModel.pUnitName}")
                          .text
                          .size(14)
                          .color(secondaryText)
                          .fontFamily(gilroyMedium)
                          .make(),
                    ],
                  ),
                ),
                10.widthBox,
                (formatCurrency(productModel.pPrice))
                    .text
                    .size(18)
                    .color(primaryText)
                    .fontFamily(gilroyBold)
                    .make(),
                15.widthBox,
                Image.asset(
                  icBack,
                  height: 10,
                  color: primaryText,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.black26,
          height: 1,
        ),
      ],
    );
  }
}
