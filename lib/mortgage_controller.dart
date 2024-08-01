import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mortgage_flutter/widgets/type_selector_custom.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:math' as math;

part 'mortgage_controller.g.dart';
part 'mortgage_controller.freezed.dart';

@freezed
class MortgageState with _$MortgageState {
  const factory MortgageState({
    required double mortgageAmount,
    required double mortgageTerm,
    required double interestRate,
    MortgageTermType? mortgageTermType,
    required double montlyRepayments,
    required double totalRepayments,
    required double interestMontly,
    required double currentTotal,
    required bool clearInput,
    bool? isAmountError,
    bool? isTermError,
    bool? isInterestRateError,
    bool? isTermTypeError,
  }) = _MortgageState;
}

@riverpod
class MortgageController extends _$MortgageController {
  @override
  MortgageState build() => initValue();

  MortgageState initValue() => const MortgageState(
        mortgageAmount: 0,
        mortgageTerm: 0,
        interestRate: 0,
        montlyRepayments: 0,
        totalRepayments: 0,
        interestMontly: 0,
        currentTotal: 0,
        clearInput: false,
        mortgageTermType: null,
      );

  void setMortgageTermType(MortgageTermType mortgageTermType) {
    state = state.copyWith(mortgageTermType: mortgageTermType);
    checkTermTypeError();
  }

  void setMortgageAmount(double value) {
    state = state.copyWith(mortgageAmount: value);
    checkErrorAmount();
  }

  void setInterestRate(double value) {
    state = state.copyWith(interestRate: value);
    checkErrorInterestRate();
  }

  void setMortgageTerm(double value) {
    state = state.copyWith(mortgageTerm: value);
    checkErrorTerm();
  }

  void _calculateCurrentTotal() {
    switch (state.mortgageTermType) {
      case MortgageTermType.repayment:
        state = state.copyWith(currentTotal: state.montlyRepayments);
        break;
      case MortgageTermType.interestOnly:
        state = state.copyWith(currentTotal: state.interestMontly);
        break;
      default:
    }
  }

  void checkErrorAmount() {
    if (state.mortgageAmount == 0) {
      state = state.copyWith(isAmountError: true);
    } else {
      state = state.copyWith(isAmountError: false);
    }
  }

  void checkErrorTerm() {
    if (state.mortgageTerm == 0) {
      state = state.copyWith(isTermError: true);
    } else {
      state = state.copyWith(isTermError: false);
    }
  }

  void checkErrorInterestRate() {
    if (state.interestRate == 0) {
      state = state.copyWith(isInterestRateError: true);
    } else {
      state = state.copyWith(isInterestRateError: false);
    }
  }

  void checkTermTypeError() {
    if (state.mortgageTermType == null) {
      state = state.copyWith(isTermTypeError: true);
    } else {
      state = state.copyWith(isTermTypeError: false);
    }
  }

  void handleErrors() {
    checkErrorAmount();
    checkErrorTerm();
    checkErrorInterestRate();
    checkTermTypeError();
  }

  void calculateMortgage() {
    if (state.mortgageTerm == 0 ||
        state.mortgageAmount == 0 ||
        state.interestRate == 0 ||
        state.mortgageTermType == null) {
      handleErrors();
      throw Exception('Mortgage value should be > 0');
    } else {
      final T = state.mortgageTerm * 12;
      final v0 = state.mortgageAmount;
      final R = math.pow(state.interestRate / 100 + 1, 1 / 12);

      final result = ((math.pow(R, T) * (R - 1)) / (math.pow(R, T) - 1)) * v0;

      final totalRepayment = double.parse((result * T).toStringAsFixed(2));

      state = state.copyWith(
        montlyRepayments: double.parse(result.toStringAsFixed(2)),
        totalRepayments: totalRepayment,
        interestMontly:
            double.parse(((totalRepayment - v0) / T).toStringAsFixed(2)),
      );

      _calculateCurrentTotal();
      handleErrors();
    }
  }

  void clear() {
    state = state.copyWith(clearInput: true);
    state = initValue();
  }
}
