import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: _controller,
              children: const [
                FadeInImage(
                  placeholder: AssetImage('assets/images/trmlogo.png'),
                  image: AssetImage('assets/images/bg_image2.jpeg'),
                  fit: BoxFit.cover,
                ),
                FadeInImage(
                  placeholder: AssetImage('assets/images/trmlogo.png'),
                  image: AssetImage('assets/images/bg_image2.jpeg'),
                  fit: BoxFit.cover,
                ),
                // Add more images as needed

                FadeInImage(
                  placeholder: AssetImage('assets/images/trmlogo.png'),
                  image: AssetImage('assets/images/bg_image3.jpeg'),
                  fit: BoxFit.cover,
                ),
              ],
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        // color: Theme.of(context).primaryColor,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.5),
                              Theme.of(context).primaryColor.withOpacity(0.3),
                              Theme.of(context).primaryColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/trmlogo.png',
                              height: 300,
                              width: 200,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.8,
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width / 1.2,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WELCOME TO TRAVEL MONKEY',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'All you need to do is to register and start',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.3),
                      Theme.of(context).primaryColor.withOpacity(0.5),
                      Theme.of(context).primaryColor,
                    ],
                  ),
                ),
                // color:
                //     const Color.fromARGB(255, 212, 203, 203).withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 10.h),
                          textStyle: Theme.of(context).textTheme.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Get started',
                            style: Theme.of(context).textTheme.button),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // child: Scaffold(
      //     backgroundColor: Theme.of(context).primaryColor,
      //     body: Container(
      //       height: MediaQuery.of(context).size.height,
      //       width: MediaQuery.of(context).size.width,
      //       decoration: const BoxDecoration(
      //           // color: Theme.of(context).primaryColor,

      //           image: DecorationImage(
      //         image: AssetImage('assets/images/logo.jpeg'),
      //         fit: BoxFit.cover,
      //       )),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Image.asset(
      //             'assets/images/logo.jpeg',
      //             height: 200,
      //             width: 200,
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.pushNamed(context, '/login');
      //             },
      //             child: const Text('Login'),
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.pushNamed(context, '/registration');
      //             },
      //             child: const Text('Register'),
      //           ),
      //         ],
      //       ),
      //     )),
    );
  }
}
