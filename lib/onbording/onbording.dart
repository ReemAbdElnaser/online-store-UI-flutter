import 'package:flutter/material.dart';
import 'package:project_app/registration/register.dart';
import 'package:project_app/registration/login.dart';



class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _goToNextPage() {
    if (_pageController.page!.toInt() < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          OnboardingPage(
            title: 'Welcome to Our Online Store',
            description: 'Discover a wide range of products tailored to your needs.',
            image: 'assets/R (1).png',
            onNext: _goToNextPage,
          ),
          OnboardingPage(
            title: 'How It Works',
            description: 'Browse through our products, add to cart, and enjoy easy checkout.',
            image: 'assets/R (3).png',
            onNext: _goToNextPage,
          ),
          OnboardingPage(
            title: 'Get Started Now!',
            description: '  Register or log in to start shopping.',
            image: 'assets/R (2).png',
            onNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _currentPage == 2
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 16), 
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
                            },
                            child: const  Text(
                              'LogIn',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Space between buttons
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 69, 33, 199),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => RegisterScreen()),
                (Route<dynamic> route) => false,
              );
                            },
                            child:const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final VoidCallback onNext;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, width: 300, height: 300),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          if (title != 'Get Started Now!') 
            ElevatedButton(
              onPressed: onNext,
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.teal, 
              
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                ),
                padding: EdgeInsets.symmetric(vertical: 14), 
              ),
            ),
        ],
      ),
    );
  }
}





