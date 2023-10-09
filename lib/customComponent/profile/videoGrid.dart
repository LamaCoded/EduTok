import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Data/Path.dart';

Widget videoGrid(BuildContext context, int? tab) {
  int? tabValue = tab;
  print(tabValue);
  final dio = Dio();

  Future<List<dynamic>> likedVideo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tabValue == 1 && tabValue != null) {
      try {
        String token = prefs.getString('token')!;
        print(token);
        dio.options.headers['Authorization'] = 'Bearer ${token}';
        Response<dynamic> response =
            await dio.get("http://${basepath}:4000/like");
        print("from 0:${response.data}");
        return response.data;
      } catch (e) {
        print(e.toString());
        // You can throw a custom exception here or return an empty list to handle errors.
      }
    }
    // Return an empty list if tabValue != 0 or is null.
    return [];
  }

  return tabValue == 0
      ? SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns in the grid
              mainAxisSpacing: 8.0, // Spacing between rows
              crossAxisSpacing: 8.0, // Spacing between columns
              childAspectRatio: 1.0, // Aspect ratio of each grid item
            ),
            itemCount: 45,
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                child: Container(
                  height: 300,
                  width: 150,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      : SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            // Add the future: likedVideo() here
            future: likedVideo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                // Handle the error UI here.
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                List<dynamic> data = snapshot.data!;
                int dataLength = data.length;
                print("data length: $dataLength");
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns in the grid
                    mainAxisSpacing: 8.0, // Spacing between rows
                    crossAxisSpacing: 8.0, // Spacing between columns
                    childAspectRatio: 1.0, // Aspect ratio of each grid item
                  ),
                  itemCount: dataLength,
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                      child: Container(
                        height: 300,
                        width: 150,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              // Return the GridView here based on the data.
              else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
}
