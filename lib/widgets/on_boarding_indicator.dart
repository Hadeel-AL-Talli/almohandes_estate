import 'package:flutter/material.dart';

class OnBoardingIndicator extends StatelessWidget {
  final double marginEnd;
  final bool selected;

  OnBoardingIndicator({
    required this.selected,
    this.marginEnd = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 10,
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsetsDirectional.only(end: marginEnd),
    );
  }
}
