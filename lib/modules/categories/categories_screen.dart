// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ListView.separated(
          itemBuilder:(context,index)=> buildCatIteam(ShopCubit.get(context).categorieModel!.data!.data![index]),
          separatorBuilder:(context,index)=>Divider(),
          itemCount: ShopCubit.get(context).categorieModel?.data?.data?.length??0,
        );
      },
    );
  }

  Widget buildCatIteam(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
            )
          ],
        ),
      );
}
