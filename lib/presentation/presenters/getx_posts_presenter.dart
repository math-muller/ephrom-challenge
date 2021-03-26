import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:ephrom/domain/usecases/load_posts.dart';
import 'package:ephrom/ui/pages/posts/posts.dart';

class GetxPostsPresenter extends GetxController implements PostsPresenter {
  final LoadPosts loadPosts;
  final _postsResult = Rx<PostsViewModel>();

  Stream<PostsViewModel> get postsStream => _postsResult.stream;

  GetxPostsPresenter({@required this.loadPosts});

  Future<void> loadData() async {}
}
