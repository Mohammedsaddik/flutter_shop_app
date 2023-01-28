import 'package:flutter_shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitial extends ShopRegisterStates {}

class ShopRegisterLoading extends ShopRegisterStates {}

class ShopRegisterSucess extends ShopRegisterStates
{
  final ShopLoginModel loginModel;
  ShopRegisterSucess(this.loginModel);
}

class ShopRegisterError extends ShopRegisterStates
{
  final String error;
  ShopRegisterError(this.error);
}

class ShopRegisterChangePasswordVisibility extends ShopRegisterStates {}