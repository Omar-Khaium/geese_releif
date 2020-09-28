import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/note.dart';
import 'package:geesereleif/src/model/organized_note.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

// ignore: must_be_immutable
class NotesPreview extends StatelessWidget {
  final List<Note> notes;
  NotesPreview(this.notes);

  List<OrganizedNotes> list = [];

  @override
  Widget build(BuildContext context) {
    organizenoteAsDate();

    return Container(
      height: MediaQuery.of(context).size.height * .5,
      child: list.length==0 ? Center(
        child: Text(
          "No note found!",
          style: getHintTextStyle(context),
        ),
      ) : ListView.builder(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          OrganizedNotes item = list[index];
          item.notes.sort((a, b) => b.time.compareTo(a.time));
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      child: Text(
                        dateTimeToFriendlyDate(
                            stringToDateTime(item.date), "MM/dd/yyyy"),
                        textAlign: TextAlign.start,
                        style: getCaptionTextStyle(context),
                      ),
                    ),
                    Container(
                      width: 48,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: 16,
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 2);
                  },
                  itemBuilder: (context, index) {
                    Note note = item.notes[index];
                    return Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                            topRight: Radius.circular(index == 0 ? 18 : 0),
                            bottomRight: Radius.circular(
                                index == item.notes.length - 1 ? 18 : 0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              note.note,
                              textAlign: TextAlign.start,
                              style: getChatMessageStyle(context),
                            ),
                            SizedBox(height: 4),
                            Text(
                              dateTimeToFriendlyTime(
                                  stringToDateTime(note.time), "hh:mm a"),
                              textAlign: TextAlign.start,
                              style: getChatDateStyle(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: item.notes.length,
                ),
              ],
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  organizenoteAsDate() {
    try {
      for (Note note in notes) {
        int index = doesExist(note);
        if (index == -1) {
          list.add(new OrganizedNotes(note.time, [note]));
        } else {
          list[index].notes.add(note);
        }
      }
      list.sort((a, b) => b.date.compareTo(a.date));
    } catch (error) {
      print(error);
    }
  }

  int doesExist(Note note) {
    int counter = 0;
    for (OrganizedNotes item in list) {
      if (dateTimeToFriendlyDate(stringToDateTime(item.date), "MM/dd/yyyy") ==
          dateTimeToFriendlyDate(stringToDateTime(note.time), "MM/dd/yyyy")) {
        return counter;
      }
      counter++;
    }
    return -1;
  }
}
