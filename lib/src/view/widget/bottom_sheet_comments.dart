import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/comment.dart';
import 'package:geesereleif/src/model/organized_comments.dart';
import 'package:geesereleif/src/view/util/helper.dart';

// ignore: must_be_immutable
class CommentsPreview extends StatelessWidget {
  final List<Comment> comments = [
    Comment("Paving", "04/14/2020 09:30 PM"),
    Comment("Two goslings", "04/12/2020 06:00 PM"),
    Comment(
        "could not get them to leave. Jack would not swim more than 10 ft before turning around.",
        "04/12/2020 11:13 AM"),
    Comment("could not get them to leave, just hiding", "04/12/2020 10:50 AM"),
    Comment("goose does not leave. dog will not swim.", "04/11/2020 09:30 PM"),
    Comment("goose does not leave. dog will not swim.", "04/11/2020 09:29 PM"),
    Comment("4 would not leave, do swam for 20 minutes", "04/10/2020 11:30 PM"),
  ];

  List<OrganizedComments> list = [];

  @override
  Widget build(BuildContext context) {
    organizeCommentAsDate();

    return Container(
      height: MediaQuery.of(context).size.height*.5,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          OrganizedComments item = list[index];
          return Container(
            margin: EdgeInsets.only(top: 12, right: 16, left: 64),
            child: Bubble(
              shadowColor: Colors.grey.shade100,
              elevation: 2,
              nip: BubbleNip.leftTop,
              padding: BubbleEdges.symmetric(horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.date,
                    textAlign: TextAlign.start,
                    style: getClickableTextStyle(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        Comment comment = item.comments[index];
                        return ListTile(
                          title: Text(
                            comment.comment,
                            textAlign: TextAlign.start,
                            style: getDefaultTextStyle(context, isFocused: true),
                          ),
                          subtitle: Text(
                            comment.time,
                            textAlign: TextAlign.start,
                            style: getCaptionTextStyle(context),
                          ),
                        );
                      },
                      itemCount: item.comments.length,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  organizeCommentAsDate() {
    for (Comment comment in comments) {
      int index = doesExist(comment);
      if (index == -1) {
        String date = comment.time.split(" ")[0];
        comment.time =
            comment.time.split(" ")[1] + " " + comment.time.split(" ")[2];
        list.add(new OrganizedComments(date, [comment]));
      } else {
        String date = comment.time.split(" ")[0];
        comment.time =
            comment.time.split(" ")[1] + " " + comment.time.split(" ")[2];
        list[index].comments.add(comment);
      }
    }
  }

  int doesExist(Comment comment) {
    int counter = 0;
    for (OrganizedComments item in list) {
      if (item.date == comment.time.split(" ")[0]) {
        return counter;
      }
      counter++;
    }
    return -1;
  }
}
