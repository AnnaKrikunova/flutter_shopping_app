class MyCategory {
  int categoryId;
  String categoryName;
  String categoryImg;
  List<SubCategories> subCategories;

  MyCategory(
      {this.categoryId,
        this.categoryName,
        this.categoryImg,
        this.subCategories});

  MyCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryImg = json['categoryImg'];
    if (json['subCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryImg'] = this.categoryImg;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int subCategoryId;
  String subCategoryName;
  int categoryId;

  SubCategories(
      {this.subCategoryId,
        this.subCategoryName,
        this.categoryId,
      });

  SubCategories.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    data['categoryId'] = this.categoryId;
    return data;
  }
}