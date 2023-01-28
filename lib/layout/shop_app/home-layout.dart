// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/modules/login/login_screen/login_screen.dart';
import '../../modules/search/search_screen/search_screen.dart';
import 'package:flutter_shop_app/network/local_cash/cash_helper.dart';
import 'package:flutter_shop_app/shared/componnen/commponnents.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('souq'),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body:cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottum(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home
                  ),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.apps
                  ),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite
                  ),
                  label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings
                  ),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
