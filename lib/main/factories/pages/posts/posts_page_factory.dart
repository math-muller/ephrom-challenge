import 'package:ephrom/ui/pages/posts/posts.dart';
import 'package:flutter/material.dart';

import 'posts_presenter_factory.dart';

Widget makePostsPage() => PostsPage(makeGetxPostsPresenter());
