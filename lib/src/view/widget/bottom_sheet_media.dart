import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/view/screen/screen_photo_preview.dart';

class PhotoPreview extends StatelessWidget {
  final List<MediaFile> files = [
    MediaFile(
        "Good Fon",
        "https://img4.goodfon.com/wallpaper/nbig/6/f4/ptitsa-gus-fon.jpg",
        "04/15/2020"),
    MediaFile(
        "Canadian geese ducks",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSbqAYGS33uXAd29Jpr37IQekrereYrM4BGFKz9IJNoZTmgEU_a&usqp=CAU",
        "04/14/2020"),
    MediaFile(
        "Goose Window 7",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQecs0BvLZBlBVPqs5eDH2c7ah1Mcb-pd74z58Y7mWkBcPs2P1V&usqp=CAU",
        "04/14/2020"),
    MediaFile(
        "Goose Face",
        "https://wallup.net/wp-content/uploads/2018/10/04/136493-duck-goose-geese-face-funny-748x561.jpg",
        "04/14/2020"),
    MediaFile(
        "Mallard Bird",
        "https://c4.wallpaperflare.com/wallpaper/212/423/765/red-leaf-plant-selective-photography-wallpaper-preview.jpg",
        "04/14/2020"),
    MediaFile(
        "Barbara Gesse",
        "https://wallup.net/wp-content/uploads/2018/10/07/996679-geese-street-lights-two-animals-wallpapers-748x499.jpg",
        "04/12/2020"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: EdgeInsets.all(12),
      child: GridView.count(
        childAspectRatio: 4 / 3,
        crossAxisCount: 2,
        physics: ScrollPhysics(),
        children: files
            .map(
              (e) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ViewPhotoScreen().routeName, arguments: e.url);
                },
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(offset: Offset(0, 0), color: Colors.grey.shade100)
                  ]),
                  margin: EdgeInsets.all(2),
                  child: Hero(
                    tag: e.url,
                    child: Image.network(
                      e.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
