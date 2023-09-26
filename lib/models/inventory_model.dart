class InventoryModel {
  InventoryModel({
    required this.title,
    required this.codes,
  });

  InventoryModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      codes = json['codes'];

  String title;
  List<dynamic> codes;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'codes': codes,
    };
  }
}