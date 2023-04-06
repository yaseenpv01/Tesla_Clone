import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Models/app_images.dart';
import 'package:tesla_clone/Pages/Components/temp_status.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

import '../../Utils/custom_animation_controller.dart';

class TempSec extends StatefulWidget {
  const TempSec({Key? key}) : super(key: key);

  @override
  State<TempSec> createState() => _TempSecState();
}

class _TempSecState extends State<TempSec> with SingleTickerProviderStateMixin{

  late AnimationController heatAnimationController;
  late Animation _opacityAnimation;
  late Animation heatAnimation;
  late AnimationController coolAnimationController;
  late Animation coolAnimation;
  late Animation opacityAnimation;
  late Animation<double> posAnimation;


  @override
  void initState() {
    _opacityAnimation = CurvedAnimation(
      parent: CustomAnimationController.tempAnimationController,
      curve: const Interval(.6, 1),
    );

    posAnimation = CurvedAnimation(
      parent: CustomAnimationController.tempAnimationController,
      curve: const Interval(.6, 1),
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
    var _provider = context.read<HomeProvider>();
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [CustomAnimationController.tempAnimationController,_provider]
        ),
        builder: (context,_){
          return Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: _provider.isCool
                  ? Image.asset(
                    AppImages.cool,
                    key: const ValueKey('cool'),
                  )
                  : Image.asset(
                      AppImages.heat,
                    key: const ValueKey('hot'),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: (1-posAnimation.value)*50),
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: TempStatus(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
