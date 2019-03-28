import 'dart:math';
import 'package:delern_flutter/flutter/styles.dart';
import 'package:delern_flutter/views/helpers/non_scrolling_markdown.dart';
import 'package:flutter/material.dart';

typedef onFlipCallback = void Function(bool backshown);

class CardDisplayWidget extends StatefulWidget {
  final String front;
  final String back;
  final bool showBack;
  final Color backgroundColor;
  final bool isMarkdown;
  final onFlipCallback onFlip;

  const CardDisplayWidget(
      {@required this.front,
      @required this.back,
      @required this.showBack,
      @required this.backgroundColor,
      @required this.isMarkdown,
      this.onFlip});

  @override
  _CardDisplayWidgetState createState() => _CardDisplayWidgetState();
}

class _CardDisplayWidgetState extends State<CardDisplayWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  bool backshown = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -pi / 2), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: pi / 2, end: 0.0), weight: 0.5)
    ]).animate(_controller);
  }

  void _startAnimation() {
    if (!mounted) {
      return;
    }
    if (backshown) {
      _controller.reverse();
      backshown = false;
    } else {
      _controller.forward();
      backshown = true;
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                child: GestureDetector(
                  onTap: () {
                    _startAnimation();
                    if (widget.onFlip != null) {
                      widget.onFlip(backshown);
                    }
                  },
                  child: IndexedStack(
                    children: <Widget>[
                      _buildCard(widget.backgroundColor),
                      _buildCard(widget.backgroundColor)
                    ],
                    index: _controller.value < 0.5 ? 0 : 1,
                    alignment: Alignment.center,
                  ),
                ),
              ),
        ),
      );

  Widget _buildCard(Color backgroundcolor) => Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Card(
        color: backgroundcolor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 50.0,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20.0),
            children: _buildCardBody(context),
          ),
        ),
      ));

  List<Widget> _buildCardBody(BuildContext context) {
    var widgetList = [
      _sideText(widget.front, context),
    ];

    if (widget.showBack) {
      widgetList = [_sideText(widget.back, context)];
    }

    return widgetList;
  }

  Widget _sideText(String text, BuildContext context) {
    if (widget.isMarkdown) {
      return buildNonScrollingMarkdown(text, context);
    }
    return Text(
      text,
      // textAlign: TextAlign.center,
      style: AppStyles.primaryText,
    );
  }
}
