import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/login/cubit/states.dart';
import 'package:flutter_shop_app/network/end_point/end_point.dart';
import 'package:flutter_shop_app/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  bool isPasswordShow = true;
  IconData suffix = Icons.visibility_outlined;
  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoading());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSucess(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibility());
  }
}
