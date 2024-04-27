import 'package:flutter/material.dart';

class FittedDisplay extends StatelessWidget {
  final String text;
  const FittedDisplay({super.key, this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 25.0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    text,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
