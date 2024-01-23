import 'package:cmsd_home/screen_1/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(right: 90.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Lottie.network(
                    'https://lottie.host/9be4b262-7abf-4ccb-9e03-497bf91867e5/rvwAugxJFj.json',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                    repeat: true,
                    controller: _controller,
                  ),
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final int dotCount = (_controller.value * 5).toInt() + 1;
                    final List<Widget> dots = List.generate(5, (index) {
                      return Text(
                        index < dotCount ? '.   ' : '   ',
                        style: const TextStyle(
                            fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
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
          Container(
            height: 50,
            color: Color.fromARGB(255, 0, 0, 0),
            alignment: Alignment.center,
            child: const Text(
              'CMSD Agri Tech',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
