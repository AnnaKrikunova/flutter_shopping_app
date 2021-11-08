import 'package:flutter_shopping_app/model/product_size.dart';

class Product {
  int productId;
  String productName;
  String productShortDescription;
  String productDescription;
  double productOldPrice;
  double productNewPrice;
  bool productIsSale;
  Null productSaleText;
  String productSubText;
  int productOrderNumber;
  String productCreateDate;
  String productCode;
  int subCategoryId;
  List<ProductImages> productImages;
  List<ProductSizes> productSizes;

  Product(
      {this.productId,
        this.productName,
        this.productShortDescription,
        this.productDescription,
        this.productOldPrice,
        this.productNewPrice,
        this.productIsSale,
        this.productSaleText,
        this.productSubText,
        this.productOrderNumber,
        this.productCreateDate,
        this.productCode,
        this.subCategoryId,
        this.productImages,});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] as int;
    productName = json['productName'];
    productShortDescription = json['productShortDescription'];
    productDescription = json['productDescription'];
    productOldPrice = json['productOldPrice'] as double;
    productNewPrice = json['productNewPrice'] as double;
    productIsSale = json['productIsSale'];
    productSaleText = json['productSaleText'];
    productSubText = json['productSubText'];
    productOrderNumber = json['productOrderNumber'] as int;
    productCreateDate = json['productCreateDate'];
    productCode = json['productCode'];
    subCategoryId = json['subCategoryId'] as int;

    if (json['productImages'] != null) {
      productImages = new List<ProductImages>();
      json['productImages'].forEach((v) {
        productImages.add(new ProductImages.fromJson(v));
      });
    }

    if (json['productSizes'] != null) {
      productSizes = new List<ProductSizes>();
      json['productSizes'].forEach((v) {
        productSizes.add(new ProductSizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productShortDescription'] = this.productShortDescription;
    data['productDescription'] = this.productDescription;
    data['productOldPrice'] = this.productOldPrice;
    data['productNewPrice'] = this.productNewPrice;
    data['productIsSale'] = this.productIsSale;
    data['productSaleText'] = this.productSaleText;
    data['productSubText'] = this.productSubText;
    data['productOrderNumber'] = this.productOrderNumber;
    data['productCreateDate'] = this.productCreateDate;
    data['productCode'] = this.productCode;
    data['subCategoryId'] = this.subCategoryId;

    if (this.productImages != null) {
      data['productImages'] =
          this.productImages.map((v) => v.toJson()).toList();
    }
    if (this.productSizes != null) {
      data['productSizes'] = this.productSizes.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ProductImages {
  int imgId;
  String imgUrl;
  int productId;

  ProductImages({this.imgId, this.imgUrl, this.productId});

  ProductImages.fromJson(Map<String, dynamic> json) {
    imgId = json['imgId'];
    imgUrl = json['imgUrl'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgId'] = this.imgId;
    data['imgUrl'] = this.imgUrl;
    data['productId'] = this.productId;
    return data;
  }
}