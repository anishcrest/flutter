class ConstantUtil {
  static const String email_pattern =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";

  static const String preference_user_email_key = 'EMAIL_KEY';

  static const String chat_collection = 'chat';
  static const String chat_document = 'iau9GgGSQ8KxmzK075k5';
  static const String chat_list_collection = 'ChatList';

  static const String user = 'user';

  //DB Constant
  static const String DB_NAME = 'my_db.db';
  static const int DB_VERSION = 1;

  static const String TABLE_NAME = 'Todo';
  static const String todo_column_id = 'id';
  static const String todo_column_title = 'title';
  static const String todo_column_subtitle = 'subTitle';
  static const String todo_column_done = 'done';
  static const String todo_column_isDeleted = 'isDelete';
  static const String todo_column_created_at = 'createdAt';
  static const String todo_column_modified_at = 'modifiedAt';
}
