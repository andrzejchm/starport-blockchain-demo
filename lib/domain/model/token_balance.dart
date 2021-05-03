import 'package:equatable/equatable.dart';

class TokenBalance extends Equatable {
  final String denom;
  final String amount;

  const TokenBalance({
    this.denom = '',
    this.amount = '0',
  });

  @override
  List<Object> get props => [
        denom,
      ];
}
