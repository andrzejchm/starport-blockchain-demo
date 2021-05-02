import 'package:cosmos_wallet_flutter/config/app_environment_provider.dart';
import 'package:grpc/grpc.dart' as grpc;

class LocalAppEnvironmentProvider implements AppEnvironmentProvider {
  @override
  String get bech32Hrp => "cosmos";

  @override
  String get lcdUrl => "127.0.0.1";

  @override
  String get grpcHost => "127.0.0.1";

  @override
  int get lcdPort => 1317;

  @override
  int get grpcPort => 26657;

  @override
  grpc.ChannelOptions get channelOptions => const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure());

  @override
  grpc.ClientChannel buildClientChannel() => grpc.ClientChannel(
        grpcHost,
        port: grpcPort,
        options: channelOptions,
      );
}
