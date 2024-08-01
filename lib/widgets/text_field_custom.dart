import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mortgage_flutter/theme.dart';

class TextFieldCustom extends HookWidget {
  const TextFieldCustom({
    super.key,
    this.prefixText,
    this.suffixText,
    required this.title,
    this.onChanged,
    this.inputFormaters,
    this.keyboardType,
    this.controller,
    this.error,
  });

  final String? prefixText;
  final String? suffixText;
  final String title;
  final Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormaters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final isSelected = useState(false);
    final focusNode = useFocusNode();

    useEffect(() {
      focusNode.addListener(() {
        isSelected.value = focusNode.hasFocus;
      });
      return;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: mDarkBlueColor.withOpacity(0.5)),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: isSelected.value
                  ? limeColor
                  : mDarkBlueColor.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              if (prefixText != null)
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: error != null
                        ? redColor
                        : isSelected.value
                            ? limeColor
                            : mBlueColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        prefixText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: mDarkBlueColor.withOpacity(0.6),
                            ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      textAlignVertical: TextAlignVertical.top,
                      inputFormatters: inputFormaters,
                      keyboardType: keyboardType,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              if (suffixText != null)
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: error != null
                        ? redColor
                        : isSelected.value
                            ? limeColor
                            : mBlueColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        suffixText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected.value
                                  ? mDarkBlueColor
                                  : mDarkBlueColor.withOpacity(0.6),
                            ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: redColor),
          )
        ]
      ],
    );
  }
}
