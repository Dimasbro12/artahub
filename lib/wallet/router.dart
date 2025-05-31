import 'package:artahub/wallet/model/network_type.dart';
import 'package:artahub/wallet/qrcode_reader_page.dart';
import 'package:artahub/wallet/service/configuration_service.dart';
import 'package:artahub/wallet/utils/route_utils.dart';
import 'package:artahub/wallet/wallet_create_page.dart';
import 'package:artahub/wallet/wallet_import_page.dart';
import 'package:artahub/wallet/wallet_main_page.dart';
import 'package:artahub/wallet/wallet_transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:artahub/screens/home_screen.dart';
import 'context/setup/wallet_setup_provider.dart';
import 'context/transfer/wallet_transfer_provider.dart';
import 'intro_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) {
      final configurationService = Provider.of<ConfigurationService>(context);
      return configurationService.didSetupWallet()
          ? WalletMainPage('Your wallet')
          : const IntroPage();
    },
    '/home': (BuildContext context) =>
        const HomeScreen(), // Tambahkan rute HomeScreen
    '/create': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          useEffect(() {
            store.generateMnemonic();
            return null;
          }, []);
          return WalletCreatePage('Create wallet');
        }),
    '/import': (BuildContext context) => WalletSetupProvider(
          builder: (context, store) => WalletImportPage('Import wallet'),
        ),
    '/transfer': (BuildContext context) => WalletTransferProvider(
          builder: (context, store) => WalletTransferPage(
            title: 'Send Tokens',
            network: getRouteArgs<NetworkType>(context),
          ),
        ),
    '/qrcode_reader': (BuildContext context) => QRCodeReaderPage(
          title: 'Scan QRCode',
          onScanned: ModalRoute.of(context)?.settings.arguments as OnScanned?,
        ),
  };
}
