import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/wallet_public_info.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/transactions_api.dart';
import 'package:dartz/dartz.dart';

class GetAddressSentTransactionsUseCase {
  final TransactionsApi transactionsApi;

  GetAddressSentTransactionsUseCase(this.transactionsApi);

  Future<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>> execute(
    Pagination pagination,
    WalletPublicInfo walletPublicInfo,
  ) async =>
      transactionsApi.getAddressSentTransactions(
        pagination,
        walletPublicInfo.publicAddress,
      );
}
