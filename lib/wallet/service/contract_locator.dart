import 'package:artahub/wallet/app_config.dart';
import 'package:artahub/wallet/model/network_type.dart';
import 'package:artahub/wallet/service/contract_service.dart';
import 'package:artahub/wallet/utils/contract_parser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ContractLocator {
  ContractLocator._();

  static Map<NetworkType, ContractService> instance =
      <NetworkType, ContractService>{};

  static Future<ContractLocator> setup() async {
    for (final network in NetworkType.enabledValues) {
      instance[network] = await createInstance(network.config);
    }

    return ContractLocator._();
  }

  ContractService getInstance(NetworkType network) {
    return instance[network]!;
  }

  static Future<ContractService> createInstance(
      AppConfigParams networkConfig) async {
    final wsAddress = networkConfig.web3RdpUrl;
    final client = Web3Client(networkConfig.web3HttpUrl, Client(),
        socketConnector: wsAddress != null
            ? () {
                if (kIsWeb)
                  return WebSocketChannel.connect(Uri.parse(wsAddress))
                      .cast<String>();

                return IOWebSocketChannel.connect(wsAddress).cast<String>();
              }
            : null);

    final contract = await ContractParser.fromAssets(
        'assets/crypto/TargaryenCoin.json', networkConfig.contractAddress);

    return ContractService(client, contract);
  }
}
