import 'package:grocerygo/common/explore_cell.dart';
import 'package:grocerygo/common/product_cell.dart';
import 'package:grocerygo/controllers/see_all_view_model.dart';
import 'package:grocerygo/utility/export.dart';

class SeeAll extends StatefulWidget {
  final String title;
  final int type;
  const SeeAll({super.key, required this.title, required this.type});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  late SeeAllViewModel seeAllVM;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    seeAllVM = Get.put(SeeAllViewModel(type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                icBack,
                width: 20,
                color: primaryText,
              )),
          title: widget.title.text
              .size(22)
              .color(primaryText)
              .fontFamily(gilroyBold)
              .make(),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Image.asset(
                icFilter,
                width: 20,
                color: primaryText,
              ),
            ),
          ],
          centerTitle: true,
        ),
        endDrawer: const Drawer(backgroundColor: Colors.amber),
        body: EasyRefresh(
            controller: seeAllVM.controller,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onLoad: () {
              seeAllVM.onLoadMore();
            },
            onRefresh: () {
              seeAllVM.onRefresh();
            },
            child: Obx(
              () => GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: seeAllVM.type != 4
                      ? const EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                  gridDelegate: seeAllVM.type != 4
                      ? const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 250)
                      : const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.95,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                  itemCount: seeAllVM.type != 4
                      ? seeAllVM.arrayProduct.length
                      : seeAllVM.arrayCategory.length,
                  itemBuilder: ((context, index) {
                    return seeAllVM.type != 4
                        ? ProductCell(
                            productModel: seeAllVM.arrayProduct[index],
                            onPressed: () {},
                            onCart: () {},
                            icon: widget.type == 1
                                ? icpriceTag
                                : widget.type == 2
                                    ? icFire
                                    : widget.type == 3
                                        ? icfavourireProduct
                                        : widget.type == 4
                                            ? null
                                            : icNewProduct,
                          )
                        : ExploreCell(
                            categoryModel: seeAllVM.arrayCategory[index],
                            onPressed: () {});
                  })),
            )));
  }
}
