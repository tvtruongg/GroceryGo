import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/utility/export.dart';

class CustomBottomSheet extends StatelessWidget {
  final String iImage;
  final int pPrice;
  final int ofPrice;
  final int isOfferActive;
  final String pUnitValue;
  final String pUnitName;
  final int sSold;
  final String title;
  const CustomBottomSheet(
      {super.key,
      required this.iImage,
      required this.pPrice,
      required this.ofPrice,
      required this.isOfferActive,
      required this.pUnitValue,
      required this.pUnitName,
      required this.sSold,
      required this.title});

  @override
  Widget build(BuildContext context) {
    var quantityProduct = 1.obs;
    return SizedBox(
      height: context.screenHeight * 0.8,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 122, 120, 120),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ]),
              20.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CachedNetworkImage(
                      imageUrl: iImage,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  15.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (formatCurrency(pPrice - ofPrice))
                          .text
                          .size(28)
                          .color(Colors.red[400])
                          .fontFamily(gilroyBold)
                          .make(),
                      5.heightBox,
                      isOfferActive != 0 && ofPrice != 0
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  formatCurrency(pPrice),
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.black45,
                                      decorationThickness: 1,
                                      fontSize: 14,
                                      color: secondaryText,
                                      fontFamily: gilroyMedium),
                                ),
                                8.widthBox,
                                SizedBox(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            gradient: const LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 243, 192, 188),
                                                Color.fromARGB(
                                                    255, 238, 159, 153),
                                                Color.fromARGB(
                                                    255, 240, 124, 115),
                                              ],
                                              stops: [0.2, 0.6, 1],
                                            ),
                                          ),
                                          child: Text(
                                            "-${((ofPrice / pPrice) * 100).toStringAsFixed(0)}%",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87,
                                                fontFamily: gilroyMedium),
                                          )),
                                    )),
                              ],
                            )
                          : const SizedBox.shrink(),
                      5.heightBox,
                      ("$pUnitValue $pUnitName, $sSold đã bán")
                          .text
                          .size(14)
                          .color(primaryText.withOpacity(0.5))
                          .fontFamily(gilroyBold)
                          .make(),
                    ],
                  )
                ],
              ),
              const Divider(
                color: Colors.black26,
                height: 1,
                thickness: 1,
              ),
              // Số lượng
              15.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Số Lượng"
                      .text
                      .size(18)
                      .fontFamily(gilroyBold)
                      .color(primaryText)
                      .make(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            quantityProduct.value > 1 &&
                                    quantityProduct.value <= 10
                                ? quantityProduct.value -= 1
                                : quantityProduct.value = 1;
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.remove_circle_outline,
                              size: 35,
                              color: quantityProduct.value <= 1
                                  ? primary.withOpacity(0.3)
                                  : primary,
                            ),
                          )),
                      Container(
                        width: 45,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: primaryText.withOpacity(0.5), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              quantityProduct.value.toString(),
                              style: const TextStyle(
                                  color: primaryText,
                                  fontSize: 18,
                                  fontFamily: gilroyBold),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            quantityProduct.value >= 1 &&
                                    quantityProduct.value < 10
                                ? quantityProduct.value += 1
                                : quantityProduct.value = 10;
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.add_circle_outline,
                              size: 35,
                              color: quantityProduct.value >= 10
                                  ? primary.withOpacity(0.3)
                                  : primary,
                            ),
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomButton(
                  width: context.screenWidth,
                  height: 60,
                  color: Colors.amber,
                  color1: const Color.fromARGB(255, 245, 67, 58),
                  title: "Thêm Vào Giỏ Hàng",
                  textColor: Colors.white,
                  radius: 20,
                  size: 20,
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
