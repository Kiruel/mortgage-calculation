import 'package:flutter/material.dart';
import 'package:mortgage_flutter/widgets/mortgage_widget_calculator.dart';
import 'package:mortgage_flutter/widgets/result_mortage_calculator.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MortgageWidgetCalculator(),
        ResultMortageCalculator(),
      ],
    );
  }
}
