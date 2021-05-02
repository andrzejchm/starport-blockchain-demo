import 'package:cosmos_wallet_flutter/domain/model/pagination.dart';
import 'package:equatable/equatable.dart';

class PaginatedList<T> extends Equatable {
  final Pagination nextPage;
  final List<T> items;

  PaginatedList({
    this.nextPage = const Pagination.firstPage(),
    List<T>? items,
  }) : items = List.unmodifiable(items ?? []);

  PaginatedList<T> byAppending(PaginatedList<T> newList) => PaginatedList(
        nextPage: newList.nextPage,
        items: [...items, ...newList.items],
      );

  @override
  List<Object> get props => [nextPage, items];
}
