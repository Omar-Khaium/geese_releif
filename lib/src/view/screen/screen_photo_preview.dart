import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

class ViewPhotoScreen extends StatelessWidget {
  final String routeName = "/photo_preview";

  @override
  Widget build(BuildContext context) {
    MediaFile file = ModalRoute.of(context).settings.arguments as MediaFile;
    return Hero(
      tag: file.url,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: file.url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                left: 16,
                top: MediaQuery.of(context).padding.top + 4,
                child: Container(
                  height: 64,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white10,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        FontAwesomeIcons.times,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.95),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0),
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: Text(
                          file.uploadedBy,
                          style: getDefaultTextStyle(context).copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Visibility(
                        visible: (file.caption ?? "").isNotEmpty,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.closed_caption,
                            color: Colors.white,
                          ),
                          title: Text(
                            file.caption ?? "",
                            style: getDefaultTextStyle(context).copyWith(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0),
                        leading: Icon(
                          Icons.event,
                          color: Colors.white,
                        ),
                        title: Text(
                          dateTimeToFriendlyTime(stringToDateTime(file.date), "hh:mm a"),
                          style: getDefaultTextStyle(context).copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
