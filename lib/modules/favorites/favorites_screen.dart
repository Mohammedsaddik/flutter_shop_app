// ignore_for_file: prefer_const_constructors, unnecessary_import
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/models/get_favorites.dart';
import 'package:flutter_shop_app/models/get_favorites.dart';
import 'package:flutter_shop_app/models/get_favorites.dart';
import 'package:flutter_shop_app/models/get_favorites.dart';
import 'package:flutter_shop_app/shared/componnen/commponnents.dart';
import 'package:flutter_shop_app/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state)
      {
        final favoritesModel = ShopCubit.get(context).favoritesModel!;
        if(favoritesModel?.data?.data !=null)
          {
            return ConditionalBuilder(
              condition: state is! ShopLoadingGetFavoritesState,
              builder:(context)=> ListView.separated(
                itemBuilder:(context,index)=> buildListProduct(favoritesModel.data!.data![index].product!,context),
                separatorBuilder:(context,index)=>Divider(),
                itemCount: favoritesModel!.data!.data!.length,
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator()),
            );
          }
        else
          {
            return Container();
          }
      },
    );
    ;
  }


}
