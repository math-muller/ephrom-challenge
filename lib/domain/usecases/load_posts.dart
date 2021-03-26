import '../entities/entities.dart';

abstract class LoadPosts {
  Future<PostEntity> load();
}
