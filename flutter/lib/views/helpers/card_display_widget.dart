import 'package:delern_flutter/flutter/styles.dart' as app_styles;
import 'package:delern_flutter/views/helpers/non_scrolling_markdown.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CardDisplayWidget extends StatelessWidget {
  final String front;
  final String back;
  final bool showBack;
  final Color backgroundColor;
  final bool isMarkdown;
  final List<String> frontImages;
  final List<String> backImages;

  const CardDisplayWidget(
      {@required this.front,
      @required this.back,
      @required this.showBack,
      @required this.backgroundColor,
      @required this.isMarkdown,
      @required this.frontImages,
      @required this.backImages});

  @override
  Widget build(BuildContext context) => Card(
        color: backgroundColor,
        margin: const EdgeInsets.all(8),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: _buildCardBody(context),
        ),
      );

  List<Widget> _buildCardBody(BuildContext context) {
    final widgetList = [
      _sideText(front, context),
      _buildImageList(frontImages),
    ];

    if (showBack) {
      widgetList
        ..add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(height: 1),
        ))
        ..add(_sideText(back, context))
        ..add(_buildImageList(backImages));
    }

    return widgetList;
  }

  Widget _buildImageList(List<String> images) {
    if (images == null || images.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          for (String imageUrl in images)
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageUrl,
            )
        ],
      ),
    );
  }

  Widget _sideText(String text, BuildContext context) {
    if (isMarkdown) {
      return buildNonScrollingMarkdown(text, context);
    }
    return Text(
      text,
      textAlign: TextAlign.center,
      style: app_styles.primaryText,
    );
  }
}
