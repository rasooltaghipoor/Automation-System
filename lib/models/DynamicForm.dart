class DynamicFormModel {
  String formID;
  String formName_E;
  String formName_F;

  List<FormItem> items;

  DynamicFormModel(this.formID, this.formName_E, this.formName_F, this.items);

  factory DynamicFormModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<FormItem> itemList = list.map((i) => FormItem.fromMap(i)).toList();
    return DynamicFormModel(
      parsedJson['formid'],
      parsedJson['formName_E'],
      parsedJson['formName_F'],
      itemList,
    );
  }
}

class FormItem {
  String control;
  String controlName;
  String title;
  String dataType;
  FormItem(this.control, this.controlName, this.title, this.dataType);

  factory FormItem.fromMap(Map<String, dynamic> parsedJson) {
    return FormItem(
      parsedJson['Control'],
      parsedJson['ControlName'],
      parsedJson['title'],
      parsedJson['datatype'],
    );
  }
}
