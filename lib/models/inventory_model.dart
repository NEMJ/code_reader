class InventoryModel {
  InventoryModel({
    required this.title,
    required this.codes,
    this.inventoryClosed = false,
  });

  InventoryModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      codes = json['codes'],
      inventoryClosed = json['inventoryClosed'];

  String title;
  List<dynamic> codes;
  bool inventoryClosed;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'codes': codes,
      'inventoryClosed': inventoryClosed
    };
  }
}