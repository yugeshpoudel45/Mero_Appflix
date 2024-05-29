import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyListHelper {
  static Future<void> addToMovieList(List<String> movieList) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> movieId = prefs1.getStringList('movieId') ?? [];
    List<String> movieImage = prefs1.getStringList('movieImage') ?? [];
    movieId.add(movieList[0]);
    movieImage.add(movieList[1]);
    await prefs1.setStringList('movieId', movieId);
    await prefs1.setStringList('movieImage', movieImage);
    log('Movie Added to List');
    Fluttertoast.showToast(
      msg: 'Added to List!',
      backgroundColor: Colors.green,
    );
  }

  static Future<List<List<String>>> getMovieList() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> movieId = prefs1.getStringList('movieId') ?? [];
    List<String> movieImage = prefs1.getStringList('movieImage') ?? [];
    List<List<String>> movieList = [
      movieId,
      movieImage,
    ];
    log('Movie List fetched');
    return movieList;
  }

  static Future<void> clearMovieList() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    await prefs1.remove('movieId');
    await prefs1.remove('movieImage');
    log('Movie List Cleared');
  }

  static Future<void> removeFromMovieList(String id) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> movieId = prefs1.getStringList('movieId') ?? [];
    List<String> movieImage = prefs1.getStringList('movieImage') ?? [];
    String image = movieImage.elementAt(movieId.indexOf(id));
    Future.wait([
      prefs1.setStringList('movieId', movieId..remove(id)),
      prefs1.setStringList('movieImage', movieImage..remove(image)),
      Fluttertoast.showToast(
        msg: 'Removed from List!',
        backgroundColor: Colors.red,
      ),
    ]);
    log('Movie Removed from List');
  }

  //For Tv Shows List
  static Future<void> addToTvShowList(List<String> tvShowList) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> tvShowId = prefs1.getStringList('tvShowId') ?? [];
    List<String> tvShowImage = prefs1.getStringList('tvShowImage') ?? [];
    tvShowId.add(tvShowList[0]);
    tvShowImage.add(tvShowList[1]);
    await prefs1.setStringList('tvShowId', tvShowId);
    await prefs1.setStringList('tvShowImage', tvShowImage);
    log('Tv Show Added to List');
    Fluttertoast.showToast(
      msg: 'Added to List!',
      backgroundColor: Colors.green,
    );
  }

  static Future<List<List<String>>> getTvShowList() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> tvShowId = prefs1.getStringList('tvShowId') ?? [];
    List<String> tvShowImage = prefs1.getStringList('tvShowImage') ?? [];
    List<List<String>> tvShowList = [
      tvShowId,
      tvShowImage,
    ];
    log('Tv Show List fetched');
    return tvShowList;
  }

  static Future<void> clearTvShowList() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    await prefs1.remove('tvShowId');
    await prefs1.remove('tvShowImage');
    log('Tv Show List Cleared');
  }

  static Future<void> removeFromTvShowList(String id) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> tvShowId = prefs1.getStringList('tvShowId') ?? [];
    List<String> tvShowImage = prefs1.getStringList('tvShowImage') ?? [];
    String image = tvShowImage.elementAt(tvShowId.indexOf(id));
    Future.wait([
      prefs1.setStringList('tvShowId', tvShowId..remove(id)),
      prefs1.setStringList('tvShowImage', tvShowImage..remove(image)),
      Fluttertoast.showToast(
        msg: 'Removed from List!',
        backgroundColor: Colors.red,
      )
    ]);
    log('Tv Show Removed from List');
  }

  static Future<bool> movieExists(String id) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> movieId = prefs1.getStringList('movieId') ?? [];
    return movieId.contains(id);
  }

  static Future<bool> tvShowExists(String id) async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> tvShowId = prefs1.getStringList('tvShowId') ?? [];
    return tvShowId.contains(id);
  }
}
