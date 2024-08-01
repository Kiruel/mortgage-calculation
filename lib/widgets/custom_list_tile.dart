import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mortgage_flutter/theme.dart';
import 'package:mortgage_flutter/widgets/type_selector_custom.dart';

class CustomListTile extends HookWidget {
  const CustomListTile({
    super.key,
    required this.tileColor,
    required this.borderColor,
    required this.onTap,
    required this.text,
    required this.currentValue,
    this.defaultValue,
    required this.onChanged,
  });

  final Color tileColor;
  final Color borderColor;
  final VoidCallback onTap;
  final String text;
  final MortgageTermType currentValue;
  final MortgageTermType? defaultValue;
  final void Function(MortgageTermType? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final isHover = useState(false);

    return MouseRegion(
      onEnter: (value) {
        isHover.value = true;
      },
      onExit: (value) {
        isHover.value = false;
      },
      child: ListTile(
        hoverColor: Colors.transparent,
        selectedColor: limeColor,
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isHover.value ? limeColor : borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        onTap: onTap,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: mDarkBlueColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: Radio<MortgageTermType>(
          value: currentValue,
          activeColor: limeColor,
          groupValue: defaultValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
