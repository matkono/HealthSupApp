import 'package:healthsup/features/disease/domain/entities/pagination.dart';

class PaginationModel extends Pagination {
  PaginationModel({
    final int pageSize,
    final int pageNumber,
  }) : super(
          pageSize: pageSize,
          pageNumber: pageNumber,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (pageSize != null) json['pageSize'] = pageSize;
    if (pageNumber != null) json['pageNumber'] = pageNumber;

    return json;
  }

  factory PaginationModel.fromEntity(Pagination pagination) {
    if (pagination == null) return null;

    return PaginationModel(
      pageSize: pagination.pageSize,
      pageNumber: pagination.pageNumber,
    );
  }
}
