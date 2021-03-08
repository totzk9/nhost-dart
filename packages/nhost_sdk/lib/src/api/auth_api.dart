import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'core_codec.dart';

part 'auth_api.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  AuthResponse({
    this.session,
    this.user,
    this.mfa,
  });

  final Session session;
  final User user;

  /// Multi-factor Authentication information.
  ///
  /// This field will be `null` if MFA is not enabled for the user.
  final MultiFactorAuthenticationInfo mfa;

  static AuthResponse fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Session {
  Session({
    this.jwtToken,
    this.jwtExpiresIn,
    this.refreshToken,
    this.user,
  });

  final String jwtToken;
  @JsonKey(
    fromJson: durationFromMs,
    toJson: durationToMs,
  )
  final Duration jwtExpiresIn;
  final String refreshToken;
  final User user;

  static Session fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User({this.id, this.displayName, this.email});

  final String id;
  final String displayName;
  final String email;

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MultiFactorAuthenticationInfo {
  MultiFactorAuthenticationInfo({this.ticket});

  /// Ticket string to be provided to [Auth.mfaTotp] in order to continue the
  /// login process
  final String ticket;

  static MultiFactorAuthenticationInfo fromJson(Map<String, dynamic> json) =>
      _$MultiFactorAuthenticationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MultiFactorAuthenticationInfoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MfaResponse {
  MfaResponse({this.qrCode, this.otpSecret});

  /// Base64 data: image of the QR code
  @JsonKey(
    name: 'image_url',
    fromJson: uriDataFromString,
    toJson: uriDataToString,
  )
  final UriData qrCode;

  /// OTP secret
  final String otpSecret;

  static MfaResponse fromJson(Map<String, dynamic> json) =>
      _$MfaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MfaResponseToJson(this);
}