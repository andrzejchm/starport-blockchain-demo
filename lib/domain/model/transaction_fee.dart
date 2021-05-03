import 'package:equatable/equatable.dart';

class TransactionFee extends Equatable {
  final String denom;
  final String amount;
  final int gasLimit;

  const TransactionFee({
    this.denom = '',
    this.amount = '',
    this.gasLimit = 200000,
  });

  @override
  List<Object> get props => [
        denom,
        amount,
        gasLimit,
      ];
}
