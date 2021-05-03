import 'dart:io';

import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:grpc/grpc.dart' as grpc;

class ProdAppEnvironmentProvider implements AppEnvironmentProvider {
  @override
  String get bech32Hrp => "cosmos";

  @override
  String get lcdUrl {
    if (Platform.isIOS) {
      return "http://127.0.0.1";
    } else {
      return "http://10.0.2.2";
    }
  }

  @override
  String get grpcHost {
    if (Platform.isIOS) {
      return "127.0.0.1";
    } else {
      return "10.0.2.2";
    }
  }

  @override
  int get lcdPort => 1317;

  @override
  int get grpcPort => 9091;

  @override
  grpc.ChannelOptions get channelOptions => const grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      );

  @override
  grpc.ClientChannel buildClientChannel() => grpc.ClientChannel(
        grpcHost,
        port: grpcPort,
        options: channelOptions,
      );
}
