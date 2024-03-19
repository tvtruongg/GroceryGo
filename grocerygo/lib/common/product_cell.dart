import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/utility/export.dart';

class ProductCell extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onPressed;
  final VoidCallback onCart;
  final String? icon;

  const ProductCell(
      {super.key,
      required this.productModel,
      required this.onPressed,
      required this.onCart,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: context.screenWidth * 0.43,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: placeHolder.withOpacity(0.5), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      5.heightBox,
                      CachedNetworkImage(
                        imageUrl: productModel.iImage ?? "",
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(), // Đang load
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error), // Hiển thị lỗi
                        width: context.screenWidth * 0.38,
                        height: context.screenHeight * 0.12,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                icon != null
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          icon!,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      (productModel.pName ?? ""),
                      style: const TextStyle(
                          fontSize: 18,
                          color: primaryText,
                          fontFamily: gilroyBold),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
                    ),
                    4.heightBox,
                    ("${productModel.pUnitValue} ${productModel.pUnitName}, ${productModel.sSold} đã bán")
                        .text
                        .size(13)
                        .color(primaryText.withOpacity(0.5))
                        .fontFamily(gilroyBold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        AutoSizeText(
                          (productModel.isOfferActive != null &&
                                  productModel.isOfferActive != 0
                              ? (formatCurrency(
                                  productModel.pPrice! - productModel.ofPrice!))
                              : formatCurrency(productModel.pPrice)),
                          style: const TextStyle(
                              fontSize: 16,
                              color: primaryText,
                              fontFamily: gilroyBold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.widthBox,
                        SizedBox(
                          height: 30,
                          child: productModel.isOfferActive != null &&
                                  productModel.isOfferActive != 0 &&
                                  ((productModel.ofPrice! /
                                                  productModel.pPrice!) *
                                              100)
                                          .toStringAsFixed(0) !=
                                      "0"
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromARGB(255, 243, 192, 188),
                                            Color.fromARGB(255, 238, 159, 153),
                                            Color.fromARGB(255, 240, 124, 115),
                                          ],
                                          stops: [0.2, 0.6, 1],
                                        ),
                                      ),
                                      child: Text(
                                        "-${((productModel.ofPrice! / productModel.pPrice!) * 100).toStringAsFixed(0)}%",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black87,
                                            fontFamily: gilroyMedium),
                                      )),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: productModel.rRate! != "0.0"
                      ? Row(
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: RatingBar.builder(
                                initialRating:
                                    double.parse(productModel.rRate!),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF3603F),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            2.widthBox,
                            "(${productModel.rCount})"
                                .text
                                .size(12)
                                .fontFamily(gilroyBold)
                                .color(primaryText)
                                .make(),
                          ],
                        )
                      : "Chưa có đánh giá"
                          .text
                          .size(10)
                          .fontFamily(gilroyMedium)
                          .color(primaryText)
                          .make(),
                ),
                InkWell(
                  onTap: onCart,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      icAddCart,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
