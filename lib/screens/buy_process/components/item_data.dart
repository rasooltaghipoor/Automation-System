import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  TextEditingController product = TextEditingController();
  TextEditingController price = TextEditingController();

  ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 200,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: TextFormField(
                  controller: product,
                  decoration: const InputDecoration(
                      labelText: 'نام کالا', border: OutlineInputBorder()),
                ),
              ),
              Container(
                width: 100,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: TextFormField(
                  controller: price,
                  decoration: const InputDecoration(
                      labelText: 'قیمت', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
