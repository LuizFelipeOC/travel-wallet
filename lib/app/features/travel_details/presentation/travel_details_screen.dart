import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extends/extends.dart';
import '../../../core/result/result.dart';
import '../../../di/di.dart';
import '../../../routers/app_routes.dart';
import '../../home/state/home_controller.dart';
import '../../traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import '../../traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';
import '../state/travel_details_controller.dart';
import '../state/travel_details_state.dart';
import '../widgets/budget_progress.dart';
import '../widgets/category_filter.dart';
import '../widgets/expense_tile.dart';
import '../widgets/new_expense_sheet.dart';

enum _TravelAction { edit, delete }

class TravelDetailsScreen extends StatefulWidget {
  final CreateFormRequestModel travel;

  const TravelDetailsScreen({super.key, required this.travel});

  @override
  State<TravelDetailsScreen> createState() => _TravelDetailsScreenState();
}

class _TravelDetailsScreenState extends State<TravelDetailsScreen> {
  final controller = getIt.get<TravelDetailsController>();

  late CreateFormRequestModel _travel = widget.travel;

  bool get _isFinished => _travel.isFinished;

  @override
  void initState() {
    super.initState();

    controller.loadExpenses(travel: _travel);
  }

  Future<void> _addExpense() async {
    final result = await NewExpenseSheet.show(context, initialDate: _travel.startDate);

    if (result == null) {
      return;
    }

    await controller.addExpense(
      description: result.description,
      amount: result.amount,
      category: result.category,
      date: result.date,
    );
  }

  Future<void> _removeExpense(String id, String removedMessage) async {
    await controller.removeExpense(id: id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(removedMessage)));
  }

  Future<void> _editTravel() async {
    await context.push(
      AppRoutes.travelerPlannerForm,
      extra: {'isFirstTimeUser': false, 'travel': _travel},
    );

    if (!mounted) {
      return;
    }

    // The form writes straight to the database, so the travel is read back to
    // refresh this screen and the home list.
    await getIt.get<HomeController>().loadTravels();

    final result = await getIt.get<CreateFormRepository>().getTravels();

    if (!mounted || result is! Success<List<CreateFormRequestModel>>) {
      return;
    }

    final updated = result.data.where((travel) => travel.id == _travel.id).firstOrNull;

    if (updated == null) {
      context.popOrGo(AppRoutes.home);
      return;
    }

    setState(() => _travel = updated);
    await controller.loadExpenses(travel: updated);
  }

  Future<void> _deleteTravel(AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.details_delete_confirm_title),
        content: Text(l10n.details_delete_confirm_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.details_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: Text(l10n.details_delete_confirm_action),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    await getIt.get<CreateFormRepository>().deleteTravel(id: _travel.id);
    await getIt.get<HomeController>().loadTravels();

    if (mounted) {
      context.popOrGo(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final dateFormat = DateFormat.yMMMd(locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.popOrGo(AppRoutes.home),
        ),
        title: Text(_travel.travelName, style: theme.textTheme.bodyLarge),
        actions: [
          PopupMenuButton<_TravelAction>(
            icon: const Icon(Icons.more_vert),
            onSelected: (action) => switch (action) {
              _TravelAction.edit => _editTravel(),
              _TravelAction.delete => _deleteTravel(l10n),
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _TravelAction.edit,
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.details_edit_travel),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _TravelAction.delete,
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20, color: theme.colorScheme.error),
                    const SizedBox(width: 12),
                    Text(
                      l10n.details_delete_travel,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _isFinished
          ? null
          : FloatingActionButton.extended(
              onPressed: _addExpense,
              backgroundColor: AppColors.amber300,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text(l10n.details_add_expense),
            ),
      body: ValueListenableBuilder<ITravelDetailsState>(
        valueListenable: controller,
        builder: (context, state, _) {
          if (state is TravelDetailsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            );
          }

          if (state is! TravelDetailsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final expenses = state.filteredExpenses;

          return RefreshIndicator(
            onRefresh: () => controller.loadExpenses(travel: _travel),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${dateFormat.format(_travel.startDate)} - '
                          '${dateFormat.format(_travel.endDate)}',
                          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 20),
                        BudgetProgress(state: state),
                        if (_isFinished) ...[
                          const SizedBox(height: 20),
                          _FinishedBanner(message: l10n.details_finished_travel),
                        ],
                      ],
                    ),
                  ),
                ),
                if (state.usedCategories.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CategoryFilter(
                        categories: state.usedCategories,
                        selected: state.selectedCategory,
                        totals: state.totalsByCategory,
                        onSelected: controller.filterByCategory,
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Text(
                      l10n.details_expenses_title,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if (expenses.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Center(
                        child: Text(
                          state.selectedCategory == null
                              ? l10n.details_empty_expenses
                              : l10n.details_empty_category,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                    sliver: SliverList.separated(
                      itemCount: expenses.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final expense = expenses[index];

                        return ExpenseTile(
                          expense: expense,
                          // A closed travel is read only.
                          onRemove: _isFinished
                              ? null
                              : () => _removeExpense(expense.id, l10n.details_expense_removed),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FinishedBanner extends StatelessWidget {
  final String message;

  const _FinishedBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.amber300.withValues(alpha: isDark ? 0.16 : 0.14),
        border: Border.all(color: AppColors.amber300.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(message, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13))),
        ],
      ),
    );
  }
}
