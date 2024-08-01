import 'package:flutter/material.dart';
import 'package:mortgage_flutter/widgets/mortgage_widget_calculator.dart';
import 'package:mortgage_flutter/widgets/result_mortage_calculator.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 900,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: const Wrap(
            children: [
              IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MortgageWidgetCalculator(),
                      ),
                      Expanded(
                        child: ResultMortageCalculator(),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
