import 'package:delern_flutter/flutter/localization.dart' as localizations;
import 'package:delern_flutter/flutter/styles.dart' as app_styles;
import 'package:delern_flutter/flutter/user_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pedantic/pedantic.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportDevelopment extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(
              localizations.of(context).navigationDrawerSupportDevelopment)),
      body: Builder(
        builder: (context) => Markdown(
            data: localizations.of(context).supportDevelopment,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(p: app_styles.primaryText),
            onTapLink: (href) async {
              if (await canLaunch(href)) {
                await launch(href, forceSafariVC: false);
              } else {
                unawaited(UserMessages.showError(
                    () => Scaffold.of(context), 'Could not launch url $href'));
              }
            }),
      ));
}
