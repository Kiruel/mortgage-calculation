import 'package:flutter/material.dart';
import 'package:mortgage_flutter/theme.dart';
import 'package:mortgage_flutter/widgets/custom_list_tile.dart';

enum MortgageTermType { repayment, interestOnly }

class TypeSelectorCustom extends StatefulWidget {
  const TypeSelectorCustom({
    super.key,
    this.defaultMortgageTermType,
    this.onSelectedMortgage,
    this.error,
  });
  final MortgageTermType? defaultMortgageTermType;
  final void Function(MortgageTermType mortgageTermType)? onSelectedMortgage;
  final String? error;

  @override
  State<TypeSelectorCustom> createState() => _TypeSelectorCustomState();
}

class _TypeSelectorCustomState extends State<TypeSelectorCustom> {
  MortgageTermType? _mortgageType;
  Color? hoverColorBorder;

  @override
  void initState() {
    _mortgageType = widget.defaultMortgageTermType;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypeSelectorCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    _mortgageType = widget.defaultMortgageTermType;
  }

  void onSelectedRadio(MortgageTermType? value) {
    setState(() {
      _mortgageType = value;
    });
    if (widget.onSelectedMortgage != null && _mortgageType != null) {
      widget.onSelectedMortgage?.call(_mortgageType!);
    }
  }

  String getTitleType(MortgageTermType type) {
    switch (type) {
      case MortgageTermType.interestOnly:
        return 'Interest Only';
      case MortgageTermType.repayment:
        return 'Repayment';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mortgage Type',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: mDarkBlueColor.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 4,
          ),
          ...MortgageTermType.values.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CustomListTile(
                text: getTitleType(e),
                tileColor: _mortgageType == e
                    ? limeColor.withOpacity(0.2)
                    : Colors.transparent,
                borderColor: _mortgageType == e ? limeColor : mDarkBlueColor,
                onTap: () => onSelectedRadio(e),
                currentValue: e,
                defaultValue: _mortgageType,
                onChanged: onSelectedRadio,
              ),
            ),
          ),
          if (widget.error != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.error!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: redColor),
            )
          ]
        ],
      ),
    );
  }
}
