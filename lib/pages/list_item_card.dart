import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard(this.label, this.fieldKey, this.value, this.ref);

  final String label;
  final String fieldKey;
  final dynamic value;
  final dynamic ref;
  late TextEditingController _textFieldController;

  @override
  Widget build(BuildContext context) {
    showEditItemDialog(fieldKey, initialValue) async {
      final Map<String, dynamic> payload = {};

      _textFieldController = TextEditingController(text: initialValue);

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextFormField(
                maxLines: null,
                autofocus: true,
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    payload[fieldKey] = ['lat', 'lng'].contains(fieldKey)
                        ? double.parse(_textFieldController.text)
                        : _textFieldController.text;

                    await ref.update(payload);
                    _textFieldController.clear();

                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    return Card(
      child: ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showEditItemDialog(
                  fieldKey, ['lat', 'lng'].contains(fieldKey) ? value.toString() : value);
            },
          ),
          title: Text('${label}: ${value}',
              style: const TextStyle(fontSize: 20), textAlign: TextAlign.center)),
    );
  }
}
