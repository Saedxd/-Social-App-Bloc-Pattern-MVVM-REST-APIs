// GENERATED CODE - DO NOT MODIFY BY HAND

part of PrimePlan_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrimePlan_state extends PrimePlan_state {
  @override
  final String? error;
  @override
  final bool? isLoading;
  @override
  final bool? success;
  @override
  final bool? is_Saved;
  @override
  final bool? ToggleSaveIsloading;
  @override
  final ProfileDateModel? ProfileDate;
  @override
  final GetDetailedEvent? GetDetailedPlann;
  @override
  final SaveBubbleModel? SaveBubble;
  @override
  final GetWhoSavedBubblesModel? GetWhoSavedBubbles;

  factory _$PrimePlan_state([void Function(PrimePlan_stateBuilder)? updates]) =>
      (new PrimePlan_stateBuilder()..update(updates))._build();

  _$PrimePlan_state._(
      {this.error,
      this.isLoading,
      this.success,
      this.is_Saved,
      this.ToggleSaveIsloading,
      this.ProfileDate,
      this.GetDetailedPlann,
      this.SaveBubble,
      this.GetWhoSavedBubbles})
      : super._();

  @override
  PrimePlan_state rebuild(void Function(PrimePlan_stateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrimePlan_stateBuilder toBuilder() =>
      new PrimePlan_stateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrimePlan_state &&
        error == other.error &&
        isLoading == other.isLoading &&
        success == other.success &&
        is_Saved == other.is_Saved &&
        ToggleSaveIsloading == other.ToggleSaveIsloading &&
        ProfileDate == other.ProfileDate &&
        GetDetailedPlann == other.GetDetailedPlann &&
        SaveBubble == other.SaveBubble &&
        GetWhoSavedBubbles == other.GetWhoSavedBubbles;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, error.hashCode), isLoading.hashCode),
                                success.hashCode),
                            is_Saved.hashCode),
                        ToggleSaveIsloading.hashCode),
                    ProfileDate.hashCode),
                GetDetailedPlann.hashCode),
            SaveBubble.hashCode),
        GetWhoSavedBubbles.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrimePlan_state')
          ..add('error', error)
          ..add('isLoading', isLoading)
          ..add('success', success)
          ..add('is_Saved', is_Saved)
          ..add('ToggleSaveIsloading', ToggleSaveIsloading)
          ..add('ProfileDate', ProfileDate)
          ..add('GetDetailedPlann', GetDetailedPlann)
          ..add('SaveBubble', SaveBubble)
          ..add('GetWhoSavedBubbles', GetWhoSavedBubbles))
        .toString();
  }
}

class PrimePlan_stateBuilder
    implements Builder<PrimePlan_state, PrimePlan_stateBuilder> {
  _$PrimePlan_state? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  bool? _is_Saved;
  bool? get is_Saved => _$this._is_Saved;
  set is_Saved(bool? is_Saved) => _$this._is_Saved = is_Saved;

  bool? _ToggleSaveIsloading;
  bool? get ToggleSaveIsloading => _$this._ToggleSaveIsloading;
  set ToggleSaveIsloading(bool? ToggleSaveIsloading) =>
      _$this._ToggleSaveIsloading = ToggleSaveIsloading;

  ProfileDateModelBuilder? _ProfileDate;
  ProfileDateModelBuilder get ProfileDate =>
      _$this._ProfileDate ??= new ProfileDateModelBuilder();
  set ProfileDate(ProfileDateModelBuilder? ProfileDate) =>
      _$this._ProfileDate = ProfileDate;

  GetDetailedEventBuilder? _GetDetailedPlann;
  GetDetailedEventBuilder get GetDetailedPlann =>
      _$this._GetDetailedPlann ??= new GetDetailedEventBuilder();
  set GetDetailedPlann(GetDetailedEventBuilder? GetDetailedPlann) =>
      _$this._GetDetailedPlann = GetDetailedPlann;

  SaveBubbleModelBuilder? _SaveBubble;
  SaveBubbleModelBuilder get SaveBubble =>
      _$this._SaveBubble ??= new SaveBubbleModelBuilder();
  set SaveBubble(SaveBubbleModelBuilder? SaveBubble) =>
      _$this._SaveBubble = SaveBubble;

  GetWhoSavedBubblesModelBuilder? _GetWhoSavedBubbles;
  GetWhoSavedBubblesModelBuilder get GetWhoSavedBubbles =>
      _$this._GetWhoSavedBubbles ??= new GetWhoSavedBubblesModelBuilder();
  set GetWhoSavedBubbles(GetWhoSavedBubblesModelBuilder? GetWhoSavedBubbles) =>
      _$this._GetWhoSavedBubbles = GetWhoSavedBubbles;

  PrimePlan_stateBuilder();

  PrimePlan_stateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _isLoading = $v.isLoading;
      _success = $v.success;
      _is_Saved = $v.is_Saved;
      _ToggleSaveIsloading = $v.ToggleSaveIsloading;
      _ProfileDate = $v.ProfileDate?.toBuilder();
      _GetDetailedPlann = $v.GetDetailedPlann?.toBuilder();
      _SaveBubble = $v.SaveBubble?.toBuilder();
      _GetWhoSavedBubbles = $v.GetWhoSavedBubbles?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrimePlan_state other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PrimePlan_state;
  }

  @override
  void update(void Function(PrimePlan_stateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrimePlan_state build() => _build();

  _$PrimePlan_state _build() {
    _$PrimePlan_state _$result;
    try {
      _$result = _$v ??
          new _$PrimePlan_state._(
              error: error,
              isLoading: isLoading,
              success: success,
              is_Saved: is_Saved,
              ToggleSaveIsloading: ToggleSaveIsloading,
              ProfileDate: _ProfileDate?.build(),
              GetDetailedPlann: _GetDetailedPlann?.build(),
              SaveBubble: _SaveBubble?.build(),
              GetWhoSavedBubbles: _GetWhoSavedBubbles?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ProfileDate';
        _ProfileDate?.build();
        _$failedField = 'GetDetailedPlann';
        _GetDetailedPlann?.build();
        _$failedField = 'SaveBubble';
        _SaveBubble?.build();
        _$failedField = 'GetWhoSavedBubbles';
        _GetWhoSavedBubbles?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PrimePlan_state', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
