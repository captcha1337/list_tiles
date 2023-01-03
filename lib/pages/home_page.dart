import 'package:flutter/material.dart';
import '../common/common_template.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTemplate(
      child: Column(
        children: [Image.network('https://picsum.photos/200')],
      ),
    );
  }
}
