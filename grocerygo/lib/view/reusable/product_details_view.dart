import 'package:grocerygo/common/custom_bottom_sheet.dart';
import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/common/product_cell.dart';
import 'package:grocerygo/common/review_cell.dart';
import 'package:grocerygo/common/section_title.dart';
import 'package:grocerygo/controllers/product_detail_view_model.dart';
import 'package:grocerygo/model/product_details_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/model/review_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetails({super.key, required this.productModel});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late ProductDetailViewMode productDetailVM;
  late GlobalKey key1, key2, key3;
  late ScrollController scrollController;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    productDetailVM =
        Get.put(ProductDetailViewMode(productModel: widget.productModel));
    key1 = GlobalKey();
    key2 = GlobalKey();
    key3 = GlobalKey();

    scrollController = ScrollController();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    Get.delete<ProductDetailViewMode>();
    tabController.dispose();
    super.dispose();
  }

  void scrollToPosition(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight * 0.28;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                icBack,
                width: 20,
                color: primaryText,
              )),
          title: AutoSizeText(
            (widget.productModel.pName ?? ""),
            style: const TextStyle(
                fontSize: 22, color: primaryText, fontFamily: gilroyBold),
            maxLines: 1,
            overflow: TextOverflow
                .ellipsis, //hiển thị một dấu chấm ba chấm (...) ở cuối
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  icSharing,
                  width: 20,
                  color: primaryText,
                ))
          ],
        ),
        body: StreamBuilder<List<Object>?>(
          stream: rxdart.CombineLatestStream.combine4(
              productDetailVM.streamProductDetails.stream,
              productDetailVM.streamReview.stream,
              productDetailVM.streamProductBrand.stream,
              productDetailVM.streamProductSuggest.stream,
              (productDetails, reviews, productBrand, productSuggest) {
            return [productDetails, reviews, productBrand, productSuggest];
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              EasyLoading.show(status: "loading ...");
              return Container(
                color: Colors.pink,
              );
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                EasyLoading.dismiss();
                return Container(
                  color: Colors.amber,
                );
              } else if (snapshot.hasData) {
                EasyLoading.dismiss();
                List<Object>? combinedData = snapshot.data;
                ProductDetailsModel? productDetails =
                    combinedData?[0] as ProductDetailsModel?;
                List<ReviewModel>? reviews =
                    combinedData?[1] as List<ReviewModel>?;
                List<ProductModel>? productBrand =
                    combinedData?[2] as List<ProductModel>?;
                List<ProductModel>? productSuggest =
                    combinedData?[3] as List<ProductModel>?;
                productDetails!.rCount! > 0
                    ? productDetailVM.isShowReview.value = true
                    : productDetailVM.isShowReview.value = false;
                return Stack(children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.axis == Axis.vertical &&
                          notification is ScrollUpdateNotification) {
                        final RenderObject? renderObject1 =
                            key1.currentContext?.findRenderObject();
                        final RenderObject? renderObject2 =
                            key2.currentContext?.findRenderObject();
                        final RenderObject? renderObject3 =
                            key3.currentContext?.findRenderObject();
                        if (renderObject1 is RenderBox &&
                            renderObject2 is RenderBox &&
                            renderObject3 is RenderBox) {
                          final keyPosition1 =
                              renderObject1.localToGlobal(Offset.zero);
                          final keyPosition2 =
                              renderObject2.localToGlobal(Offset.zero);
                          final keyPosition3 =
                              renderObject3.localToGlobal(Offset.zero);
                          // Show Tabbar
                          if (notification.metrics.pixels >= keyPosition1.dy) {
                            productDetailVM.isShowTabbar(true);
                          } else {
                            productDetailVM.isShowTabbar(false);
                          }
                          // Chuyển tab
                          if (notification.metrics.pixels >= keyPosition1.dy &&
                              notification.metrics.pixels < keyPosition2.dy) {
                            tabController.animateTo(0);
                          } else if (notification.metrics.pixels >=
                                  keyPosition2.dy &&
                              notification.metrics.pixels < keyPosition3.dy) {
                            tabController.animateTo(1);
                          } else if (notification.metrics.pixels >=
                                  keyPosition3.dy &&
                              notification.metrics.pixels >=
                                  notification.metrics.pixels) {
                            tabController.animateTo(2);
                          }
                        }
                      }

                      // Show trở về
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent / 2) {
                        productDetailVM.isCheckScroll(true);
                      } else {
                        productDetailVM.isCheckScroll(false);
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        SizedBox(
                          height: 300,
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: productDetails.imageList!.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: productDetails
                                          .imageList![itemIndex].iImage!,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: double.maxFinite,
                                  scrollPhysics:
                                      const AlwaysScrollableScrollPhysics(),
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 10),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                  onPageChanged: (index, reason) {
                                    productDetailVM.onChanged(index);
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Obx(
                                  () => DotsIndicator(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    dotsCount: productDetails.imageList!.length,
                                    position: productDetailVM.itemIndex.value,
                                    decorator: DotsDecorator(
                                      spacing: Vx.m4,
                                      color: const Color.fromARGB(
                                          255, 221, 221, 220),
                                      size: const Size.square(6.0),
                                      activeColor: primary,
                                      activeSize: const Size(16.0, 6.0),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,

                        // Body
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    key: key1,
                                    children: [
                                      Expanded(
                                        child: (productDetails.pName ?? "")
                                            .text
                                            .size(22)
                                            .color(primaryText)
                                            .fontFamily(gilroyBold)
                                            .make(),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          icLove,
                                          width: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ("${productDetails.pUnitValue} ${productDetails.pUnitName}, ${productDetails.sSold} đã bán")
                                      .text
                                      .size(14)
                                      .color(primaryText.withOpacity(0.5))
                                      .fontFamily(gilroyBold)
                                      .make(),
                                  10.heightBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          (formatCurrency(
                                                  productDetails.pPrice! -
                                                      productDetails.ofPrice!))
                                              .text
                                              .size(20)
                                              .color(Colors.red[400])
                                              .fontFamily(gilroyBold)
                                              .make(),
                                          8.widthBox,
                                          SizedBox(
                                            height: 30,
                                            child: productDetails
                                                            .isOfferActive !=
                                                        null &&
                                                    productDetails
                                                            .isOfferActive !=
                                                        0 &&
                                                    ((productDetails.ofPrice! /
                                                                    productDetails
                                                                        .pPrice!) *
                                                                100)
                                                            .toStringAsFixed(
                                                                0) !=
                                                        "0"
                                                ? Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          gradient:
                                                              const LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  243,
                                                                  192,
                                                                  188),
                                                              Color.fromARGB(
                                                                  255,
                                                                  238,
                                                                  159,
                                                                  153),
                                                              Color.fromARGB(
                                                                  255,
                                                                  240,
                                                                  124,
                                                                  115),
                                                            ],
                                                            stops: [
                                                              0.2,
                                                              0.6,
                                                              1
                                                            ],
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "-${((productDetails.ofPrice! / productDetails.pPrice!) * 100).toStringAsFixed(0)}%",
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black87,
                                                              fontFamily:
                                                                  gilroyMedium),
                                                        )),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        formatCurrency(productDetails.pPrice!),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.black45,
                                            decorationThickness: 1,
                                            fontSize: 14,
                                            color: secondaryText,
                                            fontFamily: gilroyMedium),
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  const Divider(
                                    color: Colors.black26,
                                    height: 1,
                                  ),
                                  5.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "Chi Tiết Sản Phẩm"
                                          .text
                                          .size(16)
                                          .fontFamily(gilroyBold)
                                          .color(primaryText)
                                          .make(),
                                      Obx(
                                        () => IconButton(
                                            onPressed: () {
                                              productDetailVM.showDetail();
                                            },
                                            icon: Image.asset(
                                              productDetailVM.isShowDetail.value
                                                  ? icDown
                                                  : icRight,
                                              width: 15,
                                              color: primaryText,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Obx(() => productDetailVM.isShowDetail.value
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Text(
                                            (productDetails.pDetail ?? ""),
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: secondaryText,
                                                fontFamily: gilroyMedium,
                                                height: 1.5),
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                                  15.heightBox,
                                  const Divider(
                                    color: Colors.black26,
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: "Dinh Dưỡng"
                                              .text
                                              .size(16)
                                              .fontFamily(gilroyBold)
                                              .color(primaryText)
                                              .make()),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: secondaryText.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child:
                                            ("${(productDetails.nSum).toString()} ${productDetails.pUnitName}")
                                                .text
                                                .size(9)
                                                .color(secondaryText)
                                                .fontFamily(gilroyBold)
                                                .make(),
                                      ),
                                      Obx(
                                        () => IconButton(
                                          onPressed: () {
                                            productDetailVM.showNutrition();
                                          },
                                          icon: Image.asset(
                                            productDetailVM.isShowNutrition
                                                        .value ==
                                                    false
                                                ? icRight
                                                : icDown,
                                            width: 15,
                                            color: primaryText,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Obx(() => productDetailVM
                                              .isShowNutrition.value ==
                                          true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  "Glucid (Đường)"
                                                      .text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                  const Spacer(),
                                                  productDetails.nGlucid!.text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                ],
                                              ),
                                              productDetails.nType == 1
                                                  ? Column(
                                                      children: [
                                                        10.heightBox,
                                                        const Divider(
                                                          color: Colors.black26,
                                                          height: 1,
                                                        ),
                                                        10.heightBox,
                                                        Row(
                                                          children: [
                                                            "Fiber (Chất xơ)"
                                                                .text
                                                                .size(14)
                                                                .fontFamily(
                                                                    gilroyMedium)
                                                                .color(
                                                                    secondaryText)
                                                                .make(),
                                                            const Spacer(),
                                                            productDetails
                                                                .nFiber!.text
                                                                .size(14)
                                                                .fontFamily(
                                                                    gilroyMedium)
                                                                .color(
                                                                    secondaryText)
                                                                .make(),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                              10.heightBox,
                                              const Divider(
                                                color: Colors.black26,
                                                height: 1,
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  "Lipid (Chất béo)"
                                                      .text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                  const Spacer(),
                                                  productDetails.nLipid!.text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                ],
                                              ),
                                              10.heightBox,
                                              const Divider(
                                                color: Colors.black26,
                                                height: 1,
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  "Protid (Đạm)"
                                                      .text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                  const Spacer(),
                                                  productDetails.nProtid!.text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                ],
                                              ),
                                              10.heightBox,
                                              const Divider(
                                                color: Colors.black26,
                                                height: 1,
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  "Calo"
                                                      .text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                  const Spacer(),
                                                  productDetails.nCalo!.text
                                                      .size(14)
                                                      .fontFamily(gilroyMedium)
                                                      .color(secondaryText)
                                                      .make(),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                                  10.heightBox,
                                  const Divider(
                                    color: Colors.black26,
                                    height: 1,
                                  ),
                                  10.heightBox,
                                  Row(
                                    key: key2,
                                    children: [
                                      Expanded(
                                          child: "Đánh Giá"
                                              .text
                                              .size(16)
                                              .fontFamily(gilroyBold)
                                              .color(primaryText)
                                              .make()),
                                      productDetails.rCount! > 0
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IgnorePointer(
                                                  ignoring: true,
                                                  child: RatingBar.builder(
                                                    initialRating: double.parse(
                                                        productDetails.rRate!),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Color(0xffF3603F),
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                ),
                                                2.widthBox,
                                                "(${productDetails.rCount})"
                                                    .text
                                                    .size(12)
                                                    .fontFamily(gilroyBold)
                                                    .color(primaryText)
                                                    .make(),
                                              ],
                                            )
                                          : "Chưa có đánh giá"
                                              .text
                                              .size(12)
                                              .fontFamily(gilroyMedium)
                                              .color(secondaryText)
                                              .make(),
                                      IconButton(
                                          onPressed: () {
                                            productDetails.rCount! > 0
                                                ? productDetailVM.showReview()
                                                : null;
                                          },
                                          icon: Obx(
                                            () => Image.asset(
                                              productDetailVM.isShowReview.value
                                                  ? icDown
                                                  : icRight,
                                              width: 15,
                                              color: primaryText,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Obx(() => productDetailVM
                                              .isShowReview.value ==
                                          true
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              (reviews!.length + 1).toInt(),
                                          itemBuilder: (context, index) {
                                            return index < reviews.length
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ReviewCell(
                                                          reviewModel:
                                                              reviews[index],
                                                          isMain: true),
                                                      productDetailVM.isChechReview
                                                                      .value ==
                                                                  true &&
                                                              reviews[index]
                                                                      .reviewIdCount! >
                                                                  0
                                                          ? StreamBuilder<
                                                              List<
                                                                  ReviewModel>>(
                                                              stream: productDetailVM
                                                                  .dataStreamReviewDetails,
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  EasyLoading.show(
                                                                      status:
                                                                          "loading ...");
                                                                  return Container(
                                                                    color: Colors
                                                                        .pink,
                                                                  );
                                                                } else if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .active ||
                                                                    snapshot.connectionState ==
                                                                        ConnectionState
                                                                            .done) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    EasyLoading
                                                                        .dismiss();
                                                                    return Container(
                                                                      color: Colors
                                                                          .amber,
                                                                    );
                                                                  } else if (snapshot
                                                                      .hasData) {
                                                                    var data =
                                                                        snapshot
                                                                            .data!;
                                                                    return ListView.builder(
                                                                        padding: const EdgeInsets.only(left: 30),
                                                                        shrinkWrap: true,
                                                                        physics: const NeverScrollableScrollPhysics(),
                                                                        itemCount: data.length,
                                                                        itemBuilder: (context, index) {
                                                                          return ReviewCell(
                                                                              reviewModel: data[index],
                                                                              isMain: false);
                                                                        });
                                                                  } else {
                                                                    EasyLoading
                                                                        .dismiss();
                                                                    return Container(
                                                                      color: Colors
                                                                          .green,
                                                                    );
                                                                  }
                                                                } else {
                                                                  return Text(
                                                                      'State: ${snapshot.connectionState}');
                                                                }
                                                              },
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                      reviews[index]
                                                                  .reviewIdCount! >
                                                              0
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 5,
                                                                      left: 15,
                                                                      bottom:
                                                                          5),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Container(
                                                                    color: Colors
                                                                        .black45,
                                                                    width: 30,
                                                                    height: 1,
                                                                  ),
                                                                  10.widthBox,
                                                                  InkWell(
                                                                    onTap: () {
                                                                      productDetailVM.serviceCallReviewDetail(
                                                                          reviews[index]
                                                                              .reviewId!,
                                                                          0);
                                                                      productDetailVM
                                                                          .isChechReview(
                                                                              true);
                                                                    },
                                                                    child: "Xem ${reviews[index].reviewIdCount} câu trả lời"
                                                                        .text
                                                                        .size(
                                                                            12)
                                                                        .color(
                                                                            primaryText)
                                                                        .fontFamily(
                                                                            gilroyMedium)
                                                                        .make(),
                                                                  ),
                                                                ],
                                                              ))
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  )
                                                : productDetails.rCount! > 5
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              "Xem thêm bình luận"
                                                                  .text
                                                                  .size(14)
                                                                  .color(
                                                                      primaryText)
                                                                  .fontFamily(
                                                                      gilroyBold)
                                                                  .make(),
                                                              5.widthBox,
                                                              Image.asset(
                                                                icRight,
                                                                color:
                                                                    primaryText,
                                                                width: 14,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink();
                                          },
                                        )
                                      : const SizedBox.shrink())
                                ])),

                        // Nhà Cung Cấp
                        SectionTitle(
                          key: key3,
                          title: supplier,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: height,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: (productBrand!.length + 1).toInt(),
                              itemBuilder: (context, index) {
                                return index < productBrand.length
                                    ? ProductCell(
                                        productModel: productBrand[index],
                                        onPressed: () async {},
                                        onCart: () {},
                                        icon: icFire,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 241, 240, 236),
                                                child: Image.asset(icRightArrow,
                                                    width: 25,
                                                    fit: BoxFit.cover),
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
                        // Sản phẩm gợi ý
                        SectionTitle(
                          title: suggestionsForYou,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          onPressed: () {},
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  mainAxisExtent: 250),
                          itemCount: productSuggest!.length,
                          itemBuilder: (context, index) {
                            return ProductCell(
                              productModel: productSuggest[index],
                              onPressed: () async {},
                              onCart: () {},
                              icon: icNewProduct,
                            );
                          },
                        ),
                        20.heightBox,
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {},
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
                                      color: placeHolder.withOpacity(0.5),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ))
                                .make(),
                          ),
                        ),
                        30.heightBox,
                      ]),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => AnimatedOpacity(
                            opacity: productDetailVM.isShowTabbar.value == true
                                ? 1.0
                                : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: IgnorePointer(
                              ignoring:
                                  productDetailVM.isShowTabbar.value == true
                                      ? false
                                      : true,
                              child: Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: Offset(0, 2))
                                  ],
                                ),
                                child: TabBar(
                                  controller: tabController,
                                  indicatorColor: primary,
                                  indicatorPadding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  labelStyle: const TextStyle(
                                      color: primary,
                                      fontSize: 15,
                                      fontFamily: gilroyBold),
                                  unselectedLabelStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontFamily: gilroyBold),
                                  tabs: const [
                                    Tab(text: 'Tổng quan'),
                                    Tab(text: 'Bình luận'),
                                    Tab(text: 'Gợi ý'),
                                  ],
                                  onTap: (index) {
                                    switch (tabController.index) {
                                      case 0:
                                        scrollToPosition(key1);
                                      case 1:
                                        scrollToPosition(key2);
                                      case 2:
                                        scrollToPosition(key3);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => productDetailVM.isCheckScroll.value == true
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: FloatingActionButton(
                                      backgroundColor: const Color.fromARGB(
                                          255, 254, 138, 177),
                                      child: const Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        scrollController.animateTo(
                                          0,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      30.heightBox,
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 1,
                                offset: Offset(0, -1))
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                10.widthBox,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      icChat,
                                      width: 25,
                                    ),
                                    2.heightBox,
                                    "Chat"
                                        .text
                                        .size(10)
                                        .color(primaryText)
                                        .fontFamily(gilroyBold)
                                        .make()
                                  ],
                                ),
                                40.widthBox,
                                CustomButton(
                                  width: context.screenWidth * 0.3,
                                  height: 50,
                                  color: Colors.amber,
                                  title: "Mua ngay",
                                  textColor: Colors.white,
                                  radius: 25,
                                  size: 14,
                                  onPress: () {},
                                ),
                                20.widthBox,
                                CustomButton(
                                  width: context.screenWidth * 0.3,
                                  height: 50,
                                  color: Colors.amber,
                                  color1:
                                      const Color.fromARGB(255, 245, 67, 58),
                                  title: "Thêm vào giỏ hàng",
                                  textColor: Colors.white,
                                  radius: 25,
                                  size: 14,
                                  onPress: () {
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
                                                iImage:
                                                    productDetails
                                                        .imageList![0].iImage!,
                                                pPrice: productDetails.pPrice!,
                                                ofPrice:
                                                    productDetails.ofPrice!,
                                                isOfferActive: productDetails
                                                    .isOfferActive!,
                                                pUnitValue:
                                                    productDetails.pUnitValue!,
                                                pUnitName:
                                                    productDetails.pUnitName!,
                                                sSold: productDetails.sSold!,
                                                title: "Thêm Vào Giỏ Hàng"));
                                  },
                                ),
                                10.widthBox
                              ],
                            )),
                      ),
                    ],
                  ),
                ]);
              } else {
                EasyLoading.dismiss();
                return Container(
                  color: Colors.green,
                );
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}
