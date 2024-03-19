import 'package:grocerygo/utility/export.dart';

class CartMain extends StatefulWidget {
  const CartMain({super.key});

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: "Giỏ Hàng Của Bạn".text.fontFamily(gilroyBold).size(22).color(primaryText).make(),
          centerTitle: true,
          bottom: const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              child: Text(
                "Tất Cả",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: gilroyBold),
              ),
            ),
            Tab(
              child: Text(
                "Yêu Thích",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: gilroyBold),
              ),
            ),
            Tab(
              child: Text(
                "Đã Mua",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: gilroyBold),
              ),
            )
          ]),
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.amber,
          )
        ]),
      ),
    );
  }
}
