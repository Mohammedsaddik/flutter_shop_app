// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/shop_app/cubit/state.dart';
import 'package:flutter_shop_app/layout/shop_app/home-layout.dart';
import 'package:flutter_shop_app/modules/login/login_screen/login_screen.dart';
import 'package:flutter_shop_app/network/local_cash/cash_helper.dart';
import 'package:flutter_shop_app/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/style/themes.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observe/bloc_obsevable.dart';

void main()async
{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isDark=CacheHelper.getData(key: 'isDark');
  String? token=CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if(onBoarding !=null)
    {
      if(token !=null)widget=ShopLayout();
      else widget=ShopLoginScreen();
    }
  else
    {
      widget=OnBoardingScreen();
    }
  print(onBoarding);
  runApp(MyApp(
      startWidget:widget
  ));
}
class MyApp extends StatelessWidget
{
  final Widget startWidget;
  MyApp({
    required this.startWidget,
});
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheam,
            darkTheme:lightTheam ,
            home: startWidget,
          );
        },
      ),
    );
  }
}



