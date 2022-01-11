import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show BLOC_STATE_STATUS, DatabaseServices, VisualNoteModel;
import 'package:visual_notes/app/features/home/core/cubits/get_delete_visual_note_cubit/get_delete_visual_note_cubit.dart'
    show GetDeleteVisualNoteCubit, GetDeleteVisualNoteState;

part 'add_edit_visual_note_state.dart';

class AddEditVisualNoteCubit extends Cubit<AddEditVisualNoteState> {
  final DatabaseServices _dbServices;
  final GetDeleteVisualNoteCubit _getVisualNotesState;
  AddEditVisualNoteCubit({
    required DatabaseServices dbServices,
    required GetDeleteVisualNoteCubit getVisualNotesState,
  })  : _dbServices = dbServices,
        _getVisualNotesState = getVisualNotesState,
        super(const AddEditVisualNoteState());

  Future<void> addVisualNote(VisualNoteModel visualNote) async {
    // tell the UI that I'm loading to show indicator of other widget until data come back
    emit(const AddEditVisualNoteState(status: BLOC_STATE_STATUS.loading));

    try {
      // if you want to make multiple calling of API or any other backend solution
      // use Future.wait to run all futures instead of run one by one
      // and the value of the returned future will be respectively
      // responses will be list, so get the value by index
      final responses = await Future.wait([
        _dbServices.createVisualNote(visualNote),
        _dbServices.readAllVisualNotes(),
      ]);
      // provide success state and visual notes after added
      emit(const AddEditVisualNoteState(status: BLOC_STATE_STATUS.success));
      _getVisualNotesState.emit(GetDeleteVisualNoteState(
        status: BLOC_STATE_STATUS.success,
        visualNotes: responses[1] as List<VisualNoteModel>,
      ));
    } on Exception catch (exception) {
      emit(AddEditVisualNoteState(
        status: BLOC_STATE_STATUS.failure,
        exception: exception,
      ));
    }
  }

  Future<void> updateVisualNote(VisualNoteModel visualNote) async {
    emit(const AddEditVisualNoteState(status: BLOC_STATE_STATUS.loading));

    try {
      // if you want to make multiple calling of API or any other backend solution
      // use Future.wait to run all futures instead of run one by one
      // and the value of the returned future will be respectively
      // responses will be list, so get the value by index
      final responses = await Future.wait([
        _dbServices.updateVisualNote(visualNote),
        _dbServices.readAllVisualNotes(),
      ]);
      // provide success state and visual notes after updated
      _getVisualNotesState.emit(GetDeleteVisualNoteState(
        status: BLOC_STATE_STATUS.success,
        visualNotes: responses[1] as List<VisualNoteModel>,
      ));
      emit(const AddEditVisualNoteState(status: BLOC_STATE_STATUS.success));
    } on Exception catch (exception) {
      emit(AddEditVisualNoteState(
        status: BLOC_STATE_STATUS.failure,
        exception: exception,
      ));
    }
  }
}
