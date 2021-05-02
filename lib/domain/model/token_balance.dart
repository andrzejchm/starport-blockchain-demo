import 'package:equatable/equatable.dart';

class TokenBalance extends Equatable {
  final String denom;
  final String amount;

  const TokenBalance({
    required this.denom,
    required this.amount,
  });

  @override
  List<Object> get props => [
        denom,
      ];
}
