// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/home-layout.dart';
import 'package:flutter_shop_app/modules/login/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/login/cubit/states.dart';
import 'package:flutter_shop_app/modules/register/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/register/cubit/states.dart';
import 'package:flutter_shop_app/network/local_cash/cash_helper.dart';
import 'package:flutter_shop_app/shared/componnen/commponnents.dart';
import 'package:flutter_shop_app/shared/constant/constant.dart';
import 'package:flutter_shop_app/style/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSucess) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                message: state.loginModel.message.toString(),
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: defaultColor,
                                  ),
                        ),
                        Text(
                          'Register now to brows our hot offers',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CostumTextFormFeild(
                          label: 'User Name',
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Name can't be empty, Enter your name ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CostumTextFormFeild(
                          label: 'Email Address',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Email can't be empty, Enter your email ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CostumTextFormFeild(
                          label: 'Password',
                          isPassword:
                              ShopRegisterCubit.get(context).isPasswordShow,
                          controller: passwordController,
                          type: TextInputType.phone,
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onTap: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {},
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Password is too short ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CostumTextFormFeild(
                          label: 'Phone',
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Phone can't be empty, Enter your phone ";
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoading,
                          builder: (context) => Defaultbotton(
                            radius: 5.0,
                            text: 'register',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                              ;
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
