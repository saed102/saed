class CateModel {
  String? categoryName;

  String? image;



  CateModel({
    required this.image,
    required this.categoryName,
  });

  CateModel.fromJson(Map<String, dynamic> json) {
    categoryName = json["categoryName"];
    image = json["image"];

  }

  Map<String, dynamic> toMap() {
    return {
      "categoryName": categoryName,
      "image": image,
    };
  }
}
