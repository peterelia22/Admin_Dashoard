import 'package:admin_dashboard/core/entities/report_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_report_state.dart';

class UpdateReportCubit extends Cubit<UpdateReportState> {
  UpdateReportCubit() : super(UpdateReportInitial());
}
