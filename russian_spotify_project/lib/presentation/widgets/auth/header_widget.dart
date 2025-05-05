import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Image.asset(
          "assets/icons/spotify.png",
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
