import 'package:equatable/equatable.dart';

class Foods extends Equatable {
  Foods({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
