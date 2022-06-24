library home_state;

import 'package:bubbles/models/GetBubblesModel/GetPrimeBubblesModel.dart';
import 'package:bubbles/models/ProfileDataModel/ProfileDateModel.dart';
import 'package:built_value/built_value.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




part 'home_state.g.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder>   {
  // fields go here

  String? get error;
  bool? get isLoading;
  bool? get success;
  double? get Value;

  bool? get showDialogg;
  bool? get done;


  String? get GetAllBubblesError;
  bool? get GetAllBubblesIsloading;
  bool? get GetAllBubblesSuccess;

  String? get GetAllPrimeError;
  bool? get GetAllPrimeIsloading;
  bool? get GetAllPrimeSuccess;

  String? get GetNewBubblesError;
  bool? get GetNewBubblesIsloading;
  bool? get GetNewBubblesSuccess;
  Set<Marker>? get marker2;

  Set<Circle>? get circle;
  // GoogleMapController? get _googleMapController;


  bool? get ValueLOading;
  double? get NewValue;
  bool? get MakeHimBEableTOSEtBubble;

  bool? get GetprofileISloading;
  bool? get GetprofileSuccess;



  GetPrimeBubblesModel? get GetBubbles;
  GetPrimeBubblesModel? get GetPrimeBubbles;
  GetPrimeBubblesModel? get GetNewBubbles;

  ProfileDateModel? get ProfileDate;


  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;
  factory HomeState.initail() {
    return HomeState((b) => b
      ..error = ""
      ..GetAllBubblesError = ""
      ..GetNewBubblesError = ""
      ..GetAllPrimeError = ""
      ..isLoading = false
      ..MakeHimBEableTOSEtBubble = false
      ..GetNewBubblesIsloading = false
      ..GetAllPrimeIsloading = false
      ..GetAllBubblesIsloading = false
      ..success = false
      ..GetAllPrimeSuccess = false
      ..GetNewBubblesSuccess = false
      ..GetAllBubblesSuccess = false
      ..GetprofileISloading = false
      ..GetprofileSuccess = false
      ..Value=0
      ..NewValue = 0
      ..ValueLOading=false
      ..showDialogg = false
        ..done = false
        ..GetBubbles =null
        ..GetNewBubbles =null
        ..GetPrimeBubbles =null
        ..ProfileDate =null

        ..marker2 ={}
        ..circle ={}

    );
  }




}
