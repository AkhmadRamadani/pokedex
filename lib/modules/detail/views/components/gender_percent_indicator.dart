
import 'package:flutter/material.dart';

class GenderPercentIndicator extends StatelessWidget {
  final double malePercent;
  final double femalePercent;

  const GenderPercentIndicator({
    super.key,
    required this.malePercent,
    required this.femalePercent,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      (malePercent + femalePercent).toStringAsFixed(1) == '100.0',
      'Total percentage must be 100%',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("GENDER", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Expanded(
                flex: (malePercent * 10).round(),
                child: Container(height: 10, color: Colors.blue),
              ),
              Expanded(
                flex: (femalePercent * 10).round(),
                child: Container(height: 10, color: Colors.pinkAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.male, size: 18),
                const SizedBox(width: 4),
                Text("${malePercent.toStringAsFixed(1).replaceAll('.', ',')}%"),
              ],
            ),
            Row(
              children: [
                Text(
                  "${femalePercent.toStringAsFixed(1).replaceAll('.', ',')}%",
                ),
                const SizedBox(width: 4),
                const Icon(Icons.female, size: 18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
