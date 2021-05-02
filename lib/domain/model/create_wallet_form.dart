import 'package:equatable/equatable.dart';

class CreateWalletForm extends Equatable {
  final String name;
  final String password;
  final String confirmPassword;

  const CreateWalletForm({
    required this.name,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        name,
        password,
        confirmPassword,
      ];
}
