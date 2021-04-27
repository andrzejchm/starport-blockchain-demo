import 'dart:convert';

import 'package:cosmos_wallet_flutter/data/local/model/wallet_public_info_local_json.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeychainWalletSecureStorage implements WalletSecureStorage {
  final FlutterSecureStorage _storage;
  static const KEY_PUBLIC_WALLET_INFO = "public_wallet_info";

  KeychainWalletSecureStorage() : _storage = FlutterSecureStorage();

  @override
  Future<Either<GetWalletPublicInfoFailure, WalletPublicInfo>> getWalletPublicInfo() async {
    final infoString = await _storage.read(key: KEY_PUBLIC_WALLET_INFO);
    if (isNullOrBlank(infoString)) {
      return right(WalletPublicInfo());
    } else {
      return right(WalletPublicInfoLocalJson.fromJson(jsonDecode(infoString!)).toDomain());
    }
  }
}
