import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/seach_model.dart';
import 'package:flutter_shop_app/modules/search/cubit/states.dart';
import 'package:flutter_shop_app/network/end_point/end_point.dart';
import 'package:flutter_shop_app/network/local_cash/cash_helper.dart';
import 'package:flutter_shop_app/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/constant/constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String? text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'text': text,
      },
    ).then((value)
    {
      model=SearchModel.fromJson(value.data);
      emit(SearchSucessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorsState());
    });
  }
}
