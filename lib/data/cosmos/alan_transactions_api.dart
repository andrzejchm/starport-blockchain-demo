import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/tx/v1beta1/export.dart' as tx;
import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_received_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/failures/get_address_sent_transactions_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/paginated_list.dart';
import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/repositories/transactions_api.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

class AlanTransactionsApi extends TransactionsApi {
  final AppEnvironmentProvider _appEnvironmentProvider;
  late tx.ServiceClient _serviceClient;

  AlanTransactionsApi(this._appEnvironmentProvider) {
    _serviceClient = tx.ServiceClient(_appEnvironmentProvider.buildClientChannel());
  }

  @override
  Future<Either<GetAddressReceivedTransactionsFailure, PaginatedList<Transaction>>> getAddressReceivedTransactions(
    Pagination pagination,
    String publicAddress,
  ) async {
    return (await _getTxsEvent(pagination, publicAddress, ["transfer.recipient='$publicAddress'"])) //
        .leftMap((l) => const GetAddressReceivedTransactionsFailure.unknown());
  }

  @override
  Future<Either<GetAddressSentTransactionsFailure, PaginatedList<Transaction>>> getAddressSentTransactions(
    Pagination pagination,
    String publicAddress,
  ) async =>
      (await _getTxsEvent(pagination, publicAddress, ["transfer.sender='$publicAddress'"])) //
          .leftMap((l) => const GetAddressSentTransactionsFailure.unknown());

  Future<Either<dynamic, PaginatedList<Transaction>>> _getTxsEvent(
    Pagination pagination,
    String publicAddress,
    List<String> events,
  ) async {
    final result = await _serviceClient.getTxsEvent(
      tx.GetTxsEventRequest(
        events: events,
        orderBy: OrderBy.ORDER_BY_DESC,
        pagination: PageRequest(
          offset: pagination.offset.toInt64(),
          limit: pagination.limit.toInt64(),
        ),
      ),
    );
    final items = List<Transaction>.unmodifiable(
      result.txResponses
          .toImmutableList()
          .mapIndexed(
            (idx, txResponse) {
              final tx = result.txs[idx];
              final attrs = txResponse.logs
                  .toImmutableList()
                  .flatMap((it) => it.events.toImmutableList())
                  .flatMap((it) => it.attributes.toImmutableList());
              final amountString = attrs.firstOrNull((it) => it.key == 'amount')?.value ?? "";
              var amount = "";
              var token = "";
              final index = amountString.indexOf(RegExp("[a-zA-Z]"));
              if (index != -1) {
                amount = amountString.substring(0, index);
                token = amountString.substring(index);
              } else if (amountString.isNotEmpty) {
                token = amountString;
              }
              final fromAddress = attrs.firstOrNull((it) => it.key.trim() == "sender")?.value ?? "";
              final toAddress = attrs.firstOrNull((it) => it.key.trim() == "recipient")?.value ?? "";
              final action = attrs.firstOrNull((it) => it.key.trim() == "action")?.value ?? "";
              return Transaction(
                hash: TransactionHash(txResponse.txhash),
                isSuccessful: txResponse.isSuccessful,
                fromAddress: fromAddress,
                toAddress: toAddress,
                action: action,
                amount: amount,
                tokenDenom: token,
                memo: tx.body.memo,
              );
            },
          )
          .reversed()
          .asList(),
    );
    return right(PaginatedList(
      nextPage: pagination.nextPage(),
      items: items,
    ));
  }
}
