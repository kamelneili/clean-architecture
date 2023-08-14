import 'package:beautycentre/core/config/constants.dart';
import 'package:beautycentre/core/config/size_config.dart';
import 'package:beautycentre/features/appointment/domain/entities/appointment.dart';
import 'package:beautycentre/features/appointment/domain/entities/delivery_time.dart';
import 'package:beautycentre/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_event.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/appointment_state.dart';
import 'package:beautycentre/features/appointment/presentation/bloc/basket/basket_bloc.dart';
import 'package:beautycentre/features/post/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DeliveryTimeScreen extends StatefulWidget {
  DeliveryTimeScreen({Key? key, this.title, required this.product})
      : super(key: key);
  final String? title;
  final Post product;
  static const String routeName = '/delivery_time';
  final user = auth.FirebaseAuth.instance.currentUser!;

  _DeliveryTimeScreenState createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {
  //
  DatePickerController _controller = DatePickerController();

  //FocusScope.of(context).requestFocus(new FocusNode());
  DateTime _selectedValue = DateTime.now();
  late DeliveryTime time;
  //bool selected = false;
  DateTime? inactive;
  List<DateTime> d = [];
  @override
  void initState() {
    super.initState();

    DateTime inactive = DateTime.now().add(Duration(days: 20));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: Text(
            'Appointment Time',
            style: kEncodeSansBold.copyWith(color: kBlackColor),
          ),
        ),
        extendBodyBehindAppBar: true,
        //                    Navigator.pushNamed(context, '/basket');

        bottomNavigationBar: BottomAppBar(
          // color: Colors.black,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                              )))),
                  onPressed: () {
                    final user = auth.FirebaseAuth.instance.currentUser!;
                    context.read<AppointmentBloc>().add(AddAppointment(
                        appointment: Appointment(
                            isAccepted: false,
                            isCancelled: false,
                            isDelivered: false,
                            total: 0,
                            productId: widget.product.id.toString(),
                            userId: user.uid,
                            createdAt: _selectedValue,
                            time: time.value.toString())));
                    context.read<AppointmentBloc>().add(LoadAppointments(user));

                    //
                    //
                    Navigator.pushNamed(context, '/basket');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Book Appointment"),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Theme.of(context).backgroundColor,
                    width: double.infinity,
                    height: 300,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, top: 130.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Choose a Date',
                            style: Theme.of(context).textTheme.headline5!),

                        //datepicker
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              BlocBuilder<AppointmentBloc, AppointmentState>(
                                  builder: (context, state) {
                                if (state is AppointmentLoaded) {
                                  print(AppointmentLoaded);

                                  List<Appointment> appointments =
                                      state.appointments;
                                  for (var i = 0;
                                      i < appointments.length;
                                      i++) {
                                    d.add(appointments[i].createdAt);
                                  }
                                  print([...d]);

                                  return DatePicker(
                                    DateTime.now(),
                                    initialSelectedDate: DateTime.now(),
                                    selectionColor: Colors.pink,
                                    selectedTextColor: Colors.white,
                                    inactiveDates: d,
                                    controller: _controller,
                                    deactivatedColor: Colors.blue,
                                    onDateChange: (date) {
                                      // New date selected

                                      setState(() {
                                        _selectedValue = date;
                                        //   inactiveDates inactive = date;
                                        print(inactive);
                                      });
                                    },
                                  );
                                } else
                                  return DatePicker(
                                    DateTime.now(),
                                    initialSelectedDate: DateTime.now(),
                                    selectionColor: Colors.pink,
                                    selectedTextColor: Colors.white,
                                    // inactiveDates: [DateTime.now()],
                                    controller: _controller,
                                    deactivatedColor: Colors.blue,
                                    onDateChange: (date) {
                                      // New date selected

                                      setState(() {
                                        _selectedValue = date;
                                        //   inactiveDates inactive = date;
                                        print(inactive);
                                      });
                                    },
                                  );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              //
              //

//************************************* */

              SizedBox(
                height: 30,
              ),
              //
              Center(
                child: Text('Available Times',
                    style: Theme.of(context).textTheme.headline5!),
              ),
              /*************** */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MasonryGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 23,
                      itemCount: DeliveryTime.deliveryTimes.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
                      itemBuilder: (context, index) {
                        return BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            return Card(
                                child: TextButton(
                                    onPressed: () {
                                      time = DeliveryTime.deliveryTimes[index];

                                      context.read<BasketBloc>().add(
                                          SelectDeliveryTime(
                                              DeliveryTime.deliveryTimes[index],
                                              _selectedValue));
                                      // selected = true;
                                    },
                                    child: Text(
                                        '${DeliveryTime.deliveryTimes[index].value}',
                                        style: TextStyle(color: Colors.red))));
                          },
                        );
                      }),
                ],
              )

              /******************* */
            ],
          ),
        ));
  }
}
