import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel extends Post {
  PostModel(
      {required String id,
      required String name,
      required String category,
      required String imageUrl,
      required String price,
      required bool isRecommanded})
      : super(
            id: id,
            name: name,
            category: category,
            price: price,
            imageUrl: imageUrl,
            isRecommanded: isRecommanded);

  static PostModel fromSnapshot(DocumentSnapshot snap) {
    PostModel postmodel = PostModel(
      id: snap.id,
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      isRecommanded: snap['isRecommanded'],
      //isPopular: snap['isPopular'],
      //description: snap['description'],
    );
    return postmodel;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'isRecommanded': isRecommanded,
      'imageUrl': imageUrl
    };
  }
}
