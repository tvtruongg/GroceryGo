import 'package:grocerygo/utility/export.dart';

class CustomSearchDelegate extends SearchDelegate {
  // deeemo data
  List<String> allData = ['thư', 'anh', 'yeu', 'qua', 'à'];

  @override
  String? get searchFieldLabel => "Bạn muốn tìm gì ...";

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: const TextStyle(
          fontSize: 16, // Thay đổi kích thước chữ trong ô tìm kiếm
          fontFamily: gilroyMedium, // Thay đổi font chữ trong ô tìm kiếm
          color: secondaryText, // Thay đổi màu chữ trong ô tìm kiếm
        ),
        fillColor: const Color.fromARGB(255, 238, 238, 238),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 0), // Thay đổi kích thước của ô tìm kiếm
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30.0),
        ),
      );

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
    
      color: Colors.black, fontSize: 16, fontFamily: gilroyMedium);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Xóak
    return [
      query.isNotEmpty
          ? IconButton(
              onPressed: () {
                query = '';
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            )
          : const SizedBox.shrink()
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Gợi ý
    List<String> array = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        // Chuyển về chữ thường: toLowerCase
        array.add(item);
      }
    }
    return Container(
      color: Colors.blue,
      child: ListView.builder(
        itemCount: array.length,
        itemBuilder: ((context, index) {
          var result = array[index];
          return ListTile(title: Text(result));
        }),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Gợi ý
    List<String> array = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        // Chuyển về chữ thường: toLowerCase
        array.add(item);
      }
    }
    return Container(
      color: Colors.blue,
      child: ListView.builder(
        itemCount: array.length,
        itemBuilder: ((context, index) {
          var result = array[index];
          return ListTile(title: Text(result));
        }),
      ),
    );
  }
}
