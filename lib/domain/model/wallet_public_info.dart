import 'package:equatable/equatable.dart';

class WalletPublicInfo extends Equatable {
  final String publicAddress;

  const WalletPublicInfo({
    this.publicAddress = "",
  });

  bool get hasWallet => publicAddress.isNotEmpty;

  @override
  List<Object> get props => [
        publicAddress,
      ];
}
