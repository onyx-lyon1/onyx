import 'package:flutter/material.dart';

class CustomHeroWidget extends StatelessWidget {
  const CustomHeroWidget(
      {Key? key,
      required this.tag,
      required this.beginColor,
      required this.child,
      required this.endColor})
      : super(key: key);
  final String tag;
  final Widget child;
  final Color beginColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: tag,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          final Hero toHero = toHeroContext.widget as Hero;

          final MediaQueryData? toMediaQueryData =
              MediaQuery.maybeOf(toHeroContext);
          final MediaQueryData? fromMediaQueryData =
              MediaQuery.maybeOf(fromHeroContext);

          if (toMediaQueryData == null || fromMediaQueryData == null) {
            return toHero.child;
          }

          final EdgeInsets fromHeroPadding = fromMediaQueryData.padding;
          final EdgeInsets toHeroPadding = toMediaQueryData.padding;

          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: toMediaQueryData.copyWith(
                  padding: (flightDirection == HeroFlightDirection.push)
                      ? EdgeInsetsTween(
                          begin: fromHeroPadding,
                          end: toHeroPadding,
                        ).evaluate(animation)
                      : EdgeInsetsTween(
                          begin: toHeroPadding,
                          end: fromHeroPadding,
                        ).evaluate(animation),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (flightDirection == HeroFlightDirection.push)
                        ? ColorTween(
                            begin: beginColor,
                            end: endColor,
                          ).evaluate(animation)
                        : ColorTween(
                            begin: endColor,
                            end: beginColor,
                          ).evaluate(animation),
                  ),
                ),
              );
            },
          );
        },
        child: child);
  }
}
