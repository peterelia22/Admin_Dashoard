import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/entities/report_entity.dart';
import '../../../../domain/repos/reports_repo.dart';

part 'get_reports_state.dart';

class GetReportsCubit extends Cubit<GetReportsState> {
  final ReportsRepo reportsRepo;
  StreamSubscription? streamSubscription;

  GetReportsCubit(this.reportsRepo) : super(GetReportsInitial());
  void fetchReports() {
    emit(GetReportsLoading());
    streamSubscription = reportsRepo.streamReports().listen((either) {
      either.fold(
        (failure) => emit(GetReportsError(failure.message)),
        (reports) => emit(GetReportsLoaded(reports)),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
