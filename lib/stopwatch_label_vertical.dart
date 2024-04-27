// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class StopwatchLabelVertical extends StatelessWidget {
  int i;
  String label;
  final Function() prevStopwatchCallback,
      nextStopwatchCallback,
      deleteStopwatchCallback;
  final Function(String text) onChangedTextCallback;
  StopwatchLabelVertical({
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 30.0),
          Card(
            elevation: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward_rounded),
                    onPressed: () => nextStopwatchCallback(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Text('${i + 1}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_downward_rounded),
                    onPressed: () => prevStopwatchCallback(),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => deleteStopwatchCallback(),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
