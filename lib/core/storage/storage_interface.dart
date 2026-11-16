// lib/core/storage/storage_interface.dart

abstract class LocalStorage<T> {
  Future<void> init();
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<void> put(T item);
  Future<void> delete(String id);
  Future<void> clear();
}

