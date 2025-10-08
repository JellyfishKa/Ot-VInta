import 'package:flutter/material.dart';

// Этот виджет будет отображать плашку со статусом.
// Пока это просто заглушка.
class StatusPanel extends StatelessWidget {
  final String status; // Например, "В работе" или "Одобрено"

  const StatusPanel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Временно используем простой Chip.
    // Позже заменим на дизайн из Figma.
    return Chip(
      label: Text(status),
      backgroundColor: Colors.blueGrey.withOpacity(0.1),
    );
  }
}