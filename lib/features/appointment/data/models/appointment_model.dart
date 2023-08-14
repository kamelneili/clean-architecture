import 'dart:convert';

import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppointmentModel extends Appointment {
  AppointmentModel(
      {String? id,
      required String userId,
      required String productId,
      required String time,
      required double total,
      required bool isAccepted,
      required bool isDelivered,
      required DateTime createdAt,
      required bool isCancelled})
      : super(
          id: id,
          userId: userId,
          time: time,
          total: total,
          isAccepted: isAccepted,
          isDelivered: isDelivered,
          createdAt: createdAt,
          isCancelled: isCancelled,
          productId: productId,
        );

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

  Map<String, Object> toDocument() {
    return {
      // 'id': id,
      'userId': userId,
      'time': time,
      'productId': productId,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }

  factory AppointmentModel.fromSnapshot(DocumentSnapshot snap) {
    return AppointmentModel(
      id: snap.id,
      userId: snap['userId'],
      time: snap['time'],
      productId: snap['productId'],
      total: snap['total'],
      isDelivered: snap['isDelivered'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(snap['createdAt']),
      isAccepted: snap['isAccepted'],
      isCancelled: snap['isCancelled'],
    );
  }
  String toJson() => json.encode(toMap());
}
