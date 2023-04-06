import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Models/app_images.dart';
import 'package:tesla_clone/Models/app_sizes.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

import '../../Models/enum_door.dart';

class DoorLock extends StatelessWidget {

  final bool? isLocked;
  final Lock? door;

  const DoorLock({Key? key,this.door,this.isLocked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<HomeProvider>().updateLock(door!);
      },
      child: AnimatedSwitcher(
        duration: AppSizes.defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child,animation) {
          return ScaleTransition(
              scale: animation,
          child: child,);
        },
        child: isLocked!
        ? SvgPicture.asset(
          AppImages.unlock,
          key: const ValueKey('unlock'),
        ) : SvgPicture.asset(
          AppImages.lock,
          key: const ValueKey('lock'),
        ),
      ),
    );
  }
}
