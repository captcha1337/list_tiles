import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

import '../auth.dart';
import 'detailed_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
  }

  final DatabaseReference _ref = FirebaseDatabase.instance.ref('offices/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _signOutButton(),
      appBar: AppBar(
        title: Text('Welcome ${user?.email}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: _ref,
              itemBuilder: ((context, snapshot, animation, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: RouteSettings(
                                arguments: index,
                              ),
                              builder: ((context) => ListTileDetails())));
                    },
                    leading: Image.network(snapshot.child('image').value.toString()),
                    title: Text(snapshot.child('name').value.toString()),
                    trailing: const Icon(
                      Icons.arrow_circle_right_outlined,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return FloatingActionButton(
      onPressed: signOut,
      child: const Icon(
        Icons.logout,
      ),
    );
  }
}
