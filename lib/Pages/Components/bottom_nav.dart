import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_clone/Models/app_images.dart';
import 'package:tesla_clone/Utils/app_colors.dart';

class BottomNav extends StatelessWidget {

  final ValueChanged<int>? onTap;
  final int? selectedTab;
  const BottomNav({Key? key, this.onTap,this.selectedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: onTap,
        currentIndex: selectedTab!,
        items: List.generate(
            AppImages().bottomItems.length,
                (index) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages().bottomItems[index],
                      color: index == selectedTab ? AppColors.primaryColor : Colors.white,
                ),
                  label: '',
                )
        )
    );
  }
}
