import 'package:common_components/model/todo_model.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:common_components/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'todo_store.dart';

class TodoComponent extends StatefulWidget {
  const TodoComponent({Key? key}) : super(key: key);

  @override
  _TodoComponentState createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  late final TodoStore todoStore;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todoStore = TodoStore();
    todoStore.sysncLocalDataWithRemoteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return todoStore.toDoList.isEmpty
              ? Center(
                  child: Text(AppString.no_todo_found),
                )
              : ListView.builder(
                  itemCount: todoStore.toDoList.length,
                  itemBuilder: (_, index) {
                    if (todoStore.toDoList[index].isDelete!) {
                      return Container();
                    }

                    return Dismissible(
                      key: ValueKey(todoStore.toDoList[index].id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete),
                      ),
                      /*secondaryBackground: Container(
                        color: Colors.greenAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.done,
                          size: 32,
                        ),
                      ),*/
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd) {
                          //delete
                          todoStore.deleteData(todoStore.toDoList[index]);
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          titleController.text =
                              todoStore.toDoList[index].title!;
                          subTitleController.text =
                              todoStore.toDoList[index].subTitle!;
                          showAddTodoDialog(todoStore.toDoList[index]);
                        },
                        child: Card(
                          color: todoStore.toDoList[index].done!
                              ? Colors.green
                              : null,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: ListTile(
                            title: Text(todoStore.toDoList[index].title!),
                            subtitle: Text(todoStore.toDoList[index].subTitle!),
                            trailing: Text(
                              TimeUtil.newMessageTime(
                                  todoStore.toDoList[index].createdAt!),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodoDialog(null),
        child: Icon(Icons.add),
      ),
    );
  }

  showAddTodoDialog(TodoModel? todoModel) {
    showDialog(
      context: context,
      builder: (_) {
        bool? isDone = todoModel != null ? todoModel.done : false;

        return SimpleDialog(
          title: Text(AppString.add_todo),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
              .copyWith(bottom: 20),
          elevation: 8,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: AppString.title,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: subTitleController,
              decoration: InputDecoration(
                labelText: AppString.sub_title,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
            if (todoModel != null)
              SizedBox(
                height: 8,
              ),
            if (todoModel != null)
              StatefulBuilder(
                builder: (ctx, setState) {
                  return CheckboxListTile(
                    value: isDone,
                    title: Text('is todo done'),
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) {
                      setState(() {
                        isDone = val;
                      });
                    },
                  );
                },
              ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  fillColor: Colors.white,
                  child: Text(
                    AppString.cancel,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    ///todoModel is null means insert todo
                    /// Or is todoModel have value means update todo
                    if (todoModel != null) {
                      ///todo have change the value then only need to update
                      ///otherwise nothing to do
                      if (todoModel.title != titleController.text.trim() ||
                          todoModel.subTitle !=
                              subTitleController.text.trim() ||
                          todoModel.done != isDone) {
                        todoStore.updateData(
                          TodoModel(
                            title: titleController.text.trim(),
                            subTitle: subTitleController.text.trim(),
                            createdAt: DateTime.now(),
                            done: isDone,
                            isDelete: false,
                            id: todoModel.id,
                            modifiedAt: DateTime.now(),
                          ),
                        );
                      }
                    } else {
                      todoStore.insertData(
                        TodoModel(
                          title: titleController.text.trim(),
                          subTitle: subTitleController.text.trim(),
                          createdAt: DateTime.now(),
                          modifiedAt: DateTime.now(),
                        ),
                      );
                    }

                    titleController.clear();
                    subTitleController.clear();
                  },
                  fillColor: Theme.of(context).primaryColor,
                  child: Text(
                    AppString.submit,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
