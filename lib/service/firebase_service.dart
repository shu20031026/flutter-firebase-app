import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseService();

  // 取得
  Stream<QuerySnapshot> getItems() {
    return _database.collection("todo").orderBy("created").snapshots();
  }

  // 追加
  Future<bool> postItem({required String content, bool isChecked = false}) async {
    try {
      await _database.collection("todo").add(
        {"content": content, "isChecked": isChecked, "created": Timestamp.now()},
      );

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  // 削除
  Future<bool> deleteItem({required String doc}) async {
    try {
      await _database.collection("todo").doc(doc).delete();

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  // 更新(チェック)
  Future<bool> updateItem({required String doc, bool? isChecked}) async {
    try {
      await _database.collection("todo").doc(doc).update({"isChecked": isChecked});

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }
}
