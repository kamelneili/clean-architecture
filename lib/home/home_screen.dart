import 'package:beautycentre/core/config/constants.dart';
import 'package:beautycentre/core/widgets/custom_navbar.dart';
import 'package:beautycentre/features/post/presentation/pages/posts_page.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../core/config/size_config.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "All",
    "Bridal",
    "MakeUp",
    "Massage",
    "Hair",
    "FaceSkin"
  ];

  List<String> icons = [
    "All items_icon",
    "Dress_icon",
    "Hat_icon",
    "Watch_icon"
  ];

  int current = 0;

  int _currentIndex = 0;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // ignore: prefer_const_constructors
    return Scaffold(
      //appBar: CustomAppBar(),
      bottomNavigationBar: CustomNavBar(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 8),
      //   height: 64,
      //   child: CustomNavigationBar(
      //       isFloating: true,
      //       borderRadius: Radius.circular(40),
      //       selectedColor: kWhiteColor,
      //       unSelectedColor: kGreyColor,
      //       backgroundColor: kBrownColor,
      //       strokeColor: Colors.transparent,
      //       scaleFactor: 0.1,
      //       iconSize: 40,
      //       items: [
      //         CustomNavigationBarItem(
      //           icon: _currentIndex == 0
      //               ? SvgPicture.asset(
      //                   height: 40, 'assets/svg/home_selected.svg')
      //               : SvgPicture.asset(
      //                   height: 40, 'assets/svg/home_unselected.svg'),
      //         ),
      //         CustomNavigationBarItem(
      //           icon: _currentIndex == 1
      //               ? SvgPicture.asset(
      //                   height: 40, 'assets/svg/person_selected.svg')
      //               : SvgPicture.asset(
      //                   height: 40, 'assets/svg/person_unselected.svg'),
      //         ),
      //         CustomNavigationBarItem(
      //           icon: _currentIndex == 2
      //               ? SvgPicture.asset(
      //                   height: 40, 'assets/svg/phone_selected.svg')
      //               : SvgPicture.asset(
      //                   height: 40, 'assets/svg/phone_unselected.svg'),
      //         ),
      //       ],
      //       currentIndex: _currentIndex,
      //       onTap: (index) {
      //         setState(() {
      //           _currentIndex = index;
      //         });
      //       }),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.only(right: 5.0),
                      //width: double.infinity,
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.7),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(3, 3), // changes position of shadow
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/splash.jpg'),
                        ),
                      )),
                  Text('')
                ],
              )),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                  height: 38,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: ((context, index) => GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   current = index;
                            // });

                            // context.read<ProductBloc>().add(
                            //     LoadCategoryProducts(
                            //         category: categories[index]));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 9),
                            margin: EdgeInsets.only(
                                left: index == 0 ? kPaddingHorizontal : 15,
                                right: index == categories.length - 1
                                    ? kPaddingHorizontal
                                    : 0),
                            height: 38,
                            decoration: BoxDecoration(
                              color:
                                  current == index ? kBrownColor : kGreysColor,
                              borderRadius: BorderRadius.circular(8),
                              border: current == index
                                  ? null
                                  : Border.all(
                                      color: kLightGreyColor,
                                      width: 1,
                                    ),
                            ),
                            child: Text(categories[index],
                                style: current == index
                                    ? kEncodeSansMedium.copyWith(
                                        color: current == index
                                            ? kWhiteColor
                                            : kDarkBrownColor,
                                        fontSize: 16,
                                        //SizeConfig.blockSizeHorizontal! * 3,
                                      )
                                    : kEncodeSansRagular.copyWith(
                                        color: current == index
                                            ? kWhiteColor
                                            : kDarkBrownColor,
                                        fontSize: 16,
                                        //SizeConfig.blockSizeHorizontal! * 3,
                                      )),
                          ),
                        )),
                  )),
              SizedBox(
                height: 24,
              ),

              //

              BuildPosts()
              //

              //
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: Center(
          child: Container(
              margin: const EdgeInsets.only(right: 5.0),
              //width: double.infinity,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/logo.png'),
                ),
              ))),
      actions: [
        IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/wishlist');
              // Navigator.of(context).pushNamed(
              //   '/product',
              //   arguments: product,
              // );
            },
            icon: Icon(Icons.favorite, color: Colors.white)),
        Stack(
          children: [
            Positioned(
              top: 2.0,
              right: 15,
              child: Container(
                child: Center(),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                width: 18,
                height: 14,
              ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ],
      //

      //
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
