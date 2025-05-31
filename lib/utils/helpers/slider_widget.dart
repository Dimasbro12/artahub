import 'package:flutter/material.dart';
import '../common_widgets/custom_sliderwidget.dart';

class SliderWidget extends StatelessWidget {
  final double value;
  final Function(double) onChanged;
  final int min;
  final int max;

  const SliderWidget({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: CustomSliderThumbRect(
          thumbRadius: 10.0,
          thumbHeight: 20.0,
          min: min,
          max: max,
        ),
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.white,
      ),
      child: Slider(
        value: value,
        min: min.toDouble(),
        max: max.toDouble(),
        onChanged: onChanged,
      ),
    );
  }
}
