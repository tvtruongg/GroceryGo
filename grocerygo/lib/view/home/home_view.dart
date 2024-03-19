import 'package:grocerygo/common/category_cell.dart';
import 'package:grocerygo/common/custom_bottom_sheet.dart';
import 'package:grocerygo/common/product_cell.dart';
import 'package:grocerygo/common/section_title.dart';
import 'package:grocerygo/controllers/home_view_model.dart';
import 'package:grocerygo/controllers/splash_view_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/view/reusable/product_details_view.dart';
import 'package:grocerygo/view/reusable/see_all.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeVM = Get.put(HomeViewModel());
  final splashVM = Get.find<SplashViewModel>();

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeViewModel>();
    // Flutter Tutorial - Sliver App Bar & Collapsing Toolbar
  }

  @override
  Widget build(BuildContext context) {
    // Độ rộng
    double height = context.screenHeight * 0.28;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icLogoColor,
                    width: 30,
                  ),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icLocation,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ("Xin Chào ${splashVM.userModel.value.userName} !")
                      .text
                      .size(18)
                      .color(primaryText)
                      .fontFamily(gilroyBold)
                      .make()
                ],
              ),
              20.heightBox,
              // Quảng cáo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: double.maxFinite,
                    height: 115,
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F3F2),
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      imgBannerTop,
                      fit: BoxFit.cover,
                    )),
              ),

              // Giảm giá
              SectionTitle(
                title: exclusiveOffer,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {
                  Get.to(() => const SeeAll(title: exclusiveOffer, type: 1),
                      transition: Transition.rightToLeftWithFade);
                },
              ),
              SizedBox(
                height: height,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount:
                          (homeVM.exclusiveOfferArray.length + 1).toInt(),
                      itemBuilder: (context, index) {
                        return index < homeVM.exclusiveOfferArray.length
                            ? ProductCell(
                                productModel: homeVM.exclusiveOfferArray[index],
                                onPressed: () {
                                  Get.to(
                                      () => ProductDetails(
                                          productModel: homeVM
                                              .exclusiveOfferArray[index]),
                                      transition: Transition.zoom);
                                },
                                onCart: () {},
                                icon: icpriceTag,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => const SeeAll(
                                                title: exclusiveOffer, type: 1),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        child: Image.asset(icRightArrow,
                                            width: 25, fit: BoxFit.cover),
                                      ),
                                    ),
                                    15.heightBox,
                                    "Xem tất cả"
                                        .text
                                        .size(12)
                                        .color(primaryText)
                                        .fontFamily(gilroyBold)
                                        .make(),
                                  ],
                                ),
                              );
                      }),
                ),
              ),

              // Bán chạy nhất
              SectionTitle(
                title: bestSelling,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {
                  Get.to(() => const SeeAll(title: bestSelling, type: 2),
                      transition: Transition.rightToLeftWithFade);
                },
              ),
              SizedBox(
                height: height,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: (homeVM.bestSellingArray.length + 1).toInt(),
                      itemBuilder: (context, index) {
                        return index < homeVM.bestSellingArray.length
                            ? ProductCell(
                                productModel: homeVM.bestSellingArray[index],
                                onPressed: () async {
                                  Get.to(
                                      () => ProductDetails(
                                          productModel:
                                              homeVM.bestSellingArray[index]),
                                      transition: Transition.zoom);
                                },
                                onCart: () {
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                      builder: (BuildContext context) =>
                                          CustomBottomSheet(
                                              iImage: homeVM
                                                  .bestSellingArray[index]
                                                  .iImage!,
                                              pPrice: homeVM
                                                  .bestSellingArray[index]
                                                  .pPrice!,
                                              ofPrice: homeVM
                                                  .bestSellingArray[index]
                                                  .ofPrice!,
                                              isOfferActive: homeVM
                                                  .bestSellingArray[index]
                                                  .isOfferActive!,
                                              pUnitValue: homeVM
                                                  .bestSellingArray[index]
                                                  .pUnitValue!,
                                              pUnitName: homeVM
                                                  .bestSellingArray[index]
                                                  .pUnitName!,
                                              sSold: homeVM
                                                  .bestSellingArray[index]
                                                  .sSold!,
                                              title: "Thêm Vào Giỏ Hàng"));
                                },
                                icon: icFire,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => const SeeAll(
                                                title: bestSelling, type: 2),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        child: Image.asset(icRightArrow,
                                            width: 25, fit: BoxFit.cover),
                                      ),
                                    ),
                                    15.heightBox,
                                    "Xem tất cả"
                                        .text
                                        .size(12)
                                        .color(primaryText)
                                        .fontFamily(gilroyBold)
                                        .make(),
                                  ],
                                ),
                              );
                      }),
                ),
              ),

              // Yêu thích nhất
              SectionTitle(
                title: favoriteProduct,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {
                  Get.to(() => const SeeAll(title: favoriteProduct, type: 3),
                      transition: Transition.rightToLeftWithFade);
                },
              ),
              SizedBox(
                height: height,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount:
                          (homeVM.favoriteProductArray.length + 1).toInt(),
                      itemBuilder: (context, index) {
                        return index < homeVM.favoriteProductArray.length
                            ? ProductCell(
                                productModel:
                                    homeVM.favoriteProductArray[index],
                                onPressed: () async {
                                  Get.to(
                                      () => ProductDetails(
                                          productModel: homeVM
                                              .favoriteProductArray[index]),
                                      transition: Transition.zoom);
                                },
                                onCart: () {
                                  // CartViewModel.serviceCallAddToCart(
                                  //     pObj.prodId ?? 0, 1, () {});
                                },
                                icon: icfavourireProduct,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => const SeeAll(
                                                title: favoriteProduct,
                                                type: 3),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        child: Image.asset(icRightArrow,
                                            width: 25, fit: BoxFit.cover),
                                      ),
                                    ),
                                    15.heightBox,
                                    "Xem tất cả"
                                        .text
                                        .size(12)
                                        .color(primaryText)
                                        .fontFamily(gilroyBold)
                                        .make(),
                                  ],
                                ),
                              );
                      }),
                ),
              ),

              // Thể loại
              SectionTitle(
                title: groceries,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {
                  Get.to(() => const SeeAll(title: groceries, type: 4),
                      transition: Transition.rightToLeftWithFade);
                },
              ),
              SizedBox(
                height: 100,
                child: Obx(
                  () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: (homeVM.categoryArray.length + 1).toInt(),
                      itemBuilder: (context, index) {
                        return index < homeVM.categoryArray.length
                            ? CategoryCell(
                                categoryModel: homeVM.categoryArray[index],
                                onPressed: () {},
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => const SeeAll(
                                                title: groceries, type: 4),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        child: Image.asset(icRightArrow,
                                            width: 25, fit: BoxFit.cover),
                                      ),
                                    ),
                                    15.heightBox,
                                    "Xem tất cả"
                                        .text
                                        .size(12)
                                        .color(primaryText)
                                        .fontFamily(gilroyBold)
                                        .make(),
                                  ],
                                ),
                              );
                      }),
                ),
              ),

              // Sản phẩm mới
              SectionTitle(
                title: productNew,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                onPressed: () {
                  Get.to(() => const SeeAll(title: productNew, type: 5),
                      transition: Transition.rightToLeftWithFade);
                },
              ),
              Obx(
                () => GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 250),
                  itemCount: homeVM.productNewArray.length,
                  itemBuilder: (context, index) {
                    return ProductCell(
                      productModel: homeVM.productNewArray[index],
                      onPressed: () async {},
                      onCart: () {},
                      icon: icNewProduct,
                    );
                  },
                ),
              ),
              20.heightBox,
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const SeeAll(title: productNew, type: 5),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      "Xem thêm"
                          .text
                          .size(14)
                          .color(primaryText)
                          .fontFamily(gilroyBold)
                          .make(),
                      5.widthBox,
                      Image.asset(
                        icRightArrow,
                        width: 25,
                        fit: BoxFit.cover,
                      )
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5))
                      .withDecoration(BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: placeHolder.withOpacity(0.5), width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ))
                      .make(),
                ),
              ),
              30.heightBox
            ])));
  }
}
