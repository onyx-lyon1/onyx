import 'package:auto_size_text/auto_size_text.dart';
import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class EnumerationWidget extends StatelessWidget {
  const EnumerationWidget({Key? key, required this.enumeration})
      : super(key: key);

  final Enumeration enumeration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11.h,
      width: 90.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.h,
                  width: 45.w,
                  child: Text(
                    enumeration.title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                  width: 45.w,
                  child: Text(
                    "${enumeration.author}\n${enumeration.comment}",
                    maxLines: 3,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 7.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40.w,
            margin: EdgeInsets.only(right: 2.w, top: 2.w, bottom: 2.w),
            // padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedPadding(
                      duration: Res.animationDuration,
                      padding: EdgeInsets.only(
                        left: (constraints.maxWidth /
                                enumeration.values.length) *
                            enumeration.values.indexOf(
                                enumeration.value ?? enumeration.values.first),
                      ),
                      child: Container(
                        height: 10.h,
                        width: constraints.maxWidth / enumeration.values.length,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i in enumeration.values)
                      Flexible(
                        fit: FlexFit.tight,
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            onTap: () {
                              context
                                  .read<TomussCubit>()
                                  .updateEnumerationValue(
                                    enumeration,
                                    i,
                                  );
                            },
                            child: Container(
                              height: 10.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: AutoSizeText(
                                i,
                                minFontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
