import 'package:flutter/material.dart';
import '../../../domain/entities/technology_entity.dart';

class TechnologyCard extends StatelessWidget {
  final TechnologyEntity technology;

  const TechnologyCard({super.key, required this.technology});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.black.withValues(alpha: 0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              technology.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            technology.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
