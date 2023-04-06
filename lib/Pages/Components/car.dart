import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Models/app_images.dart';
import 'package:tesla_clone/Models/enum_door.dart';
import 'package:tesla_clone/Pages/Components/battery_sec.dart';
import 'package:tesla_clone/Pages/Components/lock_alignment.dart';
import 'package:tesla_clone/Pages/Components/temp_sec.dart';
import 'package:tesla_clone/Utils/custom_animation_controller.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

class Car extends StatefulWidget {
  const Car({Key? key}) : super(key: key);

  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> with SingleTickerProviderStateMixin{

  late Animation<double> _posAnimation;


  @override
  void initState() {
    CustomAnimationController.setTempAnimation(
        tickerProvider: this,
        duration: Duration(milliseconds: 600)
    );
    
    _posAnimation=CurvedAnimation(
        parent: CustomAnimationController.tempAnimationController,
        curve: Interval(0,.4)
    );

    super.initState();
  }


  @override
  void dispose() {
    CustomAnimationController.disposeTempAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return LayoutBuilder(
        builder: (context,constrains){
          context.read<HomeProvider>().constraints = constrains;
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                  animation: CustomAnimationController.tempAnimationController,
                  builder: (context,_){
                    return Transform.translate(
                        offset: Offset(_posAnimation.value * 180,0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * .1,
                        ),
                        child: SvgPicture.asset(
                          AppImages.teslaCar,
                          width: double.infinity,
                        ),),
                    );
                  }),
              LockAlign(
                door: Lock.rightDoorLock,
                isLocked: provider.rightLock,
                align: Alignment.centerRight,
              ),
              LockAlign(
                door: Lock.leftDoorLock,
                isLocked: provider.leftLock,
                align: Alignment.centerLeft,
              ),
              LockAlign(
                door: Lock.bonnetLock,
                isLocked: provider.bonnetLock,
                align: Alignment.topCenter,
              ),
              LockAlign(
                door: Lock.trunkLook,
                isLocked: provider.trunkLock,
                align: Alignment.bottomCenter,
              ),
              BatterySec(
                constraints: constrains,
              ),
              const TempSec()
            ],
          );
        });
  }
}
