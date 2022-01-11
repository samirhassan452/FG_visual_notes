import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show
        AppColors,
        BLOC_STATE_STATUS,
        Constants,
        CustomPopUpsWidgets,
        CustomTextWidget,
        DatabaseInit,
        GlowingScrollWidget,
        RoutesNames,
        FAB_STATUS;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show
        GetDeleteVisualNoteCubit,
        GetDeleteVisualNoteState,
        HomeShimmerWidget,
        HomeVisualNoteCardWidget;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late DatabaseServices _dbServices;

  // to update value of widget instead of use setState
  late ValueNotifier<FAB_STATUS> _fabValueNotifier;

  @override
  void initState() {
    // _dbServices = DatabaseServices();

    // false: hide fab
    // true: show fab
    _fabValueNotifier = ValueNotifier<FAB_STATUS>(FAB_STATUS.hideFAB);
    super.initState();
  }

  @override
  void dispose() {
    // close db connection when dispose/remove page from stack
    DatabaseInit().closeDB();

    _fabValueNotifier.dispose();
    super.dispose();

    // dispose() method: called when remove page from stack
  }

  @override
  Widget build(BuildContext context) {
    // final dbServices = DatabaseServices();
    return ValueListenableBuilder<FAB_STATUS>(
      valueListenable: _fabValueNotifier,
      builder: (context, value, child) {
        return WillPopScope(
          // to make the user choose if he want to close app or not
          onWillPop: _onCloseApp,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.facegraphColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const CustomTextWidget(
                "Visual Notes",
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontColor: Colors.white,
              ),
            ),
            body: _HomeScreenVisualNotesBody(
              changeFABStatus: _changeFABStatus,
            ),
            floatingActionButtonLocation: _getFABLocation(value),
            floatingActionButton: _checkHideFABStatus(value)
                ? null // to hide visual notes
                : SizedBox(
                    width: 70.0,
                    height: 70.0,
                    child: FloatingActionButton(
                      heroTag: 'add new visual note',
                      tooltip: 'Add new Visual Note',
                      backgroundColor: AppColors.facegraphColor,
                      onPressed: () => Navigator.of(context).pushNamed(
                        RoutesNames.addEditVisualNoteRoute,
                      ),
                      child: const Icon(
                        Icons.note_add_rounded,
                        // Icons.add_a_photo,
                        size: 40.0,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  // show popup for user to let him choose
  Future<bool> _onCloseApp() async =>
      CustomPopUpsWidgets.showCloseAppOrDeleteMessageDialog(
        "Do you want to exit an App?",
      );

  // change location of FAB based status
  FloatingActionButtonLocation? _getFABLocation(FAB_STATUS status) {
    switch (status) {
      case FAB_STATUS.hideFAB:
      case FAB_STATUS.defaultFAB:
        return null;
      case FAB_STATUS.centerFAB:
        return FloatingActionButtonLocation.centerFloat;
    }
  }

  // check current status to know what we will do with FAB
  bool _checkHideFABStatus(FAB_STATUS status) => status == FAB_STATUS.hideFAB;

  // called to change state of FAB
  void _changeFABStatus(FAB_STATUS status) => _fabValueNotifier.value = status;
}

class _HomeScreenVisualNotesBody extends StatelessWidget {
  // get this method as a bridge between two widgets
  final void Function(FAB_STATUS) changeFABStatus;
  const _HomeScreenVisualNotesBody({
    Key? key,
    required this.changeFABStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDeleteVisualNoteCubit, GetDeleteVisualNoteState>(
      // use listener to make some actions based current state
      listener: (context, state) {
        if (state.status == BLOC_STATE_STATUS.loading) {
          // in case of loading state, return hide FAB status to widget
          changeFABStatus(FAB_STATUS.hideFAB);
        } else {
          // in other cases, return centerFAB or defaultFAB based visual notes length
          changeFABStatus(
            state.visualNotes.isNotEmpty
                ? FAB_STATUS.defaultFAB
                : FAB_STATUS.centerFAB,
          );
        }
      },
      // use builder to build UI based current state
      builder: (context, state) {
        switch (state.status) {
          // show shimmer loading widget in loading state
          case BLOC_STATE_STATUS.loading:
            return const HomeShimmerWidget();
          // in case of other states
          case BLOC_STATE_STATUS.initial:
          case BLOC_STATE_STATUS.success:
          case BLOC_STATE_STATUS.failure:
            // check if list is empty to show another widget
            // in case of is not empty, show list of cards with info of visual note
            return state.visualNotes.isNotEmpty
                ? GlowingScrollWidget(
                    child: ListView.builder(
                      itemCount: state.visualNotes.length,
                      padding: const EdgeInsets.only(
                        right: Constants.semiMediumPadding,
                        left: Constants.semiMediumPadding,
                        top: Constants.mediumPadding,
                        bottom: Constants.largePadding,
                      ),
                      itemBuilder: (context, index) => HomeVisualNoteCardWidget(
                        visualNoteData: state.visualNotes[index],
                      ),
                    ),
                  )
                : const _HomeScreenEmptyBody();
        }
      },
    );
  }
}

class _HomeScreenEmptyBody extends StatelessWidget {
  const _HomeScreenEmptyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Constants.semiMediumPadding),
      child: CustomTextWidget(
        "There is no visual notes.\nClick the bottom button to add a new one.",
        fontColor: Colors.grey[800]!,
        fontSize: 20.0,
        height: 1.2,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
