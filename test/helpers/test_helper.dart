import 'package:beautycentre/features/post/domain/repositories/posts_repository.dart';
import 'package:beautycentre/features/post/domain/usecases/get_all_posts.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [PostsRepository],
  // customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
