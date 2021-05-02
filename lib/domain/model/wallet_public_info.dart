import 'package:equatable/equatable.dart';

class WalletPublicInfo extends Equatable {
  final String publicAddress;
  final String name;

  const WalletPublicInfo({
    this.publicAddress = "",
    this.name = "",
  });

  bool get hasWallet => publicAddress.isNotEmpty;

  @override
  List<Object> get props => [
        publicAddress,
        name,
      ];
}
