import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_clone/Models/app_images.dart';
import 'package:tesla_clone/Pages/Components/battery_stats.dart';
import 'package:tesla_clone/Utils/custom_animation_controller.dart';

class BatterySec extends StatefulWidget {

  final BoxConstraints? constraints;
  const BatterySec({Key? key,this.constraints}) : super(key: key);

  @override
  State<BatterySec> createState() => _BatterySecState();
}

class _BatterySecState extends State<BatterySec> with SingleTickerProviderStateMixin{

  late Animation _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;


  @override
  void initState() {
    super.initState();
    CustomAnimationController.setBatteryAnimation(tickerProvider: this, duration: const Duration(milliseconds: 600));
    _batteryAnimation = CurvedAnimation(
        parent: CustomAnimationController.batteryAnimationController,
        curve: const Interval(0, .5));
    _batteryStatusAnimation = CurvedAnimation(
        parent: CustomAnimationController.batteryAnimationController,
        curve: const Interval(0.8, 1));
  }


  @override
  void dispose() {
    CustomAnimationController.disposeBatteryAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: CustomAnimationController.batteryAnimationController,
        builder: (context,_){
          return Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Opacity(
                    opacity: _batteryAnimation.value,
                  child: SvgPicture.asset(
                      AppImages.battery,
                    width: widget.constraints!.maxWidth * .45,
                  ),
                ),
              ),
              Positioned(
                top: 50 * (1 - _batteryStatusAnimation.value),
                  width: widget.constraints!.maxWidth,
                  height: widget.constraints!.maxHeight,
                  child: Opacity(
                    opacity: _batteryStatusAnimation.value,
                    child: BatteryStatus(
                      constraints: widget.constraints,
                    ),
                  )
              )
            ],
          );
        });
  }
}
