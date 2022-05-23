// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStore, Store {
  final _$toDoListAtom = Atom(name: '_TodoStore.toDoList');

  @override
  ObservableList<TodoModel> get toDoList {
    _$toDoListAtom.reportRead();
    return super.toDoList;
  }

  @override
  set toDoList(ObservableList<TodoModel> value) {
    _$toDoListAtom.reportWrite(value, super.toDoList, () {
      super.toDoList = value;
    });
  }

  final _$errorAtom = Atom(name: '_TodoStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$sysncLocalDataWithRemoteDataAsyncAction =
      AsyncAction('_TodoStore.sysncLocalDataWithRemoteData');

  @override
  Future sysncLocalDataWithRemoteData() {
    return _$sysncLocalDataWithRemoteDataAsyncAction
        .run(() => super.sysncLocalDataWithRemoteData());
  }

  final _$getAllDataAsyncAction = AsyncAction('_TodoStore.getAllData');

  @override
  Future<dynamic> getAllData() {
    return _$getAllDataAsyncAction.run(() => super.getAllData());
  }

  final _$insertDataAsyncAction = AsyncAction('_TodoStore.insertData');

  @override
  Future<dynamic> insertData(TodoModel todoModel) {
    return _$insertDataAsyncAction.run(() => super.insertData(todoModel));
  }

  final _$deleteDataAsyncAction = AsyncAction('_TodoStore.deleteData');

  @override
  Future<dynamic> deleteData(TodoModel todoModel) {
    return _$deleteDataAsyncAction.run(() => super.deleteData(todoModel));
  }

  final _$updateDataAsyncAction = AsyncAction('_TodoStore.updateData');

  @override
  Future<dynamic> updateData(TodoModel todoModel) {
    return _$updateDataAsyncAction.run(() => super.updateData(todoModel));
  }

  @override
  String toString() {
    return '''
toDoList: ${toDoList},
error: ${error}
    ''';
  }
}
