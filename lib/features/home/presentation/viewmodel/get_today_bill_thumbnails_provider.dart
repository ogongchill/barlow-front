import 'package:flutter/cupertino.dart';
import 'package:front/core/api/fetch_status.dart';
import 'package:front/features/home/domain/entities/today_bill_thumbnail.dart';
import 'package:front/features/home/domain/usecases/get_today_bill_thumbnails_usecase.dart';

class GetTodayBillThumbnailsProvider with ChangeNotifier {

  final GetTodayBillThumbnailsUseCase _useCase;
  List<TodayBillThumbnail> _thumbnails = [];
  FetchStatus status = FetchStatus.initial;

  GetTodayBillThumbnailsProvider(this._useCase);

  List<TodayBillThumbnail> get thumbnails => _thumbnails;

  Future<void> fetch() async {
    try {
      _thumbnails = await _useCase.fetch();
      if(thumbnails.isEmpty) {
        status = FetchStatus.empty;
      }
      status = FetchStatus.loaded;
    } catch (e) {
      status = FetchStatus.error;
    }
  }
}