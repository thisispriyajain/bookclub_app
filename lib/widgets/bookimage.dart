import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imageURL;

  const BookImage({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageURL,
          fit: BoxFit.cover,
          width: 100.0,
          height: 150.0,
        ),
      );
    }
}