import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/navigation/type.dart';

abstract class PageState extends Equatable {
  const PageState();
}

abstract class NavigationState extends PageState {
  final String destination;
  final dynamic args;
  final String? popUntil;
  final NavigationType? navigationType;

  NavigationState(
    this.destination,
    this.args, {
    this.popUntil,
    this.navigationType,
  });
}
