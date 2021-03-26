import 'post_viewmodel.dart';

abstract class PostsPresenter {
  Stream<PostsViewModel> get postsStream;

  Future<void> loadData();
}
