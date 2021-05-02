import 'dart:convert';

import 'package:cosmos_wallet_flutter/data/local/model/wallet_private_info_local_json.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/save_wallet_public_info_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeychainWalletSecureStorage implements WalletSecureStorage {
  final FlutterSecureStorage _storage;
  static const KEY_PRIVATE_WALLET_INFO = "private_wallet_info";

  KeychainWalletSecureStorage() : _storage = const FlutterSecureStorage();

  @override
  Future<Either<GetWalletPublicInfoFailure, WalletPrivateInfo>> getWalletPrivateInfo() async {
    try {
      final infoString = await _storage.read(key: KEY_PRIVATE_WALLET_INFO);
      if (isNullOrBlank(infoString)) {
        return right(const WalletPrivateInfo());
      } else {
        return right(WalletPrivateInfoLocalJson.fromJson(jsonDecode(infoString!) as Map<String, dynamic>).toDomain());
      }
    } catch (e, stack) {
      logError(e, stack);
      return left(const GetWalletPublicInfoFailure.unknown());
    }
  }

  @override
  Future<Either<SaveWalletPublicInfoFailure, Unit>> saveWalletPrivateInfo(WalletPrivateInfo walletInfo) async {
    try {
      await _storage.write(
        key: KEY_PRIVATE_WALLET_INFO,
        value: jsonEncode(WalletPrivateInfoLocalJson.fromDomain(walletInfo).toJson()),
      );
      return right(unit);
    } catch (e, stack) {
      logError(e, stack);
      return left(const SaveWalletPublicInfoFailure.unknown());
    }
  }
}
