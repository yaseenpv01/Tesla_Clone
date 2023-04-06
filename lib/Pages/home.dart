import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Pages/Components/bottom_nav.dart';
import 'package:tesla_clone/Pages/Components/car.dart';
import 'package:tesla_clone/Utils/custom_animation_controller.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        onTap: (index) {
          if(index == 1){
            CustomAnimationController.batteryAnimationController.forward();
          }else if(context.read<HomeProvider>().selectedNav == 1 && index != 1){
            CustomAnimationController.batteryAnimationController.reverse(from: .7);
          }

          if(index == 2){
            CustomAnimationController.tempAnimationController.forward();
          }else if(context.read<HomeProvider>().selectedNav == 2 && index != 2){
            CustomAnimationController.tempAnimationController.reverse();
          }
          context.read<HomeProvider>().onChangeBottomNav(index);
        },
        selectedTab: context.watch<HomeProvider>().selectedNav,
      ),
      body: const SafeArea(child: Car()),
    );
  }
}
