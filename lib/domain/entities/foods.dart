import 'package:equatable/equatable.dart';

class Foods extends Equatable {
  const Foods({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
