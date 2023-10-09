import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  Future<List<dynamic>> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userId')!;
    String acessToken = prefs.getString('token')!;
    int isPrivate = prefs.getInt('isPrivate')!;
    return [userID, acessToken, isPrivate];
  }
}
