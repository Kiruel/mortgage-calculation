import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mortgage_flutter/mortgage_controller.dart';
import 'package:mortgage_flutter/theme.dart';
import 'package:mortgage_flutter/utils/responsive_extension.dart';
import 'package:mortgage_flutter/widgets/empty_container.dart';

class ResultMortageCalculator extends ConsumerWidget {
  const ResultMortageCalculator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.isMobile()
            ? null
            : const BorderRadius.only(
                bottomLeft: Radius.circular(58),
                bottomRight: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
        color: mDarkBlueColor,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Builder(builder: (context) {
          return ref.watch(mortgageControllerProvider).currentTotal == 0
              ? const EmptyContainer()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: context.isMobile()
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your results',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your results are show below based on the information you provided. To adjust the result, edit the form and click "calculate repayments" again.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: context.isMobile() ? 262 : 300,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16,
                            decoration: BoxDecoration(
                              color: limeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(14, 37, 49, 1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: mDarkBlueColor,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your monthly repayments',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Text(
                                        '\$${ref.watch(mortgageControllerProvider.select((value) => value.currentTotal.toString()))}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: limeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 42,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Divider(
                                        color: Colors.white.withOpacity(0.3)),
                                    const SizedBox(height: 24),
                                    Text(
                                      "Total you'll repay over the term",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${ref.watch(
                                        mortgageControllerProvider.select(
                                            (value) => value.totalRepayments
                                                .toString()),
                                      )}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
