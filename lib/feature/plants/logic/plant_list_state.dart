part of 'plant_list_cubit.dart';

abstract class PlantListState extends PageState {
  const PlantListState();
}

class PlantListInitialState extends PlantListState {
  @override
  List<Object?> get props => [];
}

class PlantListLoadingState extends PlantListState {
  @override
  List<Object?> get props => [];
}

class PlantListNoDataState extends PlantListState {
  @override
  List<Object?> get props => [];
}

class PlantListErrorState extends PlantListState {
  final String error;

  PlantListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PlantListDataReceivedState extends PlantListState {
  final List<Plant> plants;

  PlantListDataReceivedState(this.plants);

  @override
  List<Object?> get props => [plants];

}

//TODO: add navigate state to go to details