import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_received_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionsApi {
  Future<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>> getAddressSentTransactions(
    Pagination pagination,
    String publicAddress,
  );

  Future<Either<GetAddressReceivedTransactionsFailure, PaginatedList<Transaction>>> getAddressReceivedTransactions(
    Pagination pagination,
    String publicAddress,
  );
}
