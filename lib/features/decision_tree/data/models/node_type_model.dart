import 'package:HealthSup/features/decision_tree/domain/entities/node_type.dart';
import 'package:flutter/foundation.dart';

class NodeTypeModel extends NodeType {
  NodeTypeModel({
    @required int id,
    @required int code,
  }) : super(
          id: id,
          code: code,
        );

  factory NodeTypeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return NodeTypeModel(
      id: json['id'],
      code: json['code'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;
    if (code != null) json['code'] = code;

    return json;
  }
}
