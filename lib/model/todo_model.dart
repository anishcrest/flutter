import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int? id;
  final String? title;
  final String? subTitle;
  final bool? done;
  final bool? isDelete;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  TodoModel({
    required this.title,
    required this.subTitle,
    required this.createdAt,
    this.id,
    this.done = false,
    this.isDelete = false,
    this.modifiedAt,
  });

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap({bool forFirebase = false}) {
    Map<String, dynamic> map = {};

    map = {
      ConstantUtil.todo_column_title: title,
      ConstantUtil.todo_column_subtitle: subTitle,
      ConstantUtil.todo_column_created_at: createdAt!.millisecondsSinceEpoch,
      ConstantUtil.todo_column_modified_at: modifiedAt!.millisecondsSinceEpoch,
    };

    if (forFirebase) {
      map[ConstantUtil.todo_column_done] = done;
      map[ConstantUtil.todo_column_isDeleted] = isDelete;
    } else {
      map[ConstantUtil.todo_column_done] = done! ? 0 : 1;
      map[ConstantUtil.todo_column_isDeleted] = isDelete! ? 0 : 1;
    }

    return map;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[ConstantUtil.todo_column_id],
      title: map[ConstantUtil.todo_column_title],
      subTitle: map[ConstantUtil.todo_column_subtitle],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[ConstantUtil.todo_column_created_at]),
      modifiedAt: DateTime.fromMillisecondsSinceEpoch(
          map[ConstantUtil.todo_column_modified_at]),
      done: map[ConstantUtil.todo_column_done] == 0 ? true : false,
      isDelete: map[ConstantUtil.todo_column_isDeleted] == 0 ? true : false,
    );
  }

  factory TodoModel.fromDoc(DocumentSnapshot documentSnapshot) {
    var map = documentSnapshot.data() as Map<String, dynamic>;

    return TodoModel(
      id: int.parse(documentSnapshot.id),
      title: map[ConstantUtil.todo_column_title],
      subTitle: map[ConstantUtil.todo_column_subtitle],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[ConstantUtil.todo_column_created_at]),
      modifiedAt: DateTime.fromMillisecondsSinceEpoch(
          map[ConstantUtil.todo_column_modified_at]),
      done: map[ConstantUtil.todo_column_done],
      isDelete: map[ConstantUtil.todo_column_isDeleted],
    );
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? subTitle,
    bool? done = false,
    bool? isDelete = false,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return TodoModel(
      title: this.title ?? title,
      subTitle: this.subTitle ?? subTitle,
      createdAt: this.createdAt ?? createdAt,
      modifiedAt: this.modifiedAt ?? modifiedAt,
      isDelete: isDelete,
      done: done,
      id: this.id ?? id,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subTitle,
      ];
}
