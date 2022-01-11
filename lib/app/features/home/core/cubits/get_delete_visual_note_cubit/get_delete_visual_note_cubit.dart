import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show BLOC_STATE_STATUS, DatabaseServices, VisualNoteModel;

part 'get_delete_visual_note_state.dart';

class GetDeleteVisualNoteCubit extends Cubit<GetDeleteVisualNoteState> {
  final DatabaseServices _dbServices;
  GetDeleteVisualNoteCubit({required DatabaseServices dbServices})
      : _dbServices = dbServices,
        super(const GetDeleteVisualNoteState());

  // to keep our previous state from being cleared is use the copyWith method within the state
  // instead of emit(const GetVisualNotesState(status: BLOC_STATE_STATUS.loading));
  Future<void> fetchVisualNotes() async {
    // tell the UI that I'm loading to show indicator of other widget until data come back
    emit(state.copyWith(status: BLOC_STATE_STATUS.loading));

    try {
      // try to read all visual notes from db
      final visualNotes = await _dbServices.readAllVisualNotes();
      // in case of data returned, provide success state and data to UI
      emit(state.copyWith(
        status: BLOC_STATE_STATUS.success,
        visualNotes: visualNotes,
      ));
    } on Exception catch (exception) {
      // in case of throw an exception, provide failure state and exception to UI
      emit(state.copyWith(
        status: BLOC_STATE_STATUS.failure,
        exception: exception,
      ));
    }
  }

  void deleteVisualNote(int id) async {
    // tell the UI that I'm loading to show indicator of other widget until data come back
    emit(state.copyWith(status: BLOC_STATE_STATUS.loading));

    try {
      // if you want to make multiple calling of API or any other backend solution
      // use Future.wait to run all futures instead of run one by one
      // and the value of the returned future will be respectively
      // responses will be list, so get the value by index
      final responses = await Future.wait([
        _dbServices.deleteVisualNote(id),
        _dbServices.readAllVisualNotes(),
      ]);
      // provide success state and visual notes after deleted
      emit(state.copyWith(
        status: BLOC_STATE_STATUS.success,
        visualNotes: responses[1] as List<VisualNoteModel>,
      ));
    } on Exception catch (exception) {
      emit(state.copyWith(
        status: BLOC_STATE_STATUS.failure,
        exception: exception,
      ));
    }
  }
}
