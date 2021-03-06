import 'package:cosmos_wallet_flutter/data/local/model/wallet_public_info_local_json.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_private_info_local_json.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WalletPrivateInfoLocalJson {
  List<int>? privateKey;
  WalletPublicInfoLocalJson? publicInfo;
  List<String>? mnemonic;

  WalletPrivateInfoLocalJson({
    required this.privateKey,
    required this.publicInfo,
    required this.mnemonic,
  });

  factory WalletPrivateInfoLocalJson.fromJson(Map<String, dynamic> json) => _$WalletPrivateInfoLocalJsonFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPrivateInfoLocalJsonToJson(this);

  WalletPrivateInfo toDomain() => WalletPrivateInfo(
        privateKey: privateKey ?? [],
        publicInfo: publicInfo?.toDomain() ?? const WalletPublicInfo(),
        mnemonic: mnemonic ?? [],
      );

  WalletPrivateInfoLocalJson.fromDomain(WalletPrivateInfo walletPrivateInfo)
      : privateKey = walletPrivateInfo.privateKey,
        mnemonic = walletPrivateInfo.mnemonic,
        publicInfo = WalletPublicInfoLocalJson.fromDomain(walletPrivateInfo.publicInfo);
}
