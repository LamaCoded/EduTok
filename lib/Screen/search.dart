import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edutok/Data/Path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Movie {
  final String movieTitle;

  Movie(this.movieTitle);
}

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio dio = Dio();
  bool result = false;
  List<Movie> movieList = [];
  List<String> queryList = [];
  Future<void> _handleSearch(BuildContext context, String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    print("Searching for: $query");
    queryList.add(query);
    try {
      print('Authorization Token:$token');
      dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response<dynamic> response =
          await dio.get('http://${basepath}:4000/search/$query');
      print("*****************************");
      print('Original Title:${response.data[0]['orginal_title']}');
      print("*****************************");
      movieList.clear();

      for (int i = 0; i < response.data.length; i++) {
        String orginalTitle = response.data[i]['orginal_title'];
        Movie movie = Movie(orginalTitle);
        movieList.add(movie);
      }

      setState(() {
        result = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
          );
        },
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (query) {},
                onSubmitted: (query) {
                  _handleSearch(context, query);
                },
                decoration: InputDecoration(
                  hintText: 'Search on EduTok',
                  prefixIcon: Icon(Icons.more_horiz),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                final query = _searchController.text;
                _handleSearch(context, query);
              },
            ),
          ],
        ),
        body: result == true
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      mainAxisSpacing: 8.0, // Spacing between rows
                      crossAxisSpacing: 8.0, // Spacing between columns
                      childAspectRatio: 1.0, // Aspect ratio of each grid item
                    ),
                    itemCount: movieList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GridTile(
                        child: Container(
                          height: 400,
                          width: 180,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              movieList[index].movieTitle,
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
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: queryList == null
                    ? Center(child: Text("No search queries"))
                    : ListView.builder(
                        itemCount: queryList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(queryList![index]),
                            trailing: Icon(Icons.link_rounded),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
