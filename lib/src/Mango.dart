import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;


class Mango extends StatefulWidget {
  final String tag;
  final Widget child;
  final bool transitionOnUserGestures;
  final int transition;

  const Mango({Key key, @required this.tag,this.transition =0 ,this.transitionOnUserGestures = false, @required this.child}) : super(key: key);
  @override
  _MangoState createState() => _MangoState();
}

class _MangoState extends State<Mango> {
  @override
  Widget build(BuildContext context) {

    if(widget.transition == 1){
      return mangoFadeTransition();
    }else if(widget.transition == 2){
      return mangoScaleTransition();
    }else if(widget.transition == 3){
      return mangoQuadraticOffsetTween();
    }else if(widget.transition == 4){
      return mangoMix();
    }else{
      return mangoRotationTransition();
    }


  }

  Widget mangoRotationTransition(){
    return  Hero(
      flightShuttleBuilder:  (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ) {
        Animation<double> newAnimation =  Tween<double>(begin: 0, end: 0.5).animate(animation);

        if (flightDirection == HeroFlightDirection.pop) {
          newAnimation = ReverseAnimation(newAnimation);
        }

        return RotationTransition(
          turns: animation,
          child: toHeroContext.widget,
        );
      },
      child: widget.child,
      tag: widget.tag,
      transitionOnUserGestures: widget.transitionOnUserGestures,

    );
  }

  Widget mangoFadeTransition(){
    return  Hero(
      flightShuttleBuilder:  (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ) {
        Animation<double> newAnimation =  Tween<double>(begin: 0, end: 0.5).animate(animation);

        if (flightDirection == HeroFlightDirection.pop) {
          newAnimation = ReverseAnimation(newAnimation);
        }

        return  FadeTransition(
          opacity: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0,
                    curve: ValleyQuadraticCurve()),
              ),
            ),
          ),
          child: toHeroContext.widget,
        );
      },
      child: widget.child,
      tag: widget.tag,
      transitionOnUserGestures: widget.transitionOnUserGestures,

    );
  }

  Widget mangoScaleTransition(){
    return  Hero(
      flightShuttleBuilder:  (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ) {
        Animation<double> newAnimation =  Tween<double>(begin: 0, end: 0.5).animate(animation);

        if (flightDirection == HeroFlightDirection.pop) {
          newAnimation = ReverseAnimation(newAnimation);
        }

        return   ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0,
                    curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: toHeroContext.widget,
        );
      },
      child: widget.child,
      tag: widget.tag,
      transitionOnUserGestures: widget.transitionOnUserGestures,

    );
  }


  Widget mangoMix(){
    return  Hero(
      flightShuttleBuilder:  (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ) {
        Animation<double> newAnimation =  Tween<double>(begin: 0, end: 0.5).animate(animation);

        if (flightDirection == HeroFlightDirection.pop) {
          newAnimation = ReverseAnimation(newAnimation);
        }

        return  ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0,
                    curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: flightDirection == HeroFlightDirection.push
              ? RotationTransition(
            turns: animation,
            child: toHeroContext.widget,
          )
              : FadeTransition(
            opacity: animation.drive(
              Tween<double>(begin: 0.0, end: 1.0).chain(
                CurveTween(
                  curve: Interval(0.0, 1.0,
                      curve: ValleyQuadraticCurve()),
                ),
              ),
            ),
            child: toHeroContext.widget,
          ),
        );
      },
      child: widget.child,
      tag: widget.tag,
      transitionOnUserGestures: widget.transitionOnUserGestures,

    );
  }


  Widget mangoQuadraticOffsetTween(){
    return  Hero(
     createRectTween: (rect1, rect2) => RectTween(begin: rect1, end: rect2),
      child: widget.child,
      tag: widget.tag,
      transitionOnUserGestures: widget.transitionOnUserGestures,

    );
  }

}
  class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
  assert(t >= 0.0 && t <= 1.0);
  return 4 * math.pow(t - 0.5, 2);
  }
  }


class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * math.pow(t, 2) + 15 * t + 1;
  }
}


class QuadraticOffsetTween extends Tween<Offset> {

  QuadraticOffsetTween({
    Offset begin,
    Offset end,
  }) : super(begin: begin, end: end);


  @override
  Offset lerp(double t) {
    if (t == 0.0)
      return begin;
    if (t == 1.0)
      return end;
    final double x = -11 * begin.dx * math.pow(t, 2) +
        (end.dx + 10 * begin.dx) * t + begin.dx;
    final double y = -2 * begin.dy * math.pow(t, 2) +
        (end.dy + 1 * begin.dy) * t + begin.dy;
    return Offset(x, y);
  }
}





