class ProductModel {
  int? productId;
  String? pName;
  String? pUnitName;
  String? pUnitValue;
  int? pPrice;
  int? sSold;
  int? isOfferActive;
  int? ofPrice;
  int? fCount;
  String? rRate;
  int? rCount;
  String? iImage;

  ProductModel(
      {this.productId,
      this.pName,
      this.pUnitName,
      this.pUnitValue,
      this.pPrice,
      this.sSold,
      this.isOfferActive,
      this.ofPrice,
      this.fCount,
      this.rRate,
      this.rCount,
      this.iImage});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    pName = json['p_name'];
    pUnitName = json['p_unit_name'];
    pUnitValue = json['p_unit_value'];
    pPrice = json['p_price'];
    sSold = json['s_sold'];
    isOfferActive = json['is_offer_active'];
    ofPrice = json['of_price'];
    fCount = json['f_count'];
    rRate = json['r_rate'];
    rCount = json['r_count'];
    iImage = json['i_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = productId;
    data['p_name'] = pName;
    data['p_unit_name'] = pUnitName;
    data['p_unit_value'] = pUnitValue;
    data['p_price'] = pPrice;
    data['s_sold'] = sSold;
    data['is_offer_active'] = isOfferActive;
    data['of_price'] = ofPrice;
    data['f_count'] = fCount;
    data['r_rate'] = rRate;
    data['r_count'] = rCount;
    data['i_image'] = iImage;
    return data;
  }
}
