import 'package:cosmos_wallet_flutter/domain/model/transaction_fee.dart';
import 'package:equatable/equatable.dart';

class TransactionForm extends Equatable {
  final String toAddress;
  final String amount;
  final String fromAddress;
  final String denom;
  final String memo;
  final TransactionFee fee;

  const TransactionForm({
    required this.toAddress,
    required this.fromAddress,
    required this.amount,
    required this.denom,
    required this.memo,
    this.fee = const TransactionFee(),
  });

  @override
  List<Object> get props => [
        toAddress,
        fromAddress,
        amount,
        denom,
      ];
}
