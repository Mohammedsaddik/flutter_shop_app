// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/search/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/search/cubit/states.dart';
import 'package:flutter_shop_app/shared/componnen/commponnents.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var SearchController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CostumTextFormFeild(
                        label: 'Search',
                        controller: SearchController,
                        type: TextInputType.text,
                        prefix: Icons.search,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Sorry ! , Search can't be empty, Enter your text ";
                          } else {}
                        },
                        onSubmit: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                      ),
                      SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                      if(state is SearchSucessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder:(context,index)=> buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice :false),
                          separatorBuilder:(context,index)=>Divider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
