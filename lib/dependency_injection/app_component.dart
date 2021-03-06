import 'package:alan/alan.dart';
import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/config/local_app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/config/prod_app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/data/cosmos/alan_transaction_sender.dart';
import 'package:cosmos_wallet_flutter/data/cosmos/alan_transactions_api.dart';
import 'package:cosmos_wallet_flutter/data/cosmos/alan_wallet_api.dart';
import 'package:cosmos_wallet_flutter/data/cosmos/local_auth_wallet_info_gateway.dart';
import 'package:cosmos_wallet_flutter/data/local/keychain_wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/data/local/local_biometric_authenticator.dart';
import 'package:cosmos_wallet_flutter/domain/biometric_authenticator.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/transactions_api.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/wallet_api.dart';
import 'package:cosmos_wallet_flutter/domain/secure_storage/wallet_secure_storage.dart';
import 'package:cosmos_wallet_flutter/domain/stores/transactions_store.dart';
import 'package:cosmos_wallet_flutter/domain/stores/wallet_store.dart';
import 'package:cosmos_wallet_flutter/domain/transaction_sender.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/create_wallet_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_received_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_address_sent_transactions_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_token_balances_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/get_wallet_public_info_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/import_wallet_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/log_out_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/send_transaction_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/wallet_info_gateway.dart';
import 'package:cosmos_wallet_flutter/navigation/app_navigator.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presenter.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/main/main_presenter.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/routing/routing_presenter.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presentation_model.dart';
import 'package:cosmos_wallet_flutter/presentation/wallet_setup/wallet_setup_presenter.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/edit_transaction_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/main/main_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/routing/routing_navigator.dart';
import 'package:cosmos_wallet_flutter/ui/modules/wallet_setup/wallet_setup_navigator.dart';
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

void configureDependencies(AppEnvironment environment) {
  getIt.registerLazySingleton<AppNavigator>(
    () => AppNavigator(),
  );
  getIt.registerFactory<WalletSecureStorage>(
    () => KeychainWalletSecureStorage(),
  );
  _configureUseCases();
  _configureModelViewPresenters();
  _configureEnvironmentProvider(environment);
  _configureApis();
  _configureStores();
}

void _configureStores() {
  getIt.registerLazySingleton<WalletStore>(
    () => WalletStore(),
  );
  getIt.registerLazySingleton<TransactionsStore>(
    () => TransactionsStore(),
  );
}

void _configureApis() {
  getIt.registerFactory<TransactionSender>(
    () => AlanTransactionSender(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<NetworkInfo>(() {
    final appEnvironmentProvider = getIt<AppEnvironmentProvider>();
    return NetworkInfo(
      bech32Hrp: appEnvironmentProvider.bech32Hrp,
      fullNodeHost: appEnvironmentProvider.lcdUrl,
      gRPCPort: appEnvironmentProvider.grpcPort,
      lcdPort: appEnvironmentProvider.lcdPort,
    );
  });
  getIt.registerFactory<BiometricAuthenticator>(
    () => LocalBiometricAuthenticator(),
  );
  getIt.registerFactory<WalletInfoGateway>(
    () => LocalAuthWalletInfoGateway(getIt(), getIt()),
  );

  getIt.registerLazySingleton<WalletApi>(
    () => AlanWalletApi(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<TransactionsApi>(
    () => AlanTransactionsApi(getIt()),
  );
}

void _configureEnvironmentProvider(AppEnvironment environment) {
  getIt.registerLazySingleton<AppEnvironmentProvider>(
    () {
      switch (environment) {
        case AppEnvironment.local:
          return LocalAppEnvironmentProvider();
        case AppEnvironment.production:
          return ProdAppEnvironmentProvider();
      }
    },
  );
}

void _configureUseCases() {
  getIt.registerFactory<GetWalletPublicInfoUseCase>(
    () => GetWalletPublicInfoUseCase(getIt(), getIt()),
  );
  getIt.registerFactory<CreateWalletUseCase>(
    () => CreateWalletUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<GetTokenBalancesUseCase>(
    () => GetTokenBalancesUseCase(getIt(), getIt()),
  );
  getIt.registerFactory<GetAddressReceivedTransactionsUseCase>(
    () => GetAddressReceivedTransactionsUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<GetAddressSentTransactionsUseCase>(
    () => GetAddressSentTransactionsUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<ImportWalletUseCase>(
    () => ImportWalletUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<SendTransactionUseCase>(
    () => SendTransactionUseCase(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<LogOutUseCase>(
    () => LogOutUseCase(getIt(), getIt(), getIt()),
  );
}

void _configureModelViewPresenters() {
  getIt.registerFactoryParam<RoutingPresenter, RoutingPresentationModel, void>(
    (_model, _) => RoutingPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<RoutingNavigator>(
    () => RoutingNavigator(getIt()),
  );

  getIt.registerFactoryParam<MainPresenter, MainPresentationModel, void>(
    (_model, _) => MainPresenter(_model!, getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<MainNavigator>(
    () => MainNavigator(getIt()),
  );

  getIt.registerFactoryParam<WalletSetupPresenter, WalletSetupPresentationModel, void>(
    (_model, _) => WalletSetupPresenter(_model!, getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<WalletSetupNavigator>(
    () => WalletSetupNavigator(getIt()),
  );

  getIt.registerFactoryParam<EditTransactionPresenter, EditTransactionPresentationModel, dynamic>(
    (_model, _) => EditTransactionPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<EditTransactionNavigator>(
    () => EditTransactionNavigator(getIt()),
  );
}
