import 'package:grocerygo/common/explore_cell.dart';
import 'package:grocerygo/common/explore_shimmer.dart';
import 'package:grocerygo/controllers/explore_view_model.dart';
import 'package:grocerygo/model/category_model.dart';
import 'package:grocerygo/utility/export.dart';
import 'package:grocerygo/view/explore/explore_detail_view.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final exploreVM = Get.put(ExploreViewModel());

  @override
  void dispose() {
    Get.delete<ExploreViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.heightBox,
          Expanded(
            child: FutureBuilder<List<CategoryModel>>(
              future: exploreVM.serviceCallList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  EasyLoading.show(status: "loading ...");
                  return GridView.count(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      crossAxisCount: 2,
                      childAspectRatio: 0.95,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: List.generate(
                        4,
                        (index) {
                          return const ExploreShimmer();
                        },
                      ));
                } else if (snapshot.hasError) {
                  EasyLoading.dismiss();
                  return Container();
                } else if (snapshot.hasData) {
                  EasyLoading.dismiss();
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.95,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return ExploreCell(
                        categoryModel: snapshot.data![index],
                        onPressed: () {
                          Get.to(
                              () => ExploreDetailView(
                                  categoryModel: snapshot.data![index]),
                              transition: Transition.cupertinoDialog);
                        },
                      );
                    }),
                  );
                } else {
                  EasyLoading.dismiss();
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
