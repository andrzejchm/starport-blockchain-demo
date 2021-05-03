import 'package:cosmos_wallet_flutter/domain/model/failures/send_transaction_failure.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction.dart';
import 'package:cosmos_wallet_flutter/domain/model/transaction_form.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionSender {
  Future<Either<SendTransactionFailure, TransactionHash>> sendTransaction(TransactionForm transactionForm);
}
