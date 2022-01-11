import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show
        Constants,
        CustomHorizontalSpace,
        CustomPopUpsWidgets,
        CustomTextWidget,
        Log,
        RoutesNames,
        VisualNoteModel;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show
        CardPictureWidget,
        CardTitleSubtitleWidget,
        CardVerticalBarActionButtonsWidget,
        GetDeleteVisualNoteCubit;
import 'package:visual_notes/app/features/visual_note/visual_note_exports.dart'
    show AddEditVisualNoteScreen, ViewVisualNoteScreen;

class HomeVisualNoteCardWidget extends StatelessWidget {
  final VisualNoteModel visualNoteData;
  const HomeVisualNoteCardWidget({
    Key? key,
    required this.visualNoteData,
  }) : super(key: key);

  final double cardHeight = 155.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: Constants.semiMediumPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final currentHeight = constraints.maxHeight;
          return Row(
            children: [
              // visual note info
              SizedBox(
                // constraints.maxWidth - (45.0) width of vertical bar buttons
                width: constraints.maxWidth - 45.0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Navigator.of(context).pushNamed(
                    RoutesNames.viewVisualNoteRoute,
                    arguments: ViewVisualNoteScreen(
                      visualNoteData: visualNoteData,
                    ),
                  ),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                    ),
                    elevation: 4.0,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Constants.smallPadding,
                        horizontal: Constants.semiSmallPadding,
                      ),
                      child: Row(
                        children: [
                          // picture
                          CardPictureWidget(
                            picture: visualNoteData.picture,
                            cardHeight: cardHeight,
                          ),
                          const CustomHorizontalSpace(width: 10.0),
                          // title & subtitle
                          Expanded(
                            child: CardTitleSubtitleWidget(
                              title: visualNoteData.title,
                              subtitle: visualNoteData.description,
                              currentHeight: currentHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // vertical bar action buttons
              SizedBox(
                width: 45.0,
                child: CardVerticalBarActionButtonsWidget(
                  // on click on this button, go to view screen to show visual note info
                  onView: () => Navigator.of(context).pushNamed(
                    RoutesNames.viewVisualNoteRoute,
                    arguments: ViewVisualNoteScreen(
                      visualNoteData: visualNoteData,
                    ),
                  ),
                  // on click on this button, go to add-edit screen to show visual note info and update data
                  onUpdate: () => Navigator.of(context).pushNamed(
                    RoutesNames.addEditVisualNoteRoute,
                    arguments: AddEditVisualNoteScreen(
                      visualNoteData: visualNoteData,
                    ),
                  ),
                  // on click on this button, perform delete action
                  onDelete: () async {
                    // show popup for user to be sure if he want to delete or not
                    // and receive true or false
                    // true, he is sure - false, he is not sure
                    final sureDeleted = await CustomPopUpsWidgets
                        .showCloseAppOrDeleteMessageDialog(
                      "Are you sure you want to delete?",
                    );
                    // if he is sure
                    if (sureDeleted) {
                      // hide any current snackbar, if user make multiple deletions at the same time
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      "Deleting Note".log();
                      // get instance from bloc provider to access functios
                      final visualNoteCubit =
                          BlocProvider.of<GetDeleteVisualNoteCubit>(context);
                      // call delete function
                      visualNoteCubit.deleteVisualNote(visualNoteData.id!);
                      "Note Deleted".log();
                      // show bottom bar for user to let hime to that visual not is deleted
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: CustomTextWidget(
                            "Note deleted successfully",
                            fontColor: Colors.redAccent[700]!,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


/*

LayoutBuilder(
                              builder: (context, constraints) {
                                // margin from listview -> Constants.semiMediumPadding * 2 (left + right) -> 18.0 * 2 = 36.0
                                // padding inside card -> Constants.semiSmallPadding * 2 (left + right) -> 8.0 * 2 = 16.0
                                // picture width -> 80.0 or 100.0 based screenWidth
                                // space between picture and rest of widgets -> 8.0
                                // currentWidth: will be screenWidth - (36.0 + 16.0 + 80.0|110.0 + 5.0) = 220.0 | 428.0
                                final currentWidth = constraints.maxWidth;
                                final currentHeight = constraints.maxHeight;
                                
                                return Row(
                                  children: [
                                    CardTitleSubtitleWidget(
                              title: title,
                              subtitle: text,
                              currentSize: Size(currentWidth, currentHeight),
                            ),
                                    /* const CustomHorizontalSpace(width: 8.0),
                                    Container(
                                      color: Colors.blue,
                                      width: 35.0,
                                      alignment: Alignment.bottomCenter,
                                      child: CustomIconButtonWidget(
                                        btnPressed: () => "Clicked".log(),
                                        materialIcon: Icons.arrow_forward,
                                        materialIconSize: 25.0,
                                      ),
                                    ), */
                                  ],
                                );
                              },
                            ),
                         

*/