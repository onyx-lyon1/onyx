import 'package:flutter/material.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.menuCrous,
  });

  final MenuCrous menuCrous;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          menuCrous.type.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 23.sp, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 0.2.h,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        for (PlatCrous platCrous in menuCrous.plats)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                platCrous.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Text(
                platCrous.variants.join("\n"),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
      ],
    );
  }
}
