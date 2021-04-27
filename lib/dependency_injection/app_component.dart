import 'package:cosmos_wallet_flutter/data/keychain_wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void getItSafeUnregister<T extends Object>() {
  try {
    getIt.unregister<T>();
  } catch (_) {
    //that's ok, looks like it was not registered
  }
}

void getItSafeRegister<T extends Object>(T Function() factory) {
  getItSafeUnregister<T>();
  getIt.registerFactory<T>(factory);
}

void configureDependencies(String environment) {
  getIt.registerFactory<WalletSecureStorage>(
    () => KeychainWalletSecureStorage(),
  );
}
