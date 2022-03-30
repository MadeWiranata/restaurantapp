import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  Categories({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
