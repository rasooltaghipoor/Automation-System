class FullDynamicForm {
  List<DynamicFormModel> forms;
  List<ListBoxItems> listBoxItems;

  FullDynamicForm(this.forms, this.listBoxItems);

  factory FullDynamicForm.fromMap(Map<String, dynamic> parsedJson) {
    var form = parsedJson['form'] as List;
    List<DynamicFormModel> formlist =
        form.map((i) => DynamicFormModel.fromMap(i)).toList();

    var listbox = parsedJson['listbox'] as List;
    List<ListBoxItems> listboxList =
        listbox.map((i) => ListBoxItems.fromMap(i)).toList();

    return FullDynamicForm(
      formlist,
      listboxList,
    );
  }
}

class DynamicFormModel {
  String formID;
  String formName_E;
  String formName_F;
  String itemsType;

  List<FormItem> items;

  DynamicFormModel(this.formID, this.formName_E, this.formName_F,
      this.itemsType, this.items);

  factory DynamicFormModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<FormItem> itemList = list.map((i) => FormItem.fromMap(i)).toList();
    return DynamicFormModel(
      parsedJson['formid'],
      parsedJson['formName_E'],
      parsedJson['formName_F'],
      parsedJson['itemsType'],
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

class ListBoxItems {
  String listboxType;
  List<ListItem> items;

  ListBoxItems(this.listboxType, this.items);

  factory ListBoxItems.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<ListItem> itemList = list.map((i) => ListItem.fromMap(i)).toList();
    return ListBoxItems(
      parsedJson['listboxtype'],
      itemList,
    );
  }
}

class ListItem {
  String id;
  String title;

  ListItem(this.id, this.title);

  factory ListItem.fromMap(Map<String, dynamic> parsedJson) {
    return ListItem(
      parsedJson['id'],
      parsedJson['title'],
    );
  }
}
