import 'package:flutter/material.dart';
import 'package:mobileriverpod/presentation/widget/theme_notifier.dart';
import 'package:mobileriverpod/presentation/widget/themes.dart';
import 'package:provider/provider.dart';

class FeatureCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;

  const FeatureCard({
    required this.iconData,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Provider.of<ThemeProvider>(context).getTheme == darkTheme
          ? Colors.grey[800]
          : Colors.purple[50],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).getTheme == darkTheme
                    ? Colors.grey[700]
                    : Colors.purple[900],
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 40,
                color: Provider.of<ThemeProvider>(context).getTheme == darkTheme
                    ? Colors.orangeAccent
                    : Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Provider.of<ThemeProvider>(context).getTheme == darkTheme
                    ? Colors.orangeAccent
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
