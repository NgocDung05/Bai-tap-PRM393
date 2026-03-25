import 'package:flutter/material.dart';

// Tách nút bấm hành động ra thành 1 widget độc lập để tái sử dụng
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.grey.shade800),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey.shade800)),
      ],
    );
  }
}