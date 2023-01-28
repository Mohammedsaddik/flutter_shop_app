// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/shared/componnen/commponnents.dart';
import 'package:flutter_shop_app/shared/constant/constant.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model?.data?.name ?? "";
        emailController.text = model?.data?.email ?? "";
        phoneController.text = model?.data?.phone ?? "";
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    CostumTextFormFeild(
                      label: 'Name',
                      controller: nameController,
                      type: TextInputType.name,
                      prefix: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Sorry ! , Name can't be empty, Enter your Name ";
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CostumTextFormFeild(
                      label: 'Email',
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      prefix: Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Sorry ! , Email can't be empty, Enter your Email ";
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CostumTextFormFeild(
                      label: 'Phone',
                      controller: phoneController,
                      type: TextInputType.phone,
                      prefix: Icons.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Sorry ! , Phone can't be empty, Enter your Phone ";
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Defaultbotton(
                      text: 'LOGOUT',
                      function: () {
                        signOut(context);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Defaultbotton(
                      text: 'UPDATE',
                      function: () {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
