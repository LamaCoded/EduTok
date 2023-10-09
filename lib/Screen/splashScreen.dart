import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(color: Color.fromARGB(99, 186, 7, 199)),
          height: MediaQuery.of(Context).size.height,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 0,
              ),
              Image.asset(
                "images/Tabloid.png",
                height: 600,
                width: 600,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "version 1.0",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ))),
    );
  }
}
