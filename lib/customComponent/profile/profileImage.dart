import 'package:flutter/material.dart';
import 'package:edutok/Data/userData.dart'; // Import the UserData class

Widget profileSection() {
  return FutureBuilder<List<dynamic>>(
    future: UserData().getData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While data is loading, you can show a loading indicator or placeholder
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Handle error if there's an issue with fetching data
        return Text('Error: ${snapshot.error}');
      } else {
        // Data has been fetched successfully
        List<dynamic> data = snapshot.data ?? [];
        print(data);
        String? userID = data.isNotEmpty ? data[0] : null;
        String? accessToken = data.isNotEmpty ? data[1] : null;
        String? uname = data.isNotEmpty ? data[3] : null;

        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/Tabloid.png'),
                  radius: 50.0,
                ),
                SizedBox(height: 20),
                Text(uname.toString()),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "233k",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " Following"),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "14k",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " Followers"),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "233k",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " Like"),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}
