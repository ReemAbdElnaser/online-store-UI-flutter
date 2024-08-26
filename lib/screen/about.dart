import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('About Our Store'),
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App logo and name
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/n.png', // Ensure you have a logo image in the assets
                    height: 100.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Welcome to Online Stor!',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Description
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'ShopEasy is your go-to app for a seamless shopping experience. Explore a wide range of products, enjoy exclusive deals, and get them delivered right to your doorstep.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            // Version info
            Text(
              'Version',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '1.0.0',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            // Contact info
            Text(
              'Contact Us',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                // Implement email client launch
              },
              child: Text(
                'support@shopOnline.com',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.blue[800],
                  fontSize: 16.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
