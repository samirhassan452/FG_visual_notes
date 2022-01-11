part of 'add_edit_visual_note_cubit.dart';

class AddEditVisualNoteState extends Equatable {
  final BLOC_STATE_STATUS status;
  final Exception? exception;
  const AddEditVisualNoteState({
    this.status = BLOC_STATE_STATUS.initial,
    this.exception,
  });

  @override
  List<Object?> get props => [status, exception];
}
