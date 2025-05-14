import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posix/common/navigation/app_navigation.dart';
import 'package:posix/core/configs/theme/app_color.dart';
import 'package:posix/core/configs/theme/app_theme.dart';
import 'package:posix/domain/auth/usecases/logout.dart';
import 'package:posix/presentation/auth/bloc/signin_cubit.dart';
import 'package:posix/presentation/auth/pages/signin.dart';
import 'package:posix/presentation/home/bloc/user_location_cubit.dart';
import 'package:posix/presentation/home/pages/custom_map.dart';

import 'package:posix/presentation/home/pages/friend_list.dart';
import 'package:posix/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pageList = [
    CustomMap(),
    FriendList(),
  ];
  int currentIndex = 0;

  logout() {
    Future.delayed(Duration(seconds: 1), () {
      sl<LogoutUseCase>().call(null).then(
            (value) => AppNavigation.pushReplacement(
                context,
                BlocProvider(
                  create: (context) => sl<SigninCubit>(),
                  child: SigninPage(),
                )),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLocationCubit()..getUserLocation(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(currentIndex == 0 ? 'Map' : 'Friends'),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: AppColors.primary),
                  child: Text(
                    'Menu',
                    style: AppTheme.appTheme.textTheme.headlineLarge,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () => logout(),
              ),
            ],
          ),
        ),
        body: pageList[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friends',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
