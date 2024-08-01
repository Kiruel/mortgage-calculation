import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortgage_flutter/mortgage_controller.dart';
import 'package:mortgage_flutter/theme.dart';
import 'package:mortgage_flutter/utils/numerical_range_formater.dart';
import 'package:mortgage_flutter/utils/responsive_extension.dart';
import 'package:mortgage_flutter/widgets/text_field_custom.dart';
import 'package:mortgage_flutter/widgets/type_selector_custom.dart';

class MortgageWidgetCalculator extends HookConsumerWidget {
  const MortgageWidgetCalculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mortgageAmountTextController = useTextEditingController();
    final mortgageTermTextController = useTextEditingController();
    final interestRateTextController = useTextEditingController();

    void clearInput() {
      mortgageAmountTextController.text = '';
      mortgageTermTextController.text = '';
      interestRateTextController.text = '';
      ref.invalidate(mortgageControllerProvider);
    }

    List<Widget> buildTitle({Widget? spacing}) => [
          SelectableText(
            'Mortgage Calculator',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (spacing != null) spacing,
          InkWell(
            onTap: clearInput,
            child: Text(
              'Clear All',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                shadows: [
                  Shadow(
                    color: mDarkBlueColor.withOpacity(0.4),
                    offset: const Offset(0, -3),
                  )
                ],
                fontWeight: FontWeight.bold,
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: mDarkBlueColor.withOpacity(0.4),
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          )
        ];

    Widget buildTerm() => TextFieldCustom(
          title: 'Mortgage Term',
          suffixText: 'years',
          controller: mortgageTermTextController,
          onChanged: (value) => ref
              .read(mortgageControllerProvider.notifier)
              .setMortgageTerm(value == '' ? 0 : double.parse(value)),
          inputFormaters: [
            FilteringTextInputFormatter.digitsOnly,
            NumericalRangeFormatter(min: 0, max: 30),
          ],
          keyboardType: TextInputType.number,
          error: ref.watch(mortgageControllerProvider
                  .select((value) => value.isTermError ?? false))
              ? 'This field is required'
              : null,
        );

    Widget buildRate() => TextFieldCustom(
          title: 'Interest Rate',
          controller: interestRateTextController,
          suffixText: '%',
          onChanged: (value) => ref
              .read(mortgageControllerProvider.notifier)
              .setInterestRate(value == '' ? 0 : double.parse(value)),
          inputFormaters: [
            // FilteringTextInputFormatter.allow(
            //   RegExp(r'^\d+\.?\d{0,2}'),
            // ),
            NumericalRangeFormatter(min: 0, max: 30),
          ],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          error: ref.watch(mortgageControllerProvider
                  .select((value) => value.isInterestRateError ?? false))
              ? 'This field is required'
              : null,
        );

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.isMobile()
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildTitle(
                      spacing: const SizedBox(
                    height: 8,
                  )),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildTitle(),
                ),
          const SizedBox(
            height: 24,
          ),
          TextFieldCustom(
            title: 'Mortgage Amount',
            prefixText: '\$',
            controller: mortgageAmountTextController,
            error: ref.watch(mortgageControllerProvider
                    .select((value) => value.isAmountError ?? false))
                ? 'This field is required'
                : null,
            onChanged: (value) {
              ref.read(mortgageControllerProvider.notifier).setMortgageAmount(
                    value == ''
                        ? 0
                        : double.parse(value.replaceAll(RegExp(r"\s+"), "")),
                  );
            },
            inputFormaters: [
              CurrencyTextInputFormatter.currency(
                locale: 'fr',
                enableNegative: false,
                decimalDigits: 0,
                symbol: '',
                maxValue: 10000000,
              ),
            ],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 16,
          ),
          if (context.isMobile()) ...[
            buildTerm(),
            const SizedBox(height: 16),
            buildRate(),
          ] else
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: buildTerm(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: buildRate(),
                )
              ],
            ),
          const SizedBox(height: 16),
          TypeSelectorCustom(
            error: ref.watch(mortgageControllerProvider
                    .select((value) => value.isTermTypeError ?? false))
                ? 'This field is required'
                : null,
            defaultMortgageTermType: ref.watch(
              mortgageControllerProvider
                  .select((value) => value.mortgageTermType),
            ),
            onSelectedMortgage: (mortgageTermType) => ref
                .read(mortgageControllerProvider.notifier)
                .setMortgageTermType(mortgageTermType),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: context.isMobile() ? double.infinity : 250,
            height: 46,
            child: MaterialButton(
              color: limeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              hoverColor: const Color.fromRGBO(235, 238, 151, 1),
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              onPressed: ref
                  .read(mortgageControllerProvider.notifier)
                  .calculateMortgage,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icon-calculator.svg'),
                  const SizedBox(width: 8),
                  Text(
                    'Calculate Repayments',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: mDarkBlueColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
