class BuyItemModel {
  String type;
  String description;
  String filePath;
  List<ItemData> items;
  BuyItemModel(this.type, this.description, this.filePath, this.items);

  Map toJson() {
    List<Map> tags = this.items.map((i) => i.toJson()).toList();
    return {
      'type': type,
      'description': description,
      'filePath': filePath,
      'items': items
    };
  }
}

class ItemData {
  String title;
  int quantity;
  String quantityType;
  int estimatedPrice;
  String description;
  ItemData(this.title, this.quantity, this.quantityType, this.estimatedPrice,
      this.description);
  Map toJson() => {
        'title': title,
        'quantity': quantity,
        'quantityType': quantityType,
        'estimatedPrice': estimatedPrice,
        'description': description,
      };

  factory ItemData.fromMap(Map<String, dynamic> parsedJson) {
    return ItemData(
      parsedJson['title'],
      parsedJson['quantity'],
      parsedJson['quantitytype'],
      parsedJson['estimatedprice'],
      parsedJson['description'],
    );
  }
}
