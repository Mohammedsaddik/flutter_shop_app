import 'package:flutter_shop_app/models/change_favorite_model.dart';
import 'package:flutter_shop_app/models/login_model.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState
{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopState {}

class ShopErrorChangeFavoritesState extends ShopState {}

class ShopLoadingGetFavoritesState extends ShopState {}

class ShopSuccessGetFavoritesState extends ShopState {}

class ShopErrorGetFavoritesState extends ShopState {}


class ShopLoadingUserDataState extends ShopState {}

class ShopSuccessUserDataState extends ShopState
{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopState {}


class ShopLoadingUpdateUserState extends ShopState {}

class ShopSuccessUpdateUserState extends ShopState
{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopState {}