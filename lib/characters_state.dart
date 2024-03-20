
import 'package:flutter/src/widgets/scroll_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'model/characters/characters.dart';
part 'characters_state.freezed.dart';

@freezed
class FetchcharactersState with _$FetchcharactersState {
  factory FetchcharactersState.initial()=_initial;

  factory FetchcharactersState.fetching()=_fetching;

  factory FetchcharactersState.fetched(List<Character>characterlist)=_fetched;

  factory FetchcharactersState.failed(String error)=_failed;
//factory FetchcharactersState.error()=_error;


}