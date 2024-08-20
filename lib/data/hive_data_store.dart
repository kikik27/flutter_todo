import 'package:flut_todo/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const boxName = 'taskBox';
  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
