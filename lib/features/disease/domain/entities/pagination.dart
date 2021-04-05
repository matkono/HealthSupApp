import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Pagination extends Equatable {
  final int pageSize;
  final int pageNumber;

  Pagination({
    @required this.pageSize,
    @required this.pageNumber,
  });

  @override
  List<Object> get props => [pageSize, pageNumber];
}
