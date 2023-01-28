
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/register/cubit/states.dart';
import 'package:flutter_shop_app/network/end_point/end_point.dart';
import 'package:flutter_shop_app/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/constant/constant.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitial());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  bool isPasswordShow = true;
  IconData suffix = Icons.visibility_outlined;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit(ShopRegisterLoading());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value)
    {
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSucess(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterError(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibility());
  }
}
