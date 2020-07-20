import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhotoScreen extends StatelessWidget {
  final String routeName = "/photo_preview";

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments as String;
    return Hero(
      tag: url,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(url, scale: 1),
              ),
              Positioned(
                top: 24,
                left: 16,
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(FontAwesomeIcons.times, color: Colors.white, size: 18,),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
