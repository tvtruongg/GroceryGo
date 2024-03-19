import 'dart:async';

import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class ExploreDetailsViewModel extends GetxController {
  final CategoryModel categoryModel;

  EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  bool isLoadingMore = false;
  bool isRefresh = true;

  StreamController<List<ProductModel>> streamController =
      StreamController<List<ProductModel>>();
  List<ProductModel> mainData = [];

  // Số trang
  var isFrom = 0;
  var isQuantity = 10;

  ExploreDetailsViewModel(this.categoryModel) {
    isFrom = 0;
    isQuantity = 10;
    serviceCallList();
  }

  @override
  void onClose() {
    streamController.close();
    super.onClose();
  }

  void onLoadMore() {
    if (isLoadingMore == false) return;
    isFrom += isQuantity;
    serviceCallList();
  }

  void onRefresh() {
    if (isRefresh == false) return;
    mainData = [];
    streamController.add(mainData);
    isFrom = 0;
    serviceCallList();
    isLoadingMore = true;
    easyRefreshController.finishRefresh();
  }

  void serviceCallList() async {
    // Khi vào trong server, sẽ tắt load more, đợi tải dữ liệu thành công thì mới mở lại
    isLoadingMore = false;
    isRefresh = false;
    await ServiceCall.post({
      "category_id": categoryModel.categoryId.toString(),
      "from": isFrom.toString(),
      "quantity": isQuantity.toString()
    }, SVKey.svExploreItemList, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == "1") {
        final data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return ProductModel.fromJson(oObj);
        }).toList();
        mainData.addAll(data);
        streamController.add(mainData);
        if (data.isEmpty || data.length < 10) {
          isLoadingMore = false;
          easyRefreshController.finishLoad(IndicatorResult.noMore);
        } else if (data.isNotEmpty && data.length >= 10) {
          isLoadingMore = true;
          easyRefreshController.finishLoad(IndicatorResult.success);
        }
        isRefresh = true;
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }

  // Lắng nghe sự thay đổi của streamController
  Stream<List<ProductModel>> get dataStream => streamController.stream;
}
