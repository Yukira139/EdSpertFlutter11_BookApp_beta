import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class imageviewscreen extends StatelessWidget {
  const imageviewscreen({Key? key, required this.imageurl}) : super(key: key);
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Stack(children: [
        Image.network(imageurl),
        BackButton(),
      ],) ),
    );
  }
}