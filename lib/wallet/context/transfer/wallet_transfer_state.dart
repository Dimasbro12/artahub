import 'package:artahub/wallet/model/wallet_transfer.dart';

abstract class WalletTransferAction {}

class WalletTransferInit implements WalletTransferAction {}

class WalletTransferStarted implements WalletTransferAction {}

class UpdateTransferTrasactionId implements WalletTransferAction {
  UpdateTransferTrasactionId(this.transactionId);
  final String? transactionId;
}

class WalletTransferError implements WalletTransferAction {
  WalletTransferError(this.error);
  final String error;
}

class WalletTransferConfirmed implements WalletTransferAction {}

WalletTransfer reducer(WalletTransfer state, WalletTransferAction action) {
  if (action is WalletTransferInit) {
    return WalletTransfer();
  }

  if (action is WalletTransferStarted) {
    return state.rebuild((b) => b
      ..errors.clear()
      ..status = WalletTransferStatus.started
      ..loading = true);
  }

  if (action is UpdateTransferTrasactionId) {
    return state.rebuild((b) => b..transactionId = action.transactionId);
  }

  if (action is WalletTransferError) {
    return state.rebuild((b) => b
      ..status = WalletTransferStatus.none
      ..errors.add(action.error)
      ..loading = false);
  }

  return state;
}
