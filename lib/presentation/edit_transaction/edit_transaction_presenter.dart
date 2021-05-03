import 'package:cosmos_wallet_flutter/domain/model/token_balance.dart';
import 'package:cosmos_wallet_flutter/domain/use_cases/send_transaction_use_case.dart';
import 'package:cosmos_wallet_flutter/domain/utils/utils.dart';
import 'package:cosmos_wallet_flutter/generated/l10n.dart';
import 'package:cosmos_wallet_flutter/presentation/edit_transaction/edit_transaction_presentation_model.dart';
import 'package:cosmos_wallet_flutter/ui/modules/edit_transaction/edit_transaction_navigator.dart';

class EditTransactionPresenter {
  EditTransactionPresenter(
    this._model,
    this.navigator,
    this._sendTransactionUseCase,
  );

  final EditTransactionPresentationModel _model;
  final EditTransactionNavigator navigator;
  final SendTransactionUseCase _sendTransactionUseCase;

  EditTransactionViewModel get viewModel => _model;

  void addMemoClicked() => _model.addMemo = true;

  void amountChanged(String value) => _model.amount = value;

  void memoChanged(String value) => _model.memo = value;

  void addressChanged(String value) => _model.address = value;

  void sendTransactionClicked() => _model.sendTransactionFuture = _sendTransactionUseCase //
          .execute(_model.transactionForm)
          .observableDoOn(
        (fail) => navigator.showError(fail.displayableFailure()),
        (success) {
          navigator.showSnackBar(S.current.transactionSentSuccessfullyMessage);
          navigator.close();
        },
      );

  void onTokenSelected(TokenBalance tokenBalance) => _model.token = tokenBalance;
}
