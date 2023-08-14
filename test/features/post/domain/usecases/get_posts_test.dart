import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:beautycentre/features/post/domain/repositories/posts_repository.dart';
import 'package:beautycentre/features/post/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([PostsRepository])
void main() {
  late GetAllPostsUsecase getPostsUseCase;
  late MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    getPostsUseCase = GetAllPostsUsecase(mockPostsRepository);
  });
  List<Post> posts = [
    Post(
        category: 'makeup',
        id: "1",
        name: "rougelevre",
        imageUrl:
            "https://images.unsplash.com/photo-1629118477133-b8b1499f2b8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YnJpZGFsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
        isRecommanded: true,
        price: "50")
  ];
  //
  test('should get all posts from the repository', () async {
    // arrange
    when(mockPostsRepository.getAllPosts())
        .thenAnswer((_) async => Right(posts));

    // act
    final result = await getPostsUseCase.call();

    // assert
    expect(result, Right(posts));
  });
}
