import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  const CustomLoader({super.key, this.size = 50.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(strokeWidth: 3.0),
      ),
    );
  }
}