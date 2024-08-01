import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mortgage_flutter/mortgage_controller.dart';
import 'package:mortgage_flutter/widgets/type_selector_custom.dart';

void main() {
  group('MortgageController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      addTearDown(container.dispose);
    });

    test('initial state is correct', () {
      final state = container.read(mortgageControllerProvider);

      expect(
          state,
          const MortgageState(
            mortgageAmount: 0,
            mortgageTerm: 0,
            interestRate: 0,
            montlyRepayments: 0,
            totalRepayments: 0,
            interestMontly: 0,
            currentTotal: 0,
            clearInput: false,
            mortgageTermType: null,
          ));
    });

    group('', () {
      setUp(() {
        final controller = container.read(mortgageControllerProvider.notifier);
        controller.setMortgageTermType(MortgageTermType.repayment);
      });

      test('setMortgageTermType sets the correct mortgage term type', () {
        container
            .read(mortgageControllerProvider.notifier)
            .setMortgageTermType(MortgageTermType.interestOnly);
        final state = container.read(mortgageControllerProvider);
        expect(state.mortgageTermType, MortgageTermType.interestOnly);
      });

      test('setMortgageAmount sets the correct mortgage amount', () {
        container
            .read(mortgageControllerProvider.notifier)
            .setMortgageAmount(200000);
        final state = container.read(mortgageControllerProvider);
        expect(state.mortgageAmount, 200000);
      });

      test('setInterestRate sets the correct interest rate', () {
        container
            .read(mortgageControllerProvider.notifier)
            .setInterestRate(0.05);
        final state = container.read(mortgageControllerProvider);
        expect(state.interestRate, 0.05);
      });

      test('setMortgageTerm sets the correct mortgage term', () {
        container.read(mortgageControllerProvider.notifier).setMortgageTerm(30);
        final state = container.read(mortgageControllerProvider);
        expect(state.mortgageTerm, 30);
      });

      test('calculateMortgage calculates the correct monthly repayments', () {
        final controller = container.read(mortgageControllerProvider.notifier);
        controller.setMortgageAmount(100000);
        controller.setInterestRate(6);
        controller.setMortgageTerm(5);

        const expectedRepayment = 1925.9;

        controller.calculateMortgage();
        final state = container.read(mortgageControllerProvider);
        expect(state.montlyRepayments, expectedRepayment);
      });

      test('calculate the total amount to pay', () {
        final controller = container.read(mortgageControllerProvider.notifier);
        controller.setMortgageAmount(100000);
        controller.setInterestRate(6);
        controller.setMortgageTerm(5);

        const expectedTotal = 115553.9;

        controller.calculateMortgage();
        final state = container.read(mortgageControllerProvider);
        expect(state.totalRepayments, expectedTotal);
      });

      test('calculate interest montly to pay', () {
        final controller = container.read(mortgageControllerProvider.notifier);
        controller.setMortgageAmount(100000);
        controller.setInterestRate(6);
        controller.setMortgageTerm(5);

        const expectedTotal = 259.23;

        controller.calculateMortgage();
        final state = container.read(mortgageControllerProvider);
        expect(state.interestMontly, expectedTotal);
      });
    });
  });
}
