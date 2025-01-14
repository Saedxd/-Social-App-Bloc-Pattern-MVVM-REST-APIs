// ignore_for_file: non_constant_identifier_names, file_names

library FriendList_event;

import 'dart:convert';
import 'dart:io';

import 'package:bubbles/UI/Profile/Friendlist_Screen/pages/Friendlist_screen.dart';
import 'package:bubbles/core/Classes/Classes.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'FriendList_event.g.dart';

abstract class FriendListEvent {}



abstract class Toggle extends FriendListEvent
    implements Built<Toggle,ToggleBuilder> {

  Toggle._();
  factory Toggle([updates(ToggleBuilder b)]) = _$Toggle;
}

abstract class GetFreinds extends FriendListEvent
    implements Built<GetFreinds,GetFreindsBuilder> {

  GetFreinds._();
  factory GetFreinds([updates(GetFreindsBuilder b)]) = _$GetFreinds;
}

abstract class RemoveFriend extends FriendListEvent
    implements Built<RemoveFriend,RemoveFriendBuilder> {
int? get friend_id;
int? get index;
  RemoveFriend._();
  factory RemoveFriend([updates(RemoveFriendBuilder b)]) = _$RemoveFriend;
}


abstract class IsRefresh extends FriendListEvent
    implements Built<IsRefresh,IsRefreshBuilder> {

  IsRefresh._();
  factory IsRefresh([updates(IsRefreshBuilder b)]) = _$IsRefresh;
}


abstract class RefreshState extends FriendListEvent
    implements Built<RefreshState,RefreshStateBuilder> {

  RefreshState._();
  factory RefreshState([updates(RefreshStateBuilder b)]) = _$RefreshState;
}

abstract class FreindsRequests extends FriendListEvent
    implements Built<FreindsRequests,FreindsRequestsBuilder> {

  FreindsRequests._();
  factory FreindsRequests([updates(FreindsRequestsBuilder b)]) = _$FreindsRequests;
}

abstract class AceeptRequest extends FriendListEvent
    implements Built<AceeptRequest,AceeptRequestBuilder> {
  int? get friend_id;
  int? get index;
  FrinedsData? get daata;

  AceeptRequest._();
  factory AceeptRequest([updates(AceeptRequestBuilder b)]) = _$AceeptRequest;
}


abstract class DenyRequest extends FriendListEvent
    implements Built<DenyRequest,DenyRequestBuilder> {
  int? get friend_id;
  int? get index;

  DenyRequest._();
  factory DenyRequest([updates(DenyRequestBuilder b)]) = _$DenyRequest;
}
