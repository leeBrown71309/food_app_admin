import 'package:allo_thieb/help/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class OnHoverButton extends StatefulWidget {
  const OnHoverButton({required this.child});
  final Widget child;
  @override
  _OnHoverButtonState createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..translate(0,8);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event)=> onEntered(true),
        onExit: (event)=> onEntered(false),
        child: AnimatedContainer(
            duration: Duration(
                milliseconds: 200,),
            transform: transform,
            child: widget.child)
    );
  }

  void onEntered(bool isHovered) => setState((){
    this.isHovered = isHovered;
  });
}

//***************************************************************


class OnHoverText extends StatefulWidget {
  const OnHoverText({required this.child});
  final Widget child;
  @override
  _OnHoverTextState createState() => _OnHoverTextState();
}

class _OnHoverTextState extends State<OnHoverText> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event)=> onEntered(true),
        onExit: (event)=> onEntered(false),
        child: AnimatedContainer(
          curve: Sprung.overDamped,
            duration: Duration(
              milliseconds: 200,),
            transform: transform,
            child: widget.child)
    );
  }

  void onEntered(bool isHovered) => setState((){
    this.isHovered = isHovered;
  });
}


//***************************************************************


class OnHoverCard extends StatefulWidget {
  const OnHoverCard({required this.child});
  final Widget child;
  @override
  _OnHoverCardState createState() => _OnHoverCardState();
}

class _OnHoverCardState extends State<OnHoverCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1,0.9);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event)=> onEntered(true),
        onExit: (event)=> onEntered(false),
        child: AnimatedContainer(
            curve: Sprung.overDamped,
            duration: Duration(
              milliseconds: 200,),
            transform: transform,
            child: widget.child)
    );
  }

  void onEntered(bool isHovered) => setState((){
    this.isHovered = isHovered;
  });
}


