import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/assets/dimens.dart';
import 'package:flutter_architecture/common/assets/durations.dart';
import 'package:flutter_architecture/common/assets/placeholders.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/common/widgets/drawer.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/model/coin/coin.dart';
import 'package:flutter_architecture/feature/coins/list/logic/coin_list_cubit.dart';
import 'package:flutter_architecture/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinListPage extends BasePage<CoinListCubit, CoinListState, void> {
  final CoinListCubit _cubit = serviceLocator.get<CoinListCubit>();

  final VoidCallback onToggleTheme;

  CoinListPage(this.onToggleTheme, {Key? key}) : super(key: key) {
    _cubit.getCoinList();
  }

  @override
  Widget buildPageWidget(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("coinList".tr()),
      ),
      drawer: AppDrawer(
        onToggleTheme: onToggleTheme,
        onLanguageChanged: (Locale? locale) {
          localization.EasyLocalization.of(context)!.setLocale(locale!);
        },
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder(
            bloc: _cubit,
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (BuildContext context, CoinListState state) {
              if (state is CoinListInitialState || state is CoinListNavigationState) {
                return Container(color: Colors.white);
              }

              if (state is CoinListLoadingState) {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }

              if (state is CoinListNoDataState) {
                return Text("No data, retry");
              }

              if (state is CoinListErrorState) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ApiErrorWidget(state.error, () {
                      _cubit.getCoinList();
                    }));
              }

              if (state is CoinListDataReceivedState) {
                return Expanded(
                    child:
                        _buildCoinListView(state.coins, direction, isDarkMode));
              }

              if (state is CoinListDataFilledState) {
                return Expanded(
                    child:
                        _buildCoinListView(state.coins, direction, isDarkMode));
              }

              throw Exception("Please handle all states above $state");
            },
          ),
        ],
      ),
    );
  }

  @override
  CoinListCubit getPageBloc() => _cubit;

  Widget _buildCoinListView(
      List<Coin> coins, TextDirection direction, bool isDarkMode) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            indent: 42,
            endIndent: 42,
            color: Colors.grey.withAlpha(100),
            height: 1,
          );
        },
        itemCount: coins.length,
        itemBuilder: (context, index) {
          final item = coins[index];
          return GestureDetector(
            onTapUp: (d){
              // _cubit.navigateToCoinDetails(item);
              Navigator.of(context).pushNamed(NavigationRoutes.COIN_DETAILS, arguments: item);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: item.url == null
                            ? Image.asset(
                                coinPlaceholderEmpty,
                                height: coinIconSize,
                                width: coinIconSize,
                              )
                            : Container(
                                height: coinIconSize,
                                width: coinIconSize,
                                child: FadeInImage(
                                  fadeOutDuration: const Duration(
                                      milliseconds: coinFadeDuration),
                                  fadeInDuration: const Duration(
                                      milliseconds: coinFadeDuration),
                                  imageErrorBuilder: (
                                    BuildContext context,
                                    Object error,
                                    StackTrace? stackTrace,
                                  ) {
                                    return Image.asset(coinIconErrorPlaceholder);
                                  },
                                  placeholder: AssetImage(isDarkMode
                                      ? coinPlaceholderDark
                                      : coinPlaceholder),
                                  image: NetworkImage("${item.url}"),
                                ),
                              ),
                      ),
                      Flexible(
                          child: Text(
                        "${item.name} (${item.id})",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.website),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
