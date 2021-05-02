import 'package:grpc/grpc.dart' as grpc;

abstract class AppEnvironmentProvider {
  grpc.ChannelOptions get channelOptions;

  String get bech32Hrp;

  String get lcdUrl;

  int get lcdPort;

  int get grpcPort;

  String get grpcHost;

  grpc.ClientChannel buildClientChannel();
}

enum AppEnvironment {
  local,
  production,
}

extension EnvironmentsStrings on AppEnvironment {
  String get stringVal {
    switch (this) {
      case AppEnvironment.local:
        return "local";
      case AppEnvironment.production:
        return "production";
    }
  }
}
