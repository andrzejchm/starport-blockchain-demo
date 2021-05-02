import 'package:cosmos_wallet_flutter/data/local/model/wallet_public_info_local_json.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_private_info_local_json.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WalletPrivateInfoLocalJson {
  List<int>? privateKey;
  WalletPublicInfoLocalJson? publicInfo;

  WalletPrivateInfoLocalJson({
    required this.privateKey,
    required this.publicInfo,
  });

  factory WalletPrivateInfoLocalJson.fromJson(Map<String, dynamic> json) => _$WalletPrivateInfoLocalJsonFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPrivateInfoLocalJsonToJson(this);

  WalletPrivateInfo toDomain() => WalletPrivateInfo(
        privateKey: privateKey ?? [],
        publicInfo: publicInfo?.toDomain() ?? const WalletPublicInfo(),
      );

  WalletPrivateInfoLocalJson.fromDomain(WalletPrivateInfo walletPrivateInfo)
      : privateKey = walletPrivateInfo.privateKey,
        publicInfo = WalletPublicInfoLocalJson.fromDomain(walletPrivateInfo.publicInfo);
}
