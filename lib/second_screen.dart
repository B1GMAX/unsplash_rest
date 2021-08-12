import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String url;
  final String description;

  SecondScreen({
    required this.url,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Image.network(
        url,
        height: double.infinity,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
