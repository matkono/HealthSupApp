import 'package:healthsup/features/decision_tree/domain/entities/action.dart';
import 'package:flutter/foundation.dart';

class ActionModel extends Action {
  ActionModel({
    @required int id,
    @required int code,
    @required String title,
  }) : super(id: id, code: code, title: title);

  factory ActionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ActionModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
    );
  }
}
