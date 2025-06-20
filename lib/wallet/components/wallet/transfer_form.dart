import 'package:artahub/wallet/components/form/paper_form.dart';
import 'package:artahub/wallet/components/form/paper_input.dart';
import 'package:artahub/wallet/components/form/paper_radio.dart';
import 'package:artahub/wallet/components/form/paper_validation_summary.dart';
import 'package:artahub/wallet/components/wallet/balance.dart';
import 'package:artahub/wallet/context/transfer/wallet_transfer_provider.dart';
import 'package:artahub/wallet/context/wallet/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../model/wallet_transfer.dart';

class TransferForm extends HookWidget {
  const TransferForm({
    Key? key,
    required this.address,
    required this.onSubmit,
  }) : super(key: key);

  final String? address;
  final void Function(WalletTransferType type, String address, String amount)
      onSubmit;

  @override
  Widget build(BuildContext context) {
    final toController = useTextEditingController(text: address);
    final amountController = useTextEditingController();
    final transferStore = useWalletTransfer(context);
    final walletStore = useWallet(context);
    final transferType = useState<WalletTransferType>(WalletTransferType.token);

    useEffect(() {
      if (address != null)
        toController.value = TextEditingValue(text: address!);

      return null;
    }, [address]);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              ElevatedButton(
                child: const Text('Transfer now'),
                onPressed: () => onSubmit(
                  transferType.value,
                  toController.value.text,
                  amountController.value.text,
                ),
              )
            ],
            children: <Widget>[
              if (transferStore.state.errors != null)
                PaperValidationSummary(transferStore.state.errors!.toList()),
              Row(children: <Widget>[
                PaperRadio(
                  'Contract Token',
                  groupValue: transferType.value,
                  value: WalletTransferType.token,
                  onChanged: (value) =>
                      transferType.value = value as WalletTransferType,
                ),
                PaperRadio(
                  walletStore.state.network.config.symbol,
                  groupValue: transferType.value,
                  value: WalletTransferType.ether,
                  onChanged: (value) =>
                      transferType.value = value as WalletTransferType,
                ),
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(r'$ '),
                  Balance(
                      balance: transferType.value == WalletTransferType.token
                          ? walletStore.state.tokenBalance
                          : walletStore.state.ethBalance)
                ],
              ),
              const SizedBox(height: 10),
              PaperInput(
                controller: toController,
                labelText: 'To',
                hintText: 'Type the destination address',
              ),
              PaperInput(
                controller: amountController,
                labelText: 'Amount',
                hintText: 'And amount',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
