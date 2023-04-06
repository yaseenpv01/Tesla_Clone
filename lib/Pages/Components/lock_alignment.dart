import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla_clone/Models/app_sizes.dart';
import 'package:tesla_clone/Models/enum_door.dart';
import 'package:tesla_clone/Pages/Components/doorlock.dart';
import 'package:tesla_clone/Utils/provider_main.dart';

class LockAlign extends StatelessWidget {

  final DoorLock? child;
  final Lock? door;
  final bool? isLocked;
  final Alignment? align;

  const LockAlign({Key? key,this.child,this.door,this.isLocked,this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BoxConstraints constraints = context.read<HomeProvider>().constraints;
    return AnimatedPositioned(
      right: align == Alignment.centerRight ?
      context.watch<HomeProvider>().selectedNav == 0
        ? constraints.maxWidth * 0.3
        : constraints.maxWidth / 2
        : null,
        left: align == Alignment.centerLeft ?
        context.watch<HomeProvider>().selectedNav == 0
            ? constraints.maxWidth * 0.3
            : constraints.maxWidth / 2
            : null,
        top: align == Alignment.topCenter ?
        context.watch<HomeProvider>().selectedNav == 0
            ? constraints.maxWidth * 0.13
            : constraints.maxWidth / 2
            : null,
        bottom: align == Alignment.bottomCenter ?
        context.watch<HomeProvider>().selectedNav == 0
            ? constraints.maxWidth * 0.17
            : constraints.maxWidth / 2
            : null,
        child: AnimatedOpacity(
          opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 :0,
          duration: AppSizes.defaultDuration,
          child: DoorLock(
            door: door,
            isLocked: isLocked,
          ),
        ),
        duration: AppSizes.defaultDuration);
  }
}
