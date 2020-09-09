import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/screen/screen_photo_preview.dart';

class PhotoPreview extends StatelessWidget {
  final List<MediaFile> files;
  PhotoPreview(this.files);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      margin: EdgeInsets.all(12),
      child: files.length == 0
          ? Center(
              child: Text(
                "No media files found!",
                style: getCaptionTextStyle(
                  context,
                ),
              ),
            )
          : GridView.count(
              childAspectRatio: 4 / 3,
              crossAxisCount: 2,
              physics: ScrollPhysics(),
              children: files
                  .map(
                    (e) => InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ViewPhotoScreen().routeName,
                            arguments: e.url);
                      },
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0), color: Colors.grey.shade100)
                        ]),
                        margin: EdgeInsets.all(2),
                        child: Hero(
                          tag: e.url,
                          child: CachedNetworkImage(
                            imageUrl: e.url,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
