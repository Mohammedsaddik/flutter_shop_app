import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/models/change_favorite_model.dart';
import 'package:flutter_shop_app/models/get_favorites.dart';
import 'package:flutter_shop_app/models/home_model.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/categories/categories_screen.dart';
import 'package:flutter_shop_app/modules/favorites/favorites_screen.dart';
import 'package:flutter_shop_app/modules/products/products_screen.dart';
import 'package:flutter_shop_app/modules/settings/settings_screen.dart';
import 'package:flutter_shop_app/network/end_point/end_point.dart';
import 'package:flutter_shop_app/network/local_cash/cash_helper.dart';
import 'package:flutter_shop_app/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/constant/constant.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottum(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categorieModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categorieModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId)
  {
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id':productId,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!)
        {
          favorites[productId]=!favorites[productId]!;
        }else
          {
            getFavoritesData();
          }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATEPROFILE,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name!);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }
}