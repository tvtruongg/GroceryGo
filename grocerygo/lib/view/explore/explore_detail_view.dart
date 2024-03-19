import 'package:grocerygo/common/product_cell.dart';
import 'package:grocerygo/common/product_shimmer.dart';
import 'package:grocerygo/controllers/explore_details_view_model.dart';
import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/model/product_model.dart';
import 'package:grocerygo/utility/export.dart';

class ExploreDetailView extends StatefulWidget {
  final CategoryModel categoryModel;
  const ExploreDetailView({super.key, required this.categoryModel});

  @override
  State<ExploreDetailView> createState() => _ExploreDetailViewState();
}

class _ExploreDetailViewState extends State<ExploreDetailView> {
  late ExploreDetailsViewModel exploreDetailsVM;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    exploreDetailsVM = Get.put(ExploreDetailsViewModel(widget.categoryModel));
  }

  @override
  void dispose() {
    Get.delete<ExploreDetailsViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const Drawer(backgroundColor: Colors.amber),
        body: EasyRefresh(
            controller: exploreDetailsVM.easyRefreshController,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onLoad: () {
              exploreDetailsVM.onLoadMore();
            },
            onRefresh: () {
              exploreDetailsVM.onRefresh();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  snap: false,
                  floating: false,
                  elevation: 8,
                  expandedHeight: context.screenHeight * 0.28,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        title: constraints.biggest.height <
                                context.screenHeight * 0.15
                            ? widget.categoryModel.caName!.text
                                .size(22)
                                .color(primaryText)
                                .fontFamily(gilroyBold)
                                .make()
                            : null,
                        background: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Color(int.parse(
                                    '0xFF${widget.categoryModel.caColor!}'))
                                .withOpacity(0.4),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.categoryModel.caImage ?? "",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
                        icBack,
                        width: 20,
                        color: primaryText,
                      )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: Image.asset(
                        icFilter,
                        width: 20,
                        color: primaryText,
                      ), // Thay đổi icon thành icon mong muốn
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    height: context.screenHeight * 0.035,
                    child: Column(
                      children: [
                        widget.categoryModel.caName!.text
                            .size(22)
                            .color(primaryText)
                            .fontFamily(gilroyBold)
                            .make(),
                        5.heightBox,
                        const Divider(
                          color: Color.fromARGB(255, 170, 170, 169),
                          height: 2,
                          indent: 30,
                          endIndent: 30,
                        )
                      ],
                    ),
                  ),
                )),
                StreamBuilder<List<ProductModel>>(
                  stream: exploreDetailsVM.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      EasyLoading.show(status: "loading ...");
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 15,
                                  mainAxisExtent: 250),
                          itemCount: 2,
                          itemBuilder: ((context, index) {
                            return const ProductShimmer();
                          }),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        EasyLoading.dismiss();
                        return Container();
                      } else if (snapshot.hasData) {
                        EasyLoading.dismiss();
                        var data = snapshot.data!;
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          sliver: SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    mainAxisExtent: 250),
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              return ProductCell(
                                productModel: data[index],
                                onPressed: () {},
                                onCart: () {},
                              );
                            }),
                          ),
                        );
                      } else {
                        EasyLoading.dismiss();
                        return Container();
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              ],
            )));
  }
}
