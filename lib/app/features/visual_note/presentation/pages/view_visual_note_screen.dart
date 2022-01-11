import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show Constants, CustomTextWidget, GlowingScrollWidget, VisualNoteModel;
import 'package:visual_notes/app/features/visual_note/visual_note_exports.dart';

class ViewVisualNoteScreen extends StatelessWidget {
  final VisualNoteModel visualNoteData;
  const ViewVisualNoteScreen({
    Key? key,
    required this.visualNoteData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          visualNoteData.title,
          fontColor: Colors.white,
          fontSize: 20.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: Constants.mediumPadding,
            horizontal: Constants.semiMediumPadding,
          ),
          child: GlowingScrollWidget(
            child: Column(
              children: [
                // picture
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.memory(
                    // decode image to show it
                    base64Decode(visualNoteData.picture),
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 170.0,
                  ),
                ),
                Constants.verticalSpaceMedium,
                Container(height: 1.0, color: Colors.black54),
                Constants.verticalSpaceSmall,
                // id
                CustomViewVisualNoteCardWidget(
                  title: "ID",
                  subtitle: visualNoteData.id!.toString(),
                ),
                Constants.verticalSpaceSmall,
                Container(height: 1.0, color: Colors.black54),
                Constants.verticalSpaceSmall,
                // title
                CustomViewVisualNoteCardWidget(
                  title: "Title",
                  subtitle: visualNoteData.title,
                ),
                Constants.verticalSpaceSmall,
                Container(height: 1.0, color: Colors.black54),
                Constants.verticalSpaceSmall,
                // desc
                CustomViewVisualNoteCardWidget(
                  title: "Description",
                  subtitle: visualNoteData.description,
                ),
                Constants.verticalSpaceSmall,
                Container(height: 1.0, color: Colors.black54),
                Constants.verticalSpaceSmall,
                // date
                CustomViewVisualNoteCardWidget(
                  title: "Date",
                  subtitle: _formatDate(),
                ),
                Constants.verticalSpaceSmall,
                Container(height: 1.0, color: Colors.black54),
                Constants.verticalSpaceSmall,
                // status
                CustomViewVisualNoteCardWidget(
                  title: "Status",
                  subtitle: visualNoteData.status,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate() {
    final date = visualNoteData.createdTime;
    final formattedDate = DateFormat("hh/MM/yyyy").format(date);
    final formattedTime = DateFormat("h:mm a").format(date);
    return formattedDate + "\n" + formattedTime;
  }
}
