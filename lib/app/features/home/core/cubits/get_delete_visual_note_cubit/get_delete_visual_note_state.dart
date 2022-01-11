part of 'get_delete_visual_note_cubit.dart';

// UI is built on the basis of the current state
class GetDeleteVisualNoteState extends Equatable {
  final BLOC_STATE_STATUS status; // status of current state
  final List<VisualNoteModel> visualNotes;
  final Exception? exception; // in case of throw error

  const GetDeleteVisualNoteState({
    this.status = BLOC_STATE_STATUS.initial,
    this.visualNotes = const [],
    this.exception,
  });

  @override
  List<Object?> get props => [status, visualNotes, exception];

  GetDeleteVisualNoteState copyWith({
    BLOC_STATE_STATUS? status,
    List<VisualNoteModel>? visualNotes,
    Exception? exception,
  }) =>
      GetDeleteVisualNoteState(
        status: status ?? this.status,
        visualNotes: visualNotes ?? this.visualNotes,
        exception: exception ?? this.exception,
      );
}

/*
scenario of copyWith method:

You successfully fetched the goals list from the backend and emitted it.
Your app is displaying it within a ListView.
You have a button with “Refresh” or even a Pull-to-refresh mechanismn like “RefreshIndicator” implemented
and for whatever reason after you triggered it you get back an error from the backend.
This could have various reasons like a lost/instable internet connection or the backend is down/has an error etc.
*/

/*
cases of status:

initial = GetVisualNotesState();// BLOC_STATE_STATUS.initial is the default value for the status
loading = GetVisualNotesState(status: BLOC_STATE_STATUS.loading);
success = GetVisualNotesState(status: BLOC_STATE_STATUS.success, goals: visualNotesList);
error = GetVisualNotesState(status: BLOC_STATE_STATUS.failure, exception: exception);
*/