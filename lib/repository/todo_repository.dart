import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/model/todo_model.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoRepository {
  Future addNewTodoIntoFirebase(TodoModel todoModel) async {
    return await FirebaseFirestore.instance
        .collection(ConstantUtil.user)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantUtil.TABLE_NAME)
        .doc(todoModel.id.toString())
        .set(todoModel.toMap(forFirebase: true))
        .then((value) {})
        .catchError((e) {
      throw e;
    });
  }

  Stream<List<TodoModel>> fetchTodosFromFirebaseAsStream() {
    return FirebaseFirestore.instance
        .collection(ConstantUtil.user)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantUtil.TABLE_NAME)
        .snapshots()
        .map((event) => event.docs.map((e) => TodoModel.fromDoc(e)).toList());
  }

  Future deleteTodoFromFirebase(TodoModel todoModel) async {
    return await FirebaseFirestore.instance
        .collection(ConstantUtil.user)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantUtil.TABLE_NAME)
        .doc(todoModel.id.toString())
        .update({
          ConstantUtil.todo_column_isDeleted: true,
        })
        .then((value) {})
        .catchError((e) {
          throw e;
        });
  }

  Future updateTodoIntoFirebase(TodoModel todoModel) async {
    return await FirebaseFirestore.instance
        .collection(ConstantUtil.user)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(ConstantUtil.TABLE_NAME)
        .doc(todoModel.id.toString())
        .update(todoModel.toMap(forFirebase: true))
        .then((value) {})
        .catchError((e) {
      throw e;
    });
  }
}
