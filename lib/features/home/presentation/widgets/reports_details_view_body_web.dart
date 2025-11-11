import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app_theme.dart';
import '../../../../core/entities/report_entity.dart';
import '../../../../core/enums/report_status_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/cubits/update_reports_cubit/update_report_cubit.dart';
import 'report_details_header.dart';
import 'report_details_info_card.dart';
import 'report_media_gallery.dart';
import 'update_status_section.dart';

class ReportsDetailsViewBodyWeb extends StatefulWidget {
  final ReportEntity report;
  final bool isLoading;

  const ReportsDetailsViewBodyWeb({
    super.key,
    required this.report,
    this.isLoading = false,
  });

  @override
  State<ReportsDetailsViewBodyWeb> createState() =>
      _ReportsDetailsViewBodyWebState();
}

class _ReportsDetailsViewBodyWebState extends State<ReportsDetailsViewBodyWeb> {
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

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - Report Info
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ReportDetailsHeader(report: widget.report),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ReportDetailsInfoCard(
                                report: widget.report,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (widget.report.mediaUrls.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ReportMediaGallery(
                                  mediaUrls: widget.report.mediaUrls,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      // Right Column - Update Section
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'تحديث البلاغ',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              UpdateStatusSection(
                                currentStatus: widget.report.status,
                                selectedStatus: selectedStatus,
                                onStatusChanged: (status) {
                                  setState(() {
                                    selectedStatus = status;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              CustomTextField(
                                labelText: 'تعليق المسؤول',
                                hintText:
                                    '...أضف تعليقك أو ملاحظاتك حول البلاغ',
                                obscureText: false,
                                maxLines: 8,
                                controller: _commentController,
                                validator: (value) {
                                  if (selectedStatus != widget.report.status &&
                                      (value == null || value.isEmpty)) {
                                    return 'يرجى إضافة تعليق عند تغيير الحالة';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                height: 56,
                                child: CustomButton(
                                  gradientColors:
                                      AppTheme.primaryGradientColors,
                                  shadowColor: AppTheme.primaryShadowColor,
                                  onPressed: isUpdating
                                      ? null
                                      : () {
                                          final hasStatusChange =
                                              selectedStatus !=
                                              widget.report.status;
                                          final hasCommentChange =
                                              _commentController
                                                  .text
                                                  .isNotEmpty;

                                          if (!hasStatusChange &&
                                              !hasCommentChange) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'لا توجد تغييرات للحفظ',
                                                ),
                                                backgroundColor: Colors.orange,
                                              ),
                                            );
                                            return;
                                          }

                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            final updatedReport = widget.report
                                                .copyWith(
                                                  status: selectedStatus,
                                                  updatedAt: DateTime.now(),
                                                  adminComment:
                                                      _commentController
                                                          .text
                                                          .isNotEmpty
                                                      ? _commentController.text
                                                      : null,
                                                );
                                            context
                                                .read<UpdateReportCubit>()
                                                .updateReport(updatedReport);
                                          }
                                        },
                                  text: isUpdating
                                      ? '...جاري الحفظ'
                                      : 'حفظ التغييرات',
                                  borderRadius: 12,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
