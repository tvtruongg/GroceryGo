
class CategoryModel {
  int? categoryId;
  String? caName;
  String? caImage;
  String? caColor;

  CategoryModel({this.categoryId, this.caName, this.caImage, this.caColor});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    caName = json['ca_name'];
    caImage = json['ca_image'];
    caColor = json['ca_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ca_name'] = caName;
    data['ca_image'] = caImage;
    data['ca_color'] = caColor;
    return data;
  }
}
