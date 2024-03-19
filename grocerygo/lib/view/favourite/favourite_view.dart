import 'package:grocerygo/common/custom_button.dart';
import 'package:grocerygo/common/favourite_row.dart';
import 'package:grocerygo/controllers/favourite_view_model.dart';
import 'package:grocerygo/utility/export.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {

  final favoriteVM = Get.find<FavoriteViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: "Yêu Thích".text.size(20).fontFamily(gilroyBold).color(primaryText).make(),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
              itemBuilder: (context, index) {
                return FavoriteRow(
                  productModel: favoriteVM.favouriteArray[index],
                  onPressed: () {},
                );
              }),
          10.heightBox,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                  child: CustomButton(
                    width: context.screenWidth,
                    height: 60,
                    color: const Color(0xffF2F3F2),
                    title: "Thêm Tất Cả Vào Giỏ Hàng",
                    textColor: primary,
                    radius: 20,
                    size: 20,
                    onPress: () {
                    },
                    icon: icLogout,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
