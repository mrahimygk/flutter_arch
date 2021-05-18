import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
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

    return Center(
      child: Container(
        child: BlocBuilder(
          bloc: _cubit,
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
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
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, (){
                  _cubit.getPlantList();
                })
              );
            }

            if (state is PlantListDataReceivedState) {
              return _buildPlantListView(state.plants);
            }

            throw Exception("Please handle all states above");
          },
        ),
      ),
    );
  }

  @override
  PlantListCubit getPageBloc() => _cubit;

  Widget _buildPlantListView(List<Plant> plants) {
    return Text("Data received, we can make a list view");
  }
}
