// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
        actions: [
          Text('Skip'),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 60),
        child: PageView(
          children: [
            Container(
              child: Image.network("https://images.pexels.com/photos/17927266/pexels-photo-17927266/free-photo-of-light-dawn-landscape-sunset.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
              fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.network("https://images.pexels.com/photos/17334891/pexels-photo-17334891/free-photo-of-woman-posing-with-horse.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.network("https://images.pexels.com/photos/17908421/pexels-photo-17908421/free-photo-of-model-in-wide-jeans.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: 80,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Signup',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
