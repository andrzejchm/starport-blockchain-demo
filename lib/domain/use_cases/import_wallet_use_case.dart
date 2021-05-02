import 'package:cosmos_wallet_flutter/domain/model/failures/import_wallet_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_private_info.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/utils/logger.dart';
import 'package:dartz/dartz.dart';

class ImportWalletUseCase {
  final WalletSecureStorage _walletSecureStorage;
  final WalletApi _walletApi;
  final WalletStore _walletStore;

  ImportWalletUseCase(this._walletSecureStorage, this._walletApi, this._walletStore);

  Future<Either<ImportWalletFailure, WalletPublicInfo>> execute(
      {required String mnemonic, required String name}) async {
    final mnemonicList = mnemonic.splitIntoWords();
    if (mnemonicList.length < 24) {
      return left(const ImportWalletFailure.invalidMnemonic());
    }
    final result = await _walletApi.importWallet(name, mnemonicList);
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
        (fail) => left(const ImportWalletFailure.secureStorageError()),
        (_) => right(walletInfo.publicInfo),
      );
    }
    return result.map((r) => r.publicInfo);
  }
}
