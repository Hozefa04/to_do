part of 'nav_cubit.dart';

@immutable
abstract class NavState extends Equatable {
  const NavState();

  @override
  List<Object> get props => [];
}

class NavInitial extends NavState {
  const NavInitial();

  @override
  List<Object> get props => [];
}
