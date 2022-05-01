import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanban_memo/model/board_data.dart';

class BoardNotifier extends StateNotifier<BoardData> {
  BoardNotifier(BoardData state) : super(state);

  BoardData get data => state;

  set data(BoardData value) {
    state = value;
  }
}

final boardNotifierProvider =
    StateNotifierProvider<BoardNotifier, BoardData>((ref) {
  return BoardNotifier(BoardData());
});
