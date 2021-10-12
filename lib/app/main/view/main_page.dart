import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class MainPage extends StatelessWidget {
  final PageController _pageController = PageController();

  MainPage({Key? key}) : super(key: key);

  void navigate(BuildContext context, int index) async {
    context.read<MainTabCubit>().updatePage(index);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => MainTabCubit(),
      child: BlocConsumer<MainTabCubit, MainTabState>(
        listener: (context, state) {
          _pageController.jumpToPage(state.index);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(localization.appName),
            ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePageView(),
                ReservationsPageView(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) => navigate(context, index),
              currentIndex: state.index,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: localization.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.card_travel),
                  label: localization.reservations,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
