import 'package:flutter/foundation.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class FavoriteViewModel extends GetxController {
  final RxList<ProductModel> favouriteArray = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      print("FavoriteViewModel Init ");
    }

    serviceCalList();
  }

  //ServiceCall
  void serviceCalList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svFavorite, isToken: true,
        withSuccess: (resObj) async {
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        
        var listDataArr = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();

        favouriteArray.value = listDataArr;
      } else {}
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  void serviceCallAddRemoveFavorite(int index) {
    Globs.showHUD();
    ServiceCall.post({
      "prod_id": favouriteArray[index].productId.toString(),
    }, SVKey.svAddRemoveFavorite, isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();

      if (resObj[KKey.status] == "1") {
        favouriteArray.removeAt(index);
        Get.snackbar(appname, resObj[KKey.message]);
      } else {}
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }
}
