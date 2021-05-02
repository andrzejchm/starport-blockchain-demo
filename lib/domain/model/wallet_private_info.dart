import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:equatable/equatable.dart';

class WalletPrivateInfo extends Equatable {
  final List<int> privateKey;
  final WalletPublicInfo publicInfo;
  final List<String> mnemonic;

  const WalletPrivateInfo({
    this.mnemonic = const [],
    this.privateKey = const [],
    this.publicInfo = const WalletPublicInfo(),
  });

  @override
  List<Object> get props => [
        privateKey,
        publicInfo,
      ];
}
