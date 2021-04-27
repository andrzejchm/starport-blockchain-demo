import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_public_info_local_json.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WalletPublicInfoLocalJson {
  String? publicAddress;

  WalletPublicInfoLocalJson({
    required this.publicAddress,
  });

  factory WalletPublicInfoLocalJson.fromJson(Map<String, dynamic> json) => _$WalletPublicInfoLocalJsonFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPublicInfoLocalJsonToJson(this);

  WalletPublicInfo toDomain() => WalletPublicInfo(publicAddress: publicAddress ?? "");
}
