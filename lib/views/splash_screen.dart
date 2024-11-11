
import 'package:eccomerce/views/bottom_navexample.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const BottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(height: double.infinity,width: double.infinity,
          decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(0.97), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset('assets/background.jpeg', fit: BoxFit.cover,),

            ),

          ),
            //  Container(height: double.infinity,width:double.infinity,decoration: const BoxDecoration(color: Colors.grey),child: const Image(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover,), ),
             Positioned(
              top: MediaQuery.sizeOf(context).height*0.35,
               child: SizedBox(
                         height: MediaQuery.sizeOf(context).height*0.25,
                         width: MediaQuery.sizeOf(context).width,
                         child: const Image(image: AssetImage('assets/favicon.png')),
                       ),
             ),],
      ),
    );
  }
}
