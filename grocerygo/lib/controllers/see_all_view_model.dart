import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/service/globs.dart';
import 'package:grocerygo/service/service_call.dart';
import 'package:grocerygo/utility/export.dart';

class SeeAllViewModel extends GetxController {
  final int type;

  SeeAllViewModel({required this.type});

  final RxList<ProductModel> arrayProduct = <ProductModel>[].obs;
  final RxList<CategoryModel> arrayCategory = <CategoryModel>[].obs;

  EasyRefreshController controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  bool isLoadingMore = false;

  // Số trang
  int isFrom = 0;
  int isQuantity = 10;

  @override
  void onInit() async {
    super.onInit();
    await serviceCallList(isFrom, isQuantity);
  }

  void onLoadMore() async {
    if (isLoadingMore == false) return;
    isFrom += isQuantity;
    await serviceCallList(isFrom, isQuantity);
  }

  void onRefresh() async {
    arrayProduct.clear();
    isFrom = 0;
    await serviceCallList(isFrom, isQuantity);
    isLoadingMore = true;
    controller.finishRefresh();
  }

  // ServiceCall
  Future serviceCallList(int from, int quantity) async {
    Globs.showHUD();

    ServiceCall.post(
        {"from": from.toString(), "quantity": quantity.toString()},
        type == 1
            ? SVKey.svAllExclusiveOffer
            : type == 2
                ? SVKey.svAllBestSelling
                : type == 3
                    ? SVKey.svAllFavoriteProduct
                    : type == 4
                        ? SVKey.svAllCategory
                        : SVKey.svAllProductNew,
        isToken: true, withSuccess: (resObj) async {
      Globs.hideHUD();
      if (resObj[KKey.status] == "1") {
        if (type != 4) {
          List<ProductModel> data = [];
          data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
            return ProductModel.fromJson(oObj);
          }).toList();
          arrayProduct.addAll(data);
          if (data.isEmpty || data.length < 10) {
            isLoadingMore = false;
            controller.finishLoad(IndicatorResult.noMore);
          } else if (data.isNotEmpty && data.length >= 10) {
            isLoadingMore = true;
            controller.finishLoad(IndicatorResult.success);
          }
        } else {
          List<CategoryModel> data = [];
          data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
            return CategoryModel.fromJson(oObj);
          }).toList();
          arrayCategory.addAll(data);
          if (data.isEmpty || data.length < 10) {
            isLoadingMore = false;
            controller.finishLoad(IndicatorResult.noMore);
          } else if (data.isNotEmpty && data.length >= 10) {
            isLoadingMore = true;
            controller.finishLoad(IndicatorResult.success);
          }
        }
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(appname, err.toString());
    });
  }
}
