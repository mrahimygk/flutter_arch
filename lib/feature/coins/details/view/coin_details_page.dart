import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/common/widgets/drawer.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/feature/coins/details/logic/coin_details_cubit.dart';
import 'package:flutter_architecture/feature/coins/rates/view/coin_exchange_rates_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetailsPage
    extends BasePage<CoinDetailsCubit, CoinDetailsState, Coin> {
  final CoinDetailsCubit _cubit = serviceLocator.get<CoinDetailsCubit>();

  final VoidCallback onToggleTheme;

  CoinDetailsPage(this.onToggleTheme, {Key? key}) : super(key: key);

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    _cubit.getCoinDetails(args!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("coinDetails".tr()),
      ),
      drawer: AppDrawer(
        onToggleTheme: onToggleTheme,
        onLanguageChanged: (Locale? locale) {
          localization.EasyLocalization.of(context)!.setLocale(locale!);
        },
      ),
      body: BlocBuilder(
        bloc: _cubit,
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (BuildContext context, CoinDetailsState state) {
          if (state is CoinDetailsInitialState) {
            return Container(color: Colors.white);
          }

          if (state is CoinDetailsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CoinDetailsNoDataState) {
            return Text("No data, retry");
          }

          if (state is CoinDetailsErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getCoinDetails(args!.id);
                  })),
            );
          }

          if (state is CoinDetailsDataReceivedState) {
            return _buildCoinDetailsView(state.coin, direction, isDarkMode);
          }

          throw Exception(
              "Please handle all states above, unknown state $state");
        },
      ),
    );
  }

  @override
  CoinDetailsCubit getPageBloc() => _cubit;

  Widget _buildCoinDetailsView(
    Coin coin,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 48.0,
        ),
        Text(
          "${coin.name} (${coin.id})",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(coin.website),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Divider(indent: 32.0, endIndent: 32.0),
        ),
        Expanded(child: CoinExchangeRatesWidget(coin))
      ],
    );
  }
}
