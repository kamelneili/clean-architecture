import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String? id;
  final String userId;

  final double total;
  final String productId;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;

  final DateTime createdAt;
  final String time;
  Appointment(
      {this.id,
      required this.userId,
      required this.productId,
      required this.time,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.createdAt,
      required this.isCancelled});
  @override
  List<Object?> get props => [
        id,
        productId,
        total,
        isAccepted,
        isDelivered,
        createdAt,
        isCancelled,
        time,
        userId
      ];
  Appointment copyWith(
      {String? id,
      String? userId,
      String? prouctId,
      double? total,
      String? time,
      bool? isAccepted,
      bool? isDelivered,
      DateTime? createdAt,
      bool? isCancelled}) {
    return Appointment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      time: time ?? this.time,
      productId: this.productId,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
