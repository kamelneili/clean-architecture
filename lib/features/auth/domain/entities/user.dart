import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;
  final String imageUrl;
  final String genre;
  final String specialite;

  const User({
    this.id,
    this.email = '',
    this.fullName = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
    this.imageUrl = '',
    this.genre = '',
    this.specialite = '',
  });

  User copyWith(
      {String? id,
      String? genre,
      String? specialite,
      String? fullName,
      String? email,
      String? address,
      String? city,
      String? country,
      String? zipCode,
      String? imageUrl}) {
    return User(
        id: id ?? this.id,
        specialite: specialite ?? this.specialite,
        genre: genre ?? this.genre,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
        zipCode: zipCode ?? this.zipCode,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  static const User empty = User(
    id: '',
    fullName: '',
    email: '',
  );
  @override
  List<Object?> get props => [
        id,
        specialite,
        genre,
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        imageUrl
      ];
}












// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   final String? id;
//   final String fullName;
//   final String email;
//   final String address;
//   final String city;
//   final String country;
//   final String zipCode;
//   final String imageUrl;

//   const User({
//     this.id,
//     this.imageUrl = '',
//     this.fullName = '',
//     this.email = '',
//     this.address = '',
//     this.city = '',
//     this.country = '',
//     this.zipCode = '',
//   });

//   User copyWith(
//       {String? id,
//       String? fullName,
//       String? email,
//       String? address,
//       String? city,
//       String? country,
//       String? zipCode,
//       String? imageUrl}) {
//     return User(
//         id: id ?? this.id,
//         fullName: fullName ?? this.fullName,
//         email: email ?? this.email,
//         address: address ?? this.address,
//         city: city ?? this.city,
//         country: country ?? this.country,
//         zipCode: zipCode ?? this.zipCode,
//         imageUrl: imageUrl ?? this.imageUrl);
//   }

//   factory User.fromSnapshot(DocumentSnapshot snap) {
//     return User(
//       id: snap.id,
//       fullName: snap['fullName'],
//       email: snap['email'],
//       address: snap['address'],
//       city: snap['city'],
//       country: snap['country'],
//       zipCode: snap['zipCode'],
//       imageUrl: snap['imageUrl'],
//     );
//   }

//   Map<String, Object> toDocument() {
//     return {
//       'fullName': fullName,
//       'email': email,
//       'address': address,
//       'city': city,
//       'country': country,
//       'zipCode': zipCode,
//       'imageUrl': imageUrl
//     };
//   }

//   static const empty = User(id: '');

//   @override
//   List<Object?> get props =>
//       [id, fullName, email, address, city, country, zipCode, imageUrl];
// }
