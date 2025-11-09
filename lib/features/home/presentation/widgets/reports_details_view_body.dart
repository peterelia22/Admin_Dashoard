import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app_theme.dart';
import '../../../../core/entities/report_entity.dart';
import '../../../../core/enums/report_status_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/cubits/update_order_cubit/update_report_cubit.dart';
import 'report_details_header.dart';
import 'report_details_info_card.dart';
import 'report_media_gallery.dart';
import 'update_status_section.dart';

class ReportsDetailsViewBody extends StatefulWidget {
  final ReportEntity report;
  final bool isLoading;

  const ReportsDetailsViewBody({
    super.key,
    required this.report,
    this.isLoading = false,
  });

  @override
  State<ReportsDetailsViewBody> createState() => _ReportsDetailsViewBodyState();
}

class _ReportsDetailsViewBodyState extends State<ReportsDetailsViewBody> {
  ReportStatusEnum? selectedStatus;
  final TextEditingController _commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.report.status;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: BlocConsumer<UpdateReportCubit, UpdateReportState>(
        listener: (context, state) {
          if (state is UpdateReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تحديث البلاغ بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is UpdateReportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isUpdating = state is UpdateReportLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReportDetailsHeader(report: widget.report),
                  const SizedBox(height: 20),

                  ReportDetailsInfoCard(report: widget.report),
                  const SizedBox(height: 20),

                  if (widget.report.mediaUrls.isNotEmpty) ...[
                    ReportMediaGallery(mediaUrls: widget.report.mediaUrls),
                    const SizedBox(height: 20),
                  ],

                  UpdateStatusSection(
                    currentStatus: widget.report.status,
                    selectedStatus: selectedStatus,
                    onStatusChanged: (status) {
                      setState(() {
                        selectedStatus = status;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Admin Comment
                  CustomTextField(
                    labelText: 'تعليق المسؤول',
                    hintText: '...أضف تعليقك أو ملاحظاتك حول البلاغ',
                    obscureText: false,
                    maxLines: 5,
                    controller: _commentController,
                    validator: (value) {
                      if (selectedStatus != widget.report.status &&
                          (value == null || value.isEmpty)) {
                        return 'يرجى إضافة تعليق عند تغيير الحالة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  CustomButton(
                    gradientColors: AppTheme.primaryGradientColors,
                    shadowColor: AppTheme.primaryShadowColor,
                    onPressed: isUpdating
                        ? null
                        : () {
                            final hasStatusChange =
                                selectedStatus != widget.report.status;
                            final hasCommentChange =
                                _commentController.text.isNotEmpty;

                            if (!hasStatusChange && !hasCommentChange) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('لا توجد تغييرات للحفظ'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              final updatedReport = widget.report.copyWith(
                                status: selectedStatus,
                                updatedAt: DateTime.now(),
                                adminComment: _commentController.text.isNotEmpty
                                    ? _commentController.text
                                    : null,
                              );
                              context.read<UpdateReportCubit>().updateReport(
                                updatedReport,
                              );
                            }
                          },
                    text: isUpdating ? '...جاري الحفظ' : 'حفظ التغييرات',

                    borderRadius: 12,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
