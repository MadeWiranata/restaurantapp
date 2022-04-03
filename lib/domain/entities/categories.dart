import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  const Categories({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}
