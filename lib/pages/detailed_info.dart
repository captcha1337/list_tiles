import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListTileDetails extends StatefulWidget {
  const ListTileDetails({super.key});

  @override
  State<ListTileDetails> createState() => _ListTileDetailsState();
}

class _ListTileDetailsState extends State<ListTileDetails> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final officeId = ModalRoute.of(context)!.settings.arguments as int;
    DatabaseReference officeRef = FirebaseDatabase.instance.ref('offices/$officeId');

    editOfficeName() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'name': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    editOfficeAddress() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'address': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    editOfficeId() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'id': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    editOfficeLatitude() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'lat': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    editOfficeLongitude() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'lng': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    editOfficeRegion() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: _textFieldController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await officeRef.update({
                      'region': _textFieldController.text,
                    });
                    _textFieldController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: StreamBuilder(
        stream: officeRef.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            Map<dynamic, dynamic> office = snapshot.data?.snapshot.value as dynamic;

            return SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Image.network(
                          office['image'],
                          scale: 0.5,
                        ),
                      ),
                      Card(
                        child: ListTile(
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editOfficeName();
                            },
                          ),
                          title: Text('Office name: ${office['name']}',
                              style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editOfficeAddress();
                            },
                          ),
                          title: Text('Office address: ${office['address']}',
                              style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        ),
                      ),
                      Card(
                        child: ListTile(
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                editOfficeId();
                              },
                            ),
                            title: Text('Office id: ${office['id']}',
                                style: const TextStyle(fontSize: 20), textAlign: TextAlign.center)),
                      ),
                      Card(
                          child: ListTile(
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  editOfficeLatitude();
                                },
                              ),
                              title: Text('Office latitude: ${office['lat']}',
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center))),
                      Card(
                          child: ListTile(
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  editOfficeLongitude();
                                },
                              ),
                              title: Text('Office longitude: ${office['lng']}',
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center))),
                      Card(
                          child: ListTile(
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  editOfficeRegion();
                                },
                              ),
                              title: Text('Office region: ${office['region']}',
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center))),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
