import 'package:flutter/foundation.dart';
import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class HomeViewModel extends GetxController {
  final RxList<ProductModel> exclusiveOfferArray = <ProductModel>[].obs;
  final RxList<ProductModel> bestSellingArray = <ProductModel>[].obs;
  final RxList<ProductModel> favoriteProductArray = <ProductModel>[].obs;
  final RxList<CategoryModel> categoryArray = <CategoryModel>[].obs;
  final RxList<ProductModel> productNewArray = <ProductModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      print("HomeViewModel Init ");
    }

    serviceCallHome();
  }

  //ServiceCall
  void serviceCallHome() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svHome, isToken: true,
        withSuccess: (resObject) async {
      Globs.hideHUD();

      if (resObject[KKey.status] == "1") {
        var payload = resObject[KKey.payload] as Map? ?? {};

        var exclusiveOfferData =
            (payload["exclusive_offer"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();

        exclusiveOfferArray.value = exclusiveOfferData;

        var bestSellingData = (payload["best_sell"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();

        bestSellingArray.value = bestSellingData;

        var favoriteDroductData =
            (payload["favorite_product"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();

        favoriteProductArray.value = favoriteDroductData;

        var categoryData =
            (payload["category_list"] as List? ?? []).map((oObj) {
          return CategoryModel.fromJson(oObj);
        }).toList();

        categoryArray.value = categoryData;

        var productNewData =
            (payload["product_new"] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();

        productNewArray.value = productNewData;
        
      } else {}
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }
}
