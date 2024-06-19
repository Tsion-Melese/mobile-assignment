import 'package:flutter/material.dart';
import 'package:mobileriverpod/presentation/Widget/theme_notifier.dart';
import 'package:mobileriverpod/presentation/Widget/themes.dart';
import 'package:provider/provider.dart';

class TorchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        Provider.of<ThemeProvider>(context).getTheme == darkTheme;
    Color iconColor = isDarkTheme ? Colors.white : Colors.yellow[900]!;
    IconData iconData = isDarkTheme ? Icons.brightness_3 : Icons.wb_sunny;

    return IconButton(
      icon: Icon(iconData),
      color: iconColor,
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).changeTheme();
      },
    );
  }
}
