import 'package:equatable/equatable.dart';

class CreateWalletForm extends Equatable {
  final String name;

  const CreateWalletForm({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}
