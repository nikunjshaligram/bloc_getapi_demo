import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_api_bloc/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {}

// Data Loading State
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

// Data Loaded State
class UserLoadedState extends UserState {
  UserLoadedState(this.users);

  final List<UserModel> users;

  @override
  List<Object?> get props => [users];
}

// Data Error Loading State

class UserErrorState extends UserState {
  UserErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
