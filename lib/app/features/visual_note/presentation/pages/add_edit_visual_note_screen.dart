import 'dart:async' show StreamController;
import 'dart:convert' show base64Encode;
import 'dart:io' show File;

import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocConsumer;
import 'package:visual_notes/app/core/core_exports.dart'
    show
        AppColors,
        BLOC_STATE_STATUS,
        Constants,
        CustomElevatedButtonWidget,
        CustomTextWidget,
        DatabaseServices,
        GlowingScrollWidget,
        VisualNoteModel;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show GetDeleteVisualNoteCubit;
import 'package:visual_notes/app/features/visual_note/visual_note_exports.dart'
    show
        AddStatusWidget,
        AddTitleAndDescriptionWidget,
        AddEditVisualNoteCubit,
        AddEditVisualNoteState,
        PickPictureWidget;

class AddEditVisualNoteScreen extends StatefulWidget {
  // this will distinuish between add or edit state
  // if null, then add state, otherwise edit state
  final VisualNoteModel? visualNoteData;
  const AddEditVisualNoteScreen({
    Key? key,
    required this.visualNoteData,
  }) : super(key: key);

  @override
  State<AddEditVisualNoteScreen> createState() =>
      _AddEditVisualNoteScreenState();
}

class _AddEditVisualNoteScreenState extends State<AddEditVisualNoteScreen> {
  // create stream to update the UI and accept data from other widgets
  late StreamController<Map<String, dynamic>> _visualNoteInfoStreamController;

  // create Map variable to save initial data of visual note
  late Map<String, dynamic> _visualNoteInfo;
  // create another Map variable to use it to compare with previous variable
  // if equal, then perform nothing, otherwise perform save for add or edit
  late Map<String, dynamic> _visualNoteInfoChecker;

  @override
  void initState() {
    _visualNoteInfoStreamController = StreamController<Map<String, dynamic>>();

    _visualNoteInfo = {
      Constants.visualNotePictureKey: widget.visualNoteData?.picture,
      Constants.visualNoteTitleKey: widget.visualNoteData?.title,
      Constants.visualNoteDescriptionKey: widget.visualNoteData?.description,
      Constants.visualNoteStatusKey: widget.visualNoteData?.status,
    };
    _visualNoteInfoChecker = {
      Constants.visualNotePictureKey: widget.visualNoteData?.picture,
      Constants.visualNoteTitleKey: widget.visualNoteData?.title,
      Constants.visualNoteDescriptionKey: widget.visualNoteData?.description,
      Constants.visualNoteStatusKey: widget.visualNoteData?.status,
    };
    super.initState();
  }

  @override
  void dispose() {
    // don't forget to close stream to not waste the RAM
    _visualNoteInfoStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dbServices = DatabaseServices();
    final visualNoteCubit = BlocProvider.of<GetDeleteVisualNoteCubit>(context);
    return BlocProvider<AddEditVisualNoteCubit>(
      create: (context) => AddEditVisualNoteCubit(
        dbServices: dbServices,
        getVisualNotesState: visualNoteCubit,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.facegraphColor,
          centerTitle: true,
          title: const CustomTextWidget(
            "Add new visual note",
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontColor: Colors.white,
          ),
        ),
        body: StreamBuilder<Map<String, dynamic>>(
          initialData: _visualNoteInfo,
          stream: _visualNoteInfoStreamController.stream,
          builder: (context, snapshot) {
            // check status to know if we disable button or not
            final isBtnDisabled = _checkButtonStatus(snapshot.data!);
            return GlowingScrollWidget(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.smallPadding,
                  vertical: Constants.semiMediumPadding,
                ),
                children: [
                  // pick image
                  PickPictureWidget(
                    // pass picture if comes to edit
                    defaultPicture: widget.visualNoteData?.picture,
                    // recieve path of picture, and save it to map and update UI
                    onSelectedPicture: (path) {
                      _visualNoteInfo[Constants.visualNotePictureKey] = path;
                      _visualNoteInfoStreamController.sink.add(_visualNoteInfo);
                    },
                  ),
                  Constants.verticalSpaceMedium,
                  // title and desc
                  AddTitleAndDescriptionWidget(
                    // pass title, subtitle to show them if comes to edit
                    defaultTitle: widget.visualNoteData?.title,
                    defaultDescription: widget.visualNoteData?.description,
                    // when user add title, receive it to save
                    onSavedTitle: (title) {
                      _visualNoteInfo[Constants.visualNoteTitleKey] = title;
                      _visualNoteInfoStreamController.sink.add(_visualNoteInfo);
                    },
                    // when user add desc, receive it to save
                    onSavedDescription: (desc) {
                      _visualNoteInfo[Constants.visualNoteDescriptionKey] =
                          desc;
                      _visualNoteInfoStreamController.sink.add(_visualNoteInfo);
                    },
                  ),
                  Constants.verticalSpaceSmall,
                  // status
                  AddStatusWidget(
                    defaultStatus: widget.visualNoteData?.status,
                    onSelectedStatus: (status) {
                      _visualNoteInfo[Constants.visualNoteStatusKey] = status;
                      _visualNoteInfoStreamController.sink.add(_visualNoteInfo);
                    },
                  ),
                  Constants.verticalSpaceLarge,
                  //button
                  BlocConsumer<AddEditVisualNoteCubit, AddEditVisualNoteState>(
                    listener: (context, state) {
                      if (state.status == BLOC_STATE_STATUS.success) {
                        // if state is success, then show message to user that operation done
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomTextWidget(
                              // to distinguish between edit and add state
                              widget.visualNoteData == null
                                  ? "Note added successfully"
                                  : "Note updated successfully",
                              fontColor: Colors.greenAccent[400]!,
                            ),
                          ),
                        );
                        // pop this screen to back to home after 2 seconds
                        Future.delayed(const Duration(seconds: 2)).then((_) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    builder: (context, state) {
                      switch (state.status) {
                        case BLOC_STATE_STATUS.loading:
                          // show indicator until operation finish
                          return const CupertinoActivityIndicator();
                        case BLOC_STATE_STATUS.initial:
                        case BLOC_STATE_STATUS.success:
                        case BLOC_STATE_STATUS.failure:
                          // show button
                          return CustomElevatedButtonWidget(
                            btnBorderColor: Colors.transparent,
                            btnColor: isBtnDisabled
                                ? Colors.grey[600]!
                                : AppColors.facegraphColor,
                            btnPressed: isBtnDisabled
                                ? null
                                : () =>
                                    _addEditVisualNote(snapshot.data!, context),
                            btnText: "Save",
                            btnTextColor: isBtnDisabled
                                ? Colors.grey[500]!
                                : Colors.white,
                          );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _checkButtonStatus(Map<String, dynamic> data) =>
      data.containsValue(null) || mapEquals(data, _visualNoteInfoChecker);

  void _addEditVisualNote(
    Map<String, dynamic> map,
    BuildContext context,
  ) async {
    // get instance from bloc provider to access functions
    final addEditVisualNoteCubit =
        BlocProvider.of<AddEditVisualNoteCubit>(context);

    // convert image to base64 to save it
    String? base64Picture;
    if (map[Constants.visualNotePictureKey] != widget.visualNoteData?.picture) {
      final path = map[Constants.visualNotePictureKey];
      final bytes = await File(path).readAsBytes();
      base64Picture = base64Encode(bytes);
    }

    final title = map[Constants.visualNoteTitleKey];
    final description = map[Constants.visualNoteDescriptionKey];
    final status = map[Constants.visualNoteStatusKey];

    // to distinguish between add and update function
    widget.visualNoteData == null
        ? addEditVisualNoteCubit.addVisualNote(
            VisualNoteModel(
              picture: base64Picture!,
              description: description,
              title: title,
              status: status,
              createdTime: DateTime.now(),
            ),
          )
        : addEditVisualNoteCubit.updateVisualNote(
            // in update, pass updated data and previous data
            VisualNoteModel(
              id: widget.visualNoteData!.id,
              picture: base64Picture ?? widget.visualNoteData!.picture,
              description: description,
              title: title,
              status: status,
              createdTime: widget.visualNoteData!.createdTime,
            ),
          );
  }
}
