import 'package:equatable/equatable.dart';

class Drinks extends Equatable {
  const Drinks({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
