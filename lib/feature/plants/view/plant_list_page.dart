import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/model/plant/plant.dart';
import 'package:flutter_architecture/feature/plants/logic/plant_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantListPage extends BasePage<PlantListCubit, PlantListState, void> {
  final PlantListCubit _cubit = serviceLocator.get<PlantListCubit>();

  PlantListPage({Key? key}) : super(key: key);

  @override
  Widget buildPageWidget(BuildContext context) {
    _cubit.getPlantList();

    return Container(
      color: Colors.blueGrey,
      child: BlocBuilder(
        bloc: _cubit,
        buildWhen: (previousState, currentState) {
          return true;
        },
        builder: (BuildContext context, PlantListState state) {
          if (state is PlantListInitialState) {
            return Container(color: Colors.white);
          }

          if (state is PlantListLoadingState) {
            return CircularProgressIndicator();
          }

          if (state is PlantListNoDataState) {
            return Text("No data, retry");
          }

          if (state is PlantListErrorState) {
            return Text("Error, retry");
          }

          if (state is PlantListDataReceivedState) {
            return _buildPlantListView(state.plants);
          } else {
            throw Exception("Please handle all states above");
          }
        },
      ),
    );
  }

  @override
  PlantListCubit getPageBloc() => _cubit;

  Widget _buildPlantListView(List<Plant> plants) {
    return Text("Data received, we can make a list view");
  }
}
