import 'package:flutter/material.dart';
import 'dart:async';
import './stopwatch_display.dart';
import './stopwatch_label.dart';
import './stopwatch_label_vertical.dart';

class MainDisplay extends StatefulWidget {
  final bool isLandscape;
  const MainDisplay({super.key, required this.isLandscape});
  @override
  State<MainDisplay> createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  var _stopwatch = [];
  late Timer timer;
  List<String> _hours = [],
      _minutes = [],
      _seconds = [],
      _millis = [],
      _label = [];
  var i = -1;
  @override
  void initState() {
    super.initState();
    _newStopwatch();
    _startStopwatch();
    _stopStopwatch();
  }

  void _toggleStopwatch() {
    if (_stopwatch[i].isRunning) {
      _stopStopwatch();
      setState(() {});
    } else {
      _startStopwatch();
    }
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch[i].start();
    });
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        _hours[i] = (_stopwatch[i].elapsed.inHours).toString().padLeft(2, '0');
        _minutes[i] = (_stopwatch[i].elapsed.inMinutes -
                60 * _stopwatch[i].elapsed.inHours)
            .toString()
            .padLeft(2, '0');
        _seconds[i] = (_stopwatch[i].elapsed.inSeconds -
                60 * _stopwatch[i].elapsed.inMinutes)
            .toString()
            .padLeft(2, '0');
        _millis[i] = (_stopwatch[i].elapsed.inMilliseconds -
                1000 * _stopwatch[i].elapsed.inSeconds)
            .toString()
            .padLeft(3, '0');
      });
    });
  }

  void _stopStopwatch() {
    if (_stopwatch[i].isRunning) {
      _stopwatch[i].stop();
      timer.cancel();
    }
  }

  void _resetStopwatch() {
    _stopwatch[i].reset();
    setState(() {
      _hours[i] = '00';
      _minutes[i] = '00';
      _seconds[i] = '00';
      _millis[i] = '000';
    });
  }

  void _newStopwatch() {
    if (i >= 0) _stopStopwatch();
    _hours.add('00');
    _minutes.add('00');
    _seconds.add('00');
    _millis.add('000');
    _label.add('');
    i = _stopwatch.length;
    _stopwatch.add(Stopwatch());
    setState(() {});
  }

  void _prevStopwatch() {
    if (i > 0) {
      _stopStopwatch();
      setState(() {
        i--;
      });
    }
  }

  void _nextStopwatch() {
    if (i < _stopwatch.length - 1) {
      _stopStopwatch();
      setState(() {
        i++;
      });
    }
  }

  void _deleteStopwatch() {
    _hours.removeAt(i);
    _minutes.removeAt(i);
    _seconds.removeAt(i);
    _millis.removeAt(i);
    _stopwatch.removeAt(i);
    _label.removeAt(i);
    i--;
    if (i < 0) {
      if (_stopwatch.isNotEmpty) {
        i = 0;
      } else {
        _newStopwatch();
      }
    }
    setState(() {});
  }

  void _onChangedText(String text) {
    setState(() {
      _label[i] = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLandscape) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StopwatchLabelVertical(
            i: i,
            // label: _label[i],
            prevStopwatchCallback: () => _prevStopwatch(),
            nextStopwatchCallback: () => _nextStopwatch(),
            deleteStopwatchCallback: () => _deleteStopwatch(),
            onChangedTextCallback: (value) => _onChangedText(value),
          ),
          Expanded(
            child: FittedDisplay(
              text: '${_hours[i]}:${_minutes[i]}:${_seconds[i]}.${_millis[i]}',
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => _newStopwatch(),
                  tooltip: 'New Stopwatch',
                  child: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 85.0,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FloatingActionButton(
                      onPressed: () => _toggleStopwatch(),
                      tooltip: _stopwatch[i].isRunning ? 'Stop' : 'Start',
                      child: _stopwatch[i].isRunning
                          ? const Icon(Icons.stop_rounded)
                          : const Icon(Icons.play_arrow_rounded),
                    ), // START/STOP
                  ),
                ), // NEW STOPWATCH
                FloatingActionButton(
                  onPressed: () => _resetStopwatch(),
                  tooltip: 'Reset',
                  child: const Icon(Icons.replay),
                ), // RESET
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StopwatchLabel(
            i: i,
            label: _label[i],
            prevStopwatchCallback: () => _prevStopwatch(),
            nextStopwatchCallback: () => _nextStopwatch(),
            deleteStopwatchCallback: () => _deleteStopwatch(),
            onChangedTextCallback: (value) => _onChangedText(value),
          ),
          Expanded(
            child: FittedDisplay(
              text: '${_hours[i]}:${_minutes[i]}:${_seconds[i]}.${_millis[i]}',
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => _newStopwatch(),
                  tooltip: 'New Stopwatch',
                  child: const Icon(Icons.add),
                ),
                // START/STOP
                SizedBox(
                  height: 85.0,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FloatingActionButton(
                      onPressed: () => _toggleStopwatch(),
                      tooltip: _stopwatch[i].isRunning ? 'Stop' : 'Start',
                      child: _stopwatch[i].isRunning
                          ? const Icon(Icons.stop_rounded)
                          : const Icon(Icons.play_arrow_rounded),
                    ),
                  ),
                ), // NEW STOPWATCH
                FloatingActionButton(
                  onPressed: () => _resetStopwatch(),
                  tooltip: 'Reset',
                  child: const Icon(Icons.replay),
                ), // RESET
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
