import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String memo;
  final TransactionHash hash;
  final String fromAddress;
  final String toAddress;
  final String action;
  final bool isSuccessful;
  final String amount;
  final String tokenDenom;

  const Transaction({
    required this.memo,
    required this.fromAddress,
    required this.toAddress,
    required this.hash,
    required this.isSuccessful,
    required this.action,
    required this.amount,
    required this.tokenDenom,
  });

  @override
  List<Object> get props => [
        memo,
        fromAddress,
        toAddress,
        hash,
        isSuccessful,
        action,
        amount,
      ];
}

class TransactionHash extends Equatable {
  final String value;

  const TransactionHash(this.value);

  @override
  List<Object?> get props => [value];
}
