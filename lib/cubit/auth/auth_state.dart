import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({required this.isSignedIn});

  final bool isSignedIn;
  @override
  List<Object> get props => [isSignedIn];
}

AuthState copyWith({required bool isSignedIn}) {
  return AuthState(isSignedIn: isSignedIn);
}
