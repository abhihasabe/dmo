// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.

import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const ShadowCard({
    super.key,
    required this.child,
    this.borderRadius = 5,
    this.color = Colors.white,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: margin,
      shadowColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: child,
      ),
      /*padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.black.withOpacity(0.04), offset: Offset(0, 0)),
        ],
      ),*/
    );
  }
}
