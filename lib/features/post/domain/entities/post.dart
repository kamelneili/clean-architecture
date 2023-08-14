import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Post extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String price;
  // final List<String> tags;
  final bool isRecommanded;

  Post({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.isRecommanded,
  });
  @override
  List<Object?> get props =>
      [id, name, imageUrl, category, price, isRecommanded];
}
