import 'package:flutter_shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitial extends ShopLoginStates {}

class ShopLoginLoading extends ShopLoginStates {}

class ShopLoginSucess extends ShopLoginStates
{
  final ShopLoginModel loginModel;
  ShopLoginSucess(this.loginModel);
}

class ShopLoginError extends ShopLoginStates
{
  final String error;
  ShopLoginError(this.error);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates {}