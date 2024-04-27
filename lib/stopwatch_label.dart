// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class StopwatchLabel extends StatelessWidget {
  int i;
  String label;
  final Function() prevStopwatchCallback,
      nextStopwatchCallback,
      deleteStopwatchCallback;
  final Function(String text) onChangedTextCallback;
  StopwatchLabel({
    super.key,
    this.i = 0,
    this.label = '',
    required this.prevStopwatchCallback,
    required this.nextStopwatchCallback,
    required this.deleteStopwatchCallback,
    required this.onChangedTextCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 30,
          ),
          Card(
            elevation: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => prevStopwatchCallback(),
                  ),
                ),
                Text('Stopwatch ${i + 1}'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => nextStopwatchCallback(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => deleteStopwatchCallback(),
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
