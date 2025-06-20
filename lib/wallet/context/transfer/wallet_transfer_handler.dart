import 'dart:async';
import 'dart:math';

import 'package:artahub/wallet/context/transfer/wallet_transfer_state.dart';
import 'package:artahub/wallet/model/network_type.dart';
import 'package:artahub/wallet/model/wallet_transfer.dart';
import 'package:artahub/wallet/service/configuration_service.dart';
import 'package:artahub/wallet/service/contract_locator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/web3dart.dart';

class WalletTransferHandler {
  WalletTransferHandler(
    this._store,
    this._contractLocator,
    this._configurationService,
  );

  final Store<WalletTransfer, WalletTransferAction> _store;
  final ContractLocator _contractLocator;
  final ConfigurationService _configurationService;

  WalletTransfer get state => _store.state;

  Future<bool> transfer(NetworkType network, WalletTransferType type, String to,
      String amount) async {
    final completer = Completer<bool>();
    final privateKey = _configurationService.getPrivateKey();

    _store.dispatch(WalletTransferStarted());

    try {
      final transactionId = await _contractLocator.getInstance(network).send(
        privateKey!,
        type,
        EthereumAddress.fromHex(to),
        EtherAmount.inWei(BigInt.from(double.parse(amount) * pow(10, 18))),
        onTransfer: (from, to, value) {
          completer.complete(true);
        },
        onError: (ex) {
          _store.dispatch(WalletTransferError(ex.toString()));

          completer.complete(false);
        },
      );

      _store.dispatch(UpdateTransferTrasactionId(transactionId));
    } catch (ex) {
      _store.dispatch(WalletTransferError(ex.toString()));
      completer.complete(false);
    }

    return completer.future;
  }
}
