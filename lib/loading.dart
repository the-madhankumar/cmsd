import 'package:cmsd_home/screen_1/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Add a delay to simulate loading
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the new page after the loading animation completes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 174, 0), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: CircularPercentIndicator(
                  animation: true,
                  animationDuration: 3500,
                  radius: 40,
                  lineWidth: 7,
                  percent: 1.0,
                  progressColor: const Color.fromARGB(255, 255, 69, 0), // Orange color
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255), // White color
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final int dotCount = (_controller.value * 5).toInt() + 1;
                  final List<Widget> dots = List.generate(5, (index) {
                    return Text(
                      index < dotCount ? '.   ' : '   ',
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                    );
                  });
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: dots,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
