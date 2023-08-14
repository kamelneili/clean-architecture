import 'package:beautycentre/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:beautycentre/features/appointment/data/models/appointment_model.dart';
import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
import 'package:beautycentre/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

typedef Stream<Unit> DeleteOrUpdateOrAddPost();

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;
  //final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AppointmentRepositoryImpl(
      {required this.remoteDataSource,
      // required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> addAppointment(Appointment appointment) async {
    AppointmentModel appointmentModel = AppointmentModel(
        createdAt: appointment.createdAt,
        userId: appointment.userId,
        isAccepted: appointment.isAccepted,
        isCancelled: appointment.isCancelled,
        isDelivered: appointment.isDelivered,
        productId: appointment.productId,
        time: appointment.time,
        total: appointment.total);
    if (await networkInfo.isConnected) {
      try {
        final remoteAppointment =
            await remoteDataSource.addAppointment(appointmentModel);
        print('====remoteposts=======');
        print(remoteAppointment);
        //localDataSource.cachePosts(remoteAppointment);
        return Right(remoteAppointment);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final remoteAppointment =
            await remoteDataSource.addAppointment(appointmentModel);
        //  final localPosts = await localDataSource.getCachedPosts();
        return Right(remoteAppointment);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
