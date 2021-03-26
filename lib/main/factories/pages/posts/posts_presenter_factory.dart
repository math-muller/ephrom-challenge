import 'package:ephrom/main/factories/usecases/usecases.dart';
import 'package:ephrom/presentation/presenters/presenters.dart';
import 'package:ephrom/ui/pages/posts/posts.dart';

PostsPresenter makeGetxPostsPresenter() => GetxPostsPresenter(
      loadPosts: makeRemoteLoadPosts(),
    );
