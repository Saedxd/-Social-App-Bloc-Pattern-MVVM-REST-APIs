// ignore_for_file: non_constant_identifier_names

library home_event;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bubbles/UI/Home/Home_Screen/pages/HomeScreen.dart';
import 'package:bubbles/UI/Profile/Profile_Screen/bloc/profile_event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart' as i;
part 'home_event.g.dart';

abstract class HomeEvent {}

abstract class Getprofile extends HomeEvent
    implements Built<Getprofile,GetprofileBuilder> {

  Getprofile._();
  factory Getprofile([updates(GetprofileBuilder b)]) = _$Getprofile;
}

abstract class ChangeValue extends HomeEvent
    implements Built<ChangeValue,ChangeValueBuilder> {
double? get Value;
  ChangeValue._();
  factory ChangeValue([updates(ChangeValueBuilder b)]) = _$ChangeValue;
}


abstract class ShowDialoog extends HomeEvent
    implements Built<ShowDialoog,ShowDialoogBuilder> {

  ShowDialoog._();
  factory ShowDialoog([updates(ShowDialoogBuilder b)]) = _$ShowDialoog;
}


abstract class AddMarkers extends HomeEvent
    implements Built<AddMarkers,AddMarkersBuilder> {
  Set<Marker>? get marker2;

  AddMarkers._();
  factory AddMarkers([updates(AddMarkersBuilder b)]) = _$AddMarkers;
}


abstract class MakeDone extends HomeEvent
    implements Built<MakeDone,MakeDoneBuilder> {

  MakeDone._();
  factory MakeDone([updates(MakeDoneBuilder b)]) = _$MakeDone;
}


abstract class ClearError extends HomeEvent
    implements Built<ClearError, ClearErrorBuilder> {
  // fields go here

  ClearError._();

  factory ClearError([updates(ClearErrorBuilder b)]) = _$ClearError;


}

abstract class GetAllBubbles extends HomeEvent
    implements Built<GetAllBubbles, GetAllBubblesBuilder> {


  GetAllBubbles._();
  factory GetAllBubbles([updates(GetAllBubblesBuilder b)]) = _$GetAllBubbles;
}


abstract class GetPrimeBubbles extends HomeEvent
    implements Built<GetPrimeBubbles, GetPrimeBubblesBuilder> {

  GetPrimeBubbles._();
  factory GetPrimeBubbles([updates(GetPrimeBubblesBuilder b)]) = _$GetPrimeBubbles;
}


abstract class GetNewBubbles extends HomeEvent
    implements Built<GetNewBubbles, GetNewBubblesBuilder> {

  GetNewBubbles._();
  factory GetNewBubbles([updates(GetNewBubblesBuilder b)]) = _$GetNewBubbles;
}

abstract class UserMoved extends HomeEvent
    implements Built<UserMoved,UserMovedBuilder> {
double? get lat;
double? get lng;
i.GlobalKey? get globalKey;
String? get avatar;
String? get Background_Color;
Uint8List? get Uint8;
  UserMoved._();
  factory UserMoved([updates(UserMovedBuilder b)]) = _$UserMoved;
}


abstract class CreateBubbless extends HomeEvent
    implements Built<CreateBubbless,CreateBubblessBuilder> {
  double? get lat;
  double? get lng;
  double? get Radius;

  CreateBubbless._();
  factory CreateBubbless([updates(CreateBubblessBuilder b)]) = _$CreateBubbless;
}


abstract class RaduisUpdated extends HomeEvent
    implements Built<RaduisUpdated,RaduisUpdatedBuilder> {
  double? get Radius;

  RaduisUpdated._();
  factory RaduisUpdated([updates(RaduisUpdatedBuilder b)]) = _$RaduisUpdated;
}

abstract class UpdateLocation extends HomeEvent
    implements Built<UpdateLocation,UpdateLocationBuilder> {
  double? get lat;
  double? get lng;

  UpdateLocation._();
  factory UpdateLocation([updates(UpdateLocationBuilder b)]) = _$UpdateLocation;
}

abstract class DeleteBubble extends HomeEvent
    implements Built<DeleteBubble,DeleteBubbleBuilder> {

  DeleteBubble._();
  factory DeleteBubble([updates(DeleteBubbleBuilder b)]) = _$DeleteBubble;
}

abstract class ChangeSliderValue extends HomeEvent
    implements Built<ChangeSliderValue,ChangeSliderValueBuilder> {

  double? get value;

  ChangeSliderValue._();
  factory ChangeSliderValue([updates(ChangeSliderValueBuilder b)]) = _$ChangeSliderValue;
}

abstract class OpenDoorTObeAbleTOsetBubble extends HomeEvent
    implements Built<OpenDoorTObeAbleTOsetBubble, OpenDoorTObeAbleTOsetBubbleBuilder> {
bool? get MakeHimBEableTOSEtBubbles;
  OpenDoorTObeAbleTOsetBubble._();
  factory OpenDoorTObeAbleTOsetBubble([updates(OpenDoorTObeAbleTOsetBubbleBuilder b)]) = _$OpenDoorTObeAbleTOsetBubble;
}

abstract class SearchBubblesList extends HomeEvent
    implements Built<SearchBubblesList,SearchBubblesListBuilder> {
  String? get Keyword;
  bool? get Change_ViewStatus;
  SearchBubblesList._();
  factory SearchBubblesList([updates(SearchBubblesListBuilder b)]) = _$SearchBubblesList;
}


abstract class UserJoinedBubble extends HomeEvent
    implements Built<UserJoinedBubble, UserJoinedBubbleBuilder> {


  int? get Bubble_id;
  UserJoinedBubble._();
  factory UserJoinedBubble([Function(UserJoinedBubbleBuilder b) updates]) = _$UserJoinedBubble;
}

abstract class UserLeftBubble extends HomeEvent
    implements Built<UserLeftBubble, UserLeftBubbleBuilder> {

  int? get Bubble_id;
  UserLeftBubble._();
  factory UserLeftBubble([Function(UserLeftBubbleBuilder b) updates]) = _$UserLeftBubble;
}
//
//GetNearbyBubbles

abstract class GetNearbyBubbles extends HomeEvent
    implements Built<GetNearbyBubbles, GetNearbyBubblesBuilder> {

  double? get lat;
  double? get lng;
  GetNearbyBubbles._();
  factory GetNearbyBubbles([Function(GetNearbyBubblesBuilder b) updates]) = _$GetNearbyBubbles;
}
abstract class GetPopularNowBubbles extends HomeEvent
    implements Built<GetPopularNowBubbles,GetPopularNowBubblesBuilder> {

  GetPopularNowBubbles._();
  factory GetPopularNowBubbles([updates(GetPopularNowBubblesBuilder b)]) = _$GetPopularNowBubbles;
}

abstract class NotifyNearBubble extends HomeEvent
    implements Built<NotifyNearBubble, NotifyNearBubbleBuilder> {
String? get Distance;
String? get Title;
  NotifyNearBubble._();
  factory NotifyNearBubble([Function(NotifyNearBubbleBuilder b) updates]) = _$NotifyNearBubble;
}
abstract class ChangeShapStatus extends HomeEvent
    implements Built<ChangeShapStatus, ChangeShapStatusBuilder> {
  ChangeShapStatus._();

  factory ChangeShapStatus([updates(ChangeShapStatusBuilder b)]) = _$ChangeShapStatus;
}

abstract class SaveEventStatus extends HomeEvent
    implements Built<SaveEventStatus, SaveEventStatusBuilder> {
  SaveEventStatus._();

  factory SaveEventStatus([updates(SaveEventStatusBuilder b)]) = _$SaveEventStatus;
}


abstract class GetSavedBubbles extends HomeEvent
    implements Built<GetSavedBubbles,GetSavedBubblesBuilder> {
  int? get User_id;
  GetSavedBubbles._();
  factory GetSavedBubbles([updates(GetSavedBubblesBuilder b)]) = _$GetSavedBubbles;
}


abstract class ToggleSaveBubble extends HomeEvent
    implements Built<ToggleSaveBubble,ToggleSaveBubbleBuilder> {
  int? get Bubble_id;
  int? get index;
  String? get List_type;
  bool? get Saved_Status;
  ToggleSaveBubble._();
  factory ToggleSaveBubble([updates(ToggleSaveBubbleBuilder b)]) = _$ToggleSaveBubble;
}
abstract class ToggleSaveBubbleEventScreen extends HomeEvent
    implements Built<ToggleSaveBubbleEventScreen,ToggleSaveBubbleEventScreenBuilder> {
  int? get Bubble_id;
  int? get index;
  String? get List_type;
  bool? get Saved_Status;
  ToggleSaveBubbleEventScreen._();
  factory ToggleSaveBubbleEventScreen([updates(ToggleSaveBubbleEventScreenBuilder b)]) = _$ToggleSaveBubbleEventScreen;
}



abstract class GiveHimListOfBoolean extends HomeEvent
    implements Built<GiveHimListOfBoolean,GiveHimListOfBooleanBuilder> {
  List<bool>? get List_Saved_Status;

  GiveHimListOfBoolean._();
  factory GiveHimListOfBoolean([updates(GiveHimListOfBooleanBuilder b)]) = _$GiveHimListOfBoolean;
}
abstract class ChangeToDetailUiState extends HomeEvent
    implements Built<ChangeToDetailUiState, ChangeToDetailUiStateBuilder> {
  BubbleData? get Bubbledata;
  bool? get Status;
  ChangeToDetailUiState._();
  factory ChangeToDetailUiState([Function(ChangeToDetailUiStateBuilder b) updates]) = _$ChangeToDetailUiState;
}

abstract class SwitchBetweenDetailUi extends HomeEvent
    implements Built<SwitchBetweenDetailUi, SwitchBetweenDetailUiBuilder> {

  SwitchBetweenDetailUi._();
  factory SwitchBetweenDetailUi([Function(SwitchBetweenDetailUiBuilder b) updates]) = _$SwitchBetweenDetailUi;
}
abstract class AddMarker extends HomeEvent
    implements Built<AddMarker, AddMarkerBuilder> {
  Marker get marker;
  Circle get circle;
  AddMarker._();
  factory AddMarker([Function(AddMarkerBuilder b) updates]) = _$AddMarker;
}
abstract class ClearMarkers extends HomeEvent
    implements Built<ClearMarkers,ClearMarkersBuilder> {
  ClearMarkers._();
  factory ClearMarkers([updates(ClearMarkersBuilder b)]) = _$ClearMarkers;
}
