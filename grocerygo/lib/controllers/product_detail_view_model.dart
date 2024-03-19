import 'dart:async';

import 'package:grocerygo/model/product_details_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/model/review_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class ProductDetailViewMode extends GetxController {
  final ProductModel productModel;

  // Controller
  ProductDetailViewMode({required this.productModel}) {
    serviceCallProductDetail();
  }

  @override
  void onClose() {
    streamProductDetails.close();
    streamReview.close();
    streamReviewDetails.close();
    streamProductBrand.close();
    streamProductSuggest.close();
    super.onClose();
  }

  StreamController<ProductDetailsModel> streamProductDetails =
      StreamController<ProductDetailsModel>.broadcast();
  StreamController<List<ReviewModel>> streamReview =
      StreamController<List<ReviewModel>>.broadcast();
  StreamController<List<ReviewModel>> streamReviewDetails =
      StreamController<List<ReviewModel>>.broadcast();
  StreamController<List<ProductModel>> streamProductBrand =
      StreamController<List<ProductModel>>.broadcast();
  StreamController<List<ProductModel>> streamProductSuggest =
      StreamController<List<ProductModel>>.broadcast();

  List<ReviewModel> mainData = [];

  var itemIndex = 0.obs;
  var isChechReview = false.obs;

  var isCheckScroll = false.obs;

  void onChanged(int index) {
    itemIndex.value = index;
  }

  // Check Tabbar
  var isShowTabbar = false.obs;
  void showTabbar() {
    isShowTabbar.value = !isShowTabbar.value;
  }

  final isShowDetail = true.obs;
  final isShowNutrition = false.obs;
  final isShowReview = false.obs;

  void showDetail() {
    isShowDetail.value = !isShowDetail.value;
  }

  void showNutrition() {
    isShowNutrition.value = !isShowNutrition.value;
  }

  void showReview() {
    isShowReview.value = !isShowReview.value;
  }

  void serviceCallProductDetail() async {
    await ServiceCall.post({
      "product_id": productModel.productId.toString()
    }, SVKey.svProductDetail, isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();
      if (resObj[KKey.status] == "1") {
        var payload = resObj[KKey.payload];

        // Thông tin sản phẩm
        final data = ProductDetailsModel.fromJson(payload["product"]);
        streamProductDetails.add(data);

        // Bình luận
        var data1 = (payload["review"] as List? ?? []).map((oObj) {
          return ReviewModel.fromJson(oObj);
        }).toList();
        streamReview.add(data1);

        // Sản phẩm Nhà cung cấp
        var data2 = (payload["brand"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();
        streamProductBrand.add(data2);

        // Sản phẩm gợi ý
        var data3 = (payload["suggest"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();
        streamProductSuggest.add(data3);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  void serviceCallReviewDetail(int id, int form) async {
    await ServiceCall.post({
      "review_id": id.toString(),
      "from": form.toString(),
      "quantity": 3.toString()
    }, SVKey.svReviewDetail, isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();
      if (resObj[KKey.status] == "1") {
        var payload = resObj[KKey.payload];

        // Bình luận
        var data = (payload["payload"] as List? ?? []).map((oObj) {
          return ReviewModel.fromJson(oObj);
        }).toList();
        mainData.addAll(data);
        streamReviewDetails.add(mainData);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  // Lắng nghe sự thay đổi của streamController
  Stream<List<ReviewModel>> get dataStreamReviewDetails =>
      streamReviewDetails.stream;

  // void serviceCallAddRemoveFavorite() {
  //   Globs.showHUD();
  //   ServiceCall.post({
  //     "prod_id": pObj.prodId.toString(),
  //   }, SVKey.svAddRemoveFavorite, isToken: true, withSuccess: (resObj) async {
  //     Globs.hideHUD();

  //     if (resObj[KKey.status] == "1") {
  //       isFav.value = !isFav.value;
  //       Get.snackbar(Globs.appName, resObj[KKey.message]);
  //     } else {}
  //   }, failure: (err) async {
  //     Globs.hideHUD();
  //     Get.snackbar(Globs.appName, err.toString());
  //   });
  // }
}
