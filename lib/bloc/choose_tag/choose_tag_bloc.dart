import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'choose_tag_event.dart';
part 'choose_tag_state.dart';

class ChooseTagBloc extends Bloc<ChooseTagEvent, ChooseTagState> {
  ChooseTagBloc() : super(ChooseTagState([])) {
    on<selectTag>(_selectTag);
    on<addTags>(_addTags);
  }

  _addTags(addTags event, Emitter<ChooseTagState> emit){
    state.tags = event.tags.toList();
    state.buttonColor = Color(0xffF7D78D);
    emit(state);
  }

  _selectTag(selectTag event, Emitter<ChooseTagState> emit){
    List<String> tags = state.tags.toList();
    if(tags.contains(event.tag)){
      tags.remove(event.tag);
    }
    else{
      tags.add(event.tag);
    }
    if(tags.isNotEmpty){
      emit(ChooseTagState(tags, buttonColor: Color(0xffF7D78D)));
    } else{
    emit(ChooseTagState(tags, buttonColor: Colors.grey));}
  }

}
