
import 'package:flutter/material.dart';

void sureSetState(State instance,Function() action){

  if(instance.mounted){
    instance.setState(action);
  }
}