import 'package:flutter/material.dart';

class HelepCenter extends StatelessWidget {
  const HelepCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
            'data Center',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}
