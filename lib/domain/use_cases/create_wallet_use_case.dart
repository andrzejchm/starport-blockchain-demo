import 'package:cosmos_wallet_flutter/domain/model/create_wallet_form.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/create_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';

class CreateWalletUseCase {
  final WalletSecureStorage _walletSecureStorage;
  final WalletStore _walletStore;
  final WalletApi _walletApi;

  CreateWalletUseCase(this._walletSecureStorage, this._walletApi, this._walletStore);

  Future<Either<CreateWalletFailure, WalletPrivateInfo>> execute(CreateWalletForm form) async {
    final result = await _walletApi.createRandomWallet(form);
    final walletInfo = result.fold<WalletPrivateInfo?>(
      (fail) {
        logError(fail);
        return null;
      },
      (walletInfo) => walletInfo,
    );

    if (walletInfo != null) {
      _walletStore.walletInfo = walletInfo.publicInfo;
      return (await _walletSecureStorage.saveWalletPrivateInfo(walletInfo)).fold(
        (fail) => left(CreateWalletFailure.secureStorageError(fail)),
        (_) => right(walletInfo),
      );
    }
    return result;
  }
}
