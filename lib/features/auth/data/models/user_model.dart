import 'package:beautycentre/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
  UserModel(
      {String? id,
      required String fullName,
      required String address,
      required String email,
      required String city,
      required String country,
      required String zipCode,
      required String imageUrl,
      required String genre,
      required String specialite})
      : super(
          id: id,
          email: email,
          country: country,
          fullName: fullName,
          address: address,
          city: city,
          imageUrl: imageUrl,
          zipCode: zipCode,
          genre: genre,
          specialite: specialite,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.id,
      genre: snap['genre'],
      specialite: snap['specialite'],
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      city: snap['city'],
      country: snap['country'],
      zipCode: snap['zipCode'],
      imageUrl: snap['imageUrl'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': zipCode,
      'imageUrl': imageUrl,
      'genre': genre,
      'specialite': specialite
    };
  }
}
