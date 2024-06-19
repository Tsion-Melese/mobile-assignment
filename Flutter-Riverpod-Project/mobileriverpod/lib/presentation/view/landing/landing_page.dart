import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkTheme
            ? null
            : LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: Scaffold(
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.transparent,
        appBar: AppBar(
          backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.transparent,
          title: Center(
            child: Text(
              'Welcome to Job Finder!',
              style: TextStyle(
                color: isDarkTheme ? Colors.orange[800] : Colors.purple[800],
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          actions: [
            TorchWidget(),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Discover your dream job today :)',
                        style: TextStyle(
                          fontSize: 20,
                          color: isDarkTheme ? Colors.orangeAccent : Colors.purple[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          FeatureCard(
                            iconData: Icons.work,
                            title: 'Jobs',
                            onTap: () {},
                          ),
                          FeatureCard(
                            iconData: Icons.message,
                            title: 'Messages',
                            onTap: () {},
                          ),
                          FeatureCard(
                            iconData: Icons.account_balance_wallet,
                            title: 'Salary',
                            onTap: () {},
                          ),
                          FeatureCard(
                            iconData: Icons.location_on,
                            title: 'Locations',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  isDarkTheme ? Colors.orange[800]! : Colors.purple[900]!,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Let\'s Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkTheme ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                context.go('/admin-login'); // Update this to your admin login route if needed
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkTheme ? Colors.white : Colors.purple[900],
                  ),
                  children: [
                    TextSpan(
                      text: 'Are you an admin? ',
                      style: TextStyle(
                        color: isDarkTheme ? Colors.orange : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isDarkTheme ? Colors.grey[800] : Colors.purple[50],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.grey[700] : Colors.purple[900],
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 40,
                color: isDarkTheme ? Colors.orangeAccent : Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.orangeAccent : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TorchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color iconColor = isDarkTheme ? Colors.white : Colors.yellow[900]!;
    IconData iconData = isDarkTheme ? Icons.brightness_3 : Icons.wb_sunny;

    return IconButton(
      icon: Icon(iconData),
      color: iconColor,
      onPressed: () {},
    );
  }
}
