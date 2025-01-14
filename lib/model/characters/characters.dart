
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters.freezed.dart';
part 'characters.g.dart';
@freezed
class Character with _$Character{
  factory Character({
      String? id,
      String? name,
      String? image,
      String? status
  })=_Character;

 factory Character.fromJson(Map<String ,dynamic>json)=>_$CharacterFromJson(json);

}