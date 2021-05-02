import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int limit;
  final int offset;

  const Pagination({
    required this.limit,
    required this.offset,
  });

  const Pagination.firstPage()
      : limit = 20,
        offset = 0;

  Pagination nextPage() => Pagination(limit: limit, offset: offset + limit);

  @override
  List<Object> get props => [limit, offset];
}
