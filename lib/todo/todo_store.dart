import 'package:common_components/database/db.dart';
import 'package:common_components/model/todo_model.dart';
import 'package:common_components/repository/todo_repository.dart';
import 'package:common_components/services/connection_services.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final TodoRepository todoRepository = TodoRepository();

  @observable
  ObservableList<TodoModel> toDoList = ObservableList();

  @observable
  String error = '';

  @action
  sysncLocalDataWithRemoteData() async {
    await getAllData();

    ConnectionServices.getInstance().connectionResult.listen((event) {
      if (event != ConnectivityResult.none) {
        if (toDoList.isEmpty) {
          return;
        }

        todoRepository
            .fetchTodosFromFirebaseAsStream()
            .listen((remoteTodoList) async {
          List<TodoModel> temp = toDoList.toList();

          remoteTodoList.forEach((remoteTodo) {
            int indexForCheckDatAlreadyExist =
                toDoList.indexWhere((element) => element.id == remoteTodo.id);

            toDoList.forEach((localToDo) async {
              ///Sync data when update
              if (remoteTodo.id == localToDo.id &&
                  (remoteTodo.title != localToDo.title ||
                      remoteTodo.subTitle != localToDo.subTitle ||
                      remoteTodo.done != localToDo.done)) {
                if (remoteTodo.modifiedAt!.compareTo(localToDo.modifiedAt!) <
                    0) {
                  /// update remote
                  await todoRepository.updateTodoIntoFirebase(
                    TodoModel(
                      id: localToDo.id,
                      title: localToDo.title,
                      subTitle: localToDo.subTitle,
                      createdAt: localToDo.createdAt,
                      isDelete: false,
                      done: localToDo.done,
                      modifiedAt: DateTime.now(),
                    ),
                  );
                } else {
                  /// update local
                  TodoModel tempTodo = TodoModel(
                    id: remoteTodo.id,
                    title: remoteTodo.title,
                    subTitle: remoteTodo.subTitle,
                    createdAt: remoteTodo.createdAt,
                    done: remoteTodo.done,
                    isDelete: remoteTodo.isDelete,
                    modifiedAt: DateTime.now(),
                  );

                  var id = await databaseHelper.update(
                    ConstantUtil.TABLE_NAME,
                    ConstantUtil.todo_column_id,
                    tempTodo.id,
                    tempTodo.toMap(),
                  );

                  var index =
                      toDoList.indexWhere((el) => el.id == localToDo.id);
                  toDoList.removeAt(index);
                  toDoList.insert(index, tempTodo);
                }
              }

              ///Sync data when delete
              else if (remoteTodo.id == localToDo.id &&
                  remoteTodo.isDelete != localToDo.isDelete) {
                ///Sync data from local to remote (when local delete todo)
                if (localToDo.isDelete!) {
                  await todoRepository.deleteTodoFromFirebase(localToDo);
                }

                ///Sync data from remote to local (when remote delete todo)
                else if (remoteTodo.isDelete!) {
                  var id = await databaseHelper.update(
                    ConstantUtil.TABLE_NAME,
                    ConstantUtil.todo_column_id,
                    remoteTodo.id,
                    remoteTodo.toMap(),
                  );

                  var index = temp.indexOf(localToDo);
                  toDoList.remove(localToDo);
                  toDoList.insert(index, remoteTodo);
                }
              }

              ///Sync data from remote to local when remote add new todo
              else if (indexForCheckDatAlreadyExist < 0 &&
                  localToDo != remoteTodo &&
                  !temp.contains(remoteTodo)) {
                temp.add(remoteTodo);
                await databaseHelper.insert(
                    ConstantUtil.TABLE_NAME, remoteTodo.toMap());
              }
            });
          });

          toDoList.clear();
          toDoList.addAll(temp);

          await Future.delayed(Duration(seconds: 2));

          toDoList.forEach((localTodo) async {
            ///upload all local daa into remote if remote data is empty
            if (remoteTodoList.isEmpty) {
              await todoRepository.addNewTodoIntoFirebase(localTodo);
              return;
            }

            ///upload single local data that is not available into server
            else if (remoteTodoList.length != toDoList.length &&
                !remoteTodoList.contains(localTodo) &&
                !localTodo.isDelete!) {
              await todoRepository.addNewTodoIntoFirebase(localTodo);
              return;
            }
          });
        });
      }
    });
  }

  @action
  Future getAllData() async {
    try {
      var tempList = await databaseHelper.queryAllRows(ConstantUtil.TABLE_NAME);
      //var tempList = await databaseHelper.queryWhereRows(ConstantUtil.TABLE_NAME,ConstantUtil.todo_column_isDeleted, 1);

      toDoList.addAll(tempList.map((e) => TodoModel.fromMap(e)).toList());
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  Future insertData(TodoModel todoModel) async {
    try {
      var id = await databaseHelper.insert(
          ConstantUtil.TABLE_NAME, todoModel.toMap());

      var todo = todoModel.copyWith(id: id);

      toDoList.add(todo);

      var result =
          await ConnectionServices.getInstance().connectionResult.first;

      if (result != ConnectivityResult.none) {
        await todoRepository.addNewTodoIntoFirebase(todo);
      }
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  Future deleteData(TodoModel todoModel) async {
    try {
      var tempTodo = todoModel.copyWith(isDelete: true);

      var id = await databaseHelper.update(
        ConstantUtil.TABLE_NAME,
        ConstantUtil.todo_column_id,
        tempTodo.id,
        tempTodo.toMap(),
      );

      var index = toDoList.indexOf(todoModel);
      toDoList.remove(todoModel);
      toDoList.insert(index, tempTodo);

      var result =
          await ConnectionServices.getInstance().connectionResult.first;

      if (result != ConnectivityResult.none) {
        await todoRepository.deleteTodoFromFirebase(todoModel);
      }
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  Future updateData(TodoModel todoModel) async {
    try {
      TodoModel tempTodo = todoModel;

      var id = await databaseHelper.update(
        ConstantUtil.TABLE_NAME,
        ConstantUtil.todo_column_id,
        tempTodo.id,
        tempTodo.toMap(),
      );

      var index = toDoList.indexWhere((el) => el.id == todoModel.id);
      toDoList.removeAt(index);
      toDoList.insert(index, tempTodo);

      var result =
          await ConnectionServices.getInstance().connectionResult.first;

      if (result != ConnectivityResult.none) {
        await todoRepository.updateTodoIntoFirebase(tempTodo);
      }
    } catch (e) {
      error = e.toString();
    }
  }
}
