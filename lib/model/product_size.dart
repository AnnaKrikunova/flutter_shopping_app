import 'package:flutter_shopping_app/model/size.dart';

class ProductSizes {
  int sizeId;
  int productId;
  int number;
  MySize size;

  ProductSizes({this.sizeId, this.productId, this.number, this.size});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    productId = json['productId'];
    number = json['number'];
    size = json['size'] != null ? new MySize.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sizeId'] = this.sizeId;
    data['productId'] = this.productId;
    data['number'] = this.number;
    if (this.size != null) {
      data['size'] = this.size.toJson();
    }
    return data;
  }
}