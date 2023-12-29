import 'package:flutter/material.dart';

class DashbordState {
  static Material dashboardCard(IconData icon, title, color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.cyan,
      borderRadius: BorderRadius.circular(20.0),
      child: ElevatedButton(
        onPressed: () => {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Text
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: Text(
                        "$title",
                        style: TextStyle(color: Color(color), fontSize: 15.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
