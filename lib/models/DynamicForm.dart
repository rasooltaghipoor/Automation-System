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
  String formTypeId;
  String formName_E;
  String formName_F;
  String itemsType;

  List<FormItem> items;

  DynamicFormModel(this.formID, this.formTypeId, this.formName_E,
      this.formName_F, this.itemsType, this.items);

  factory DynamicFormModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'][0] as List;
    List<FormItem> itemList = list.map((i) => FormItem.fromMap(i)).toList();
    return DynamicFormModel(
      parsedJson['formid'],
      parsedJson['formTypeid'],
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
  dynamic dataType;
  String fill;
  FormItem(
      this.control, this.controlName, this.title, this.dataType, this.fill);

  factory FormItem.fromMap(Map<String, dynamic> parsedJson) {
    if (parsedJson['Control'] == 'textbox') {
      return FormItem(
        parsedJson['Control'],
        parsedJson['ControlName'],
        parsedJson['title'],
        parsedJson['datatype'],
        parsedJson['Fill'],
      );
    } else if (parsedJson['Control'] == 'listbox') {
      var list = parsedJson['datatype'] as List;
      List<ListItem> itemList = list.map((i) => ListItem.fromMap(i)).toList();
      return FormItem(
        parsedJson['Control'],
        parsedJson['ControlName'],
        parsedJson['title'],
        itemList,
        parsedJson['Fill'],
      );
    } else
      return FormItem('', '', '', '', '');
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
