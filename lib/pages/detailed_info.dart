import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'list_item_card.dart';

class ListTileDetails extends StatefulWidget {
  const ListTileDetails({super.key});

  @override
  State<ListTileDetails> createState() => _ListTileDetailsState();
}

class _ListTileDetailsState extends State<ListTileDetails> {
  @override
  Widget build(BuildContext context) {
    final officeId = ModalRoute.of(context)!.settings.arguments as int;
    DatabaseReference officeRef = FirebaseDatabase.instance.ref('offices/$officeId');

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: StreamBuilder(
        stream: officeRef.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(snapshot.data.toString());
          }

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
                    // DetailedInfoListItem(label, fieldKey, value)
                    ListItemCard('Office Name', 'name', office['name'], officeRef),
                    ListItemCard('Office Address', 'address', office['address'], officeRef),
                    ListItemCard('Office ID', 'id', office['id'], officeRef),
                    ListItemCard('Office Latitude', 'lat', office['lat'], officeRef),
                    ListItemCard('Office Longtitude', 'lng', office['lng'], officeRef),
                    ListItemCard('Office Region', 'region', office['region'], officeRef),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
