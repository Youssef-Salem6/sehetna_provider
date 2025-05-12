import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sehetne_provider/fetures/profile/manager/userAnalytics/user_analytics_cubit.dart';
import 'package:sehetne_provider/fetures/profile/models/analytics_model.dart';
import 'package:sehetne_provider/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  @override
  void initState() {
    super.initState();
    context.read<UserAnalyticsCubit>().getUserAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff009379),
        elevation: 0,
        title: Text(
          S.of(context).analytics,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<UserAnalyticsCubit, UserAnalyticsState>(
        builder: (context, state) {
          if (state is UserAnalyticsLoading) {
            return _buildLoadingShimmer();
          } else if (state is UserAnalyticsFailure) {
            return Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            );
          } else if (state is UserAnalyticsSuccess) {
            final analytics = context.read<UserAnalyticsCubit>().analyticsModel;
            return _buildDashboard(analytics);
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerCard(height: 180),
            const SizedBox(height: 20),
            _buildShimmerCard(height: 240),
            const SizedBox(height: 20),
            _buildShimmerCard(height: 280),
            const SizedBox(height: 20),
            _buildShimmerCard(height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildDashboard(AnalyticsModel analytics) {
    return RefreshIndicator(
      color: const Color(0xff009379),
      onRefresh: () async {
        await context.read<UserAnalyticsCubit>().getUserAnalytics();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRequestsCard(analytics),
              const SizedBox(height: 20),
              _buildEarningsCard(analytics),
              const SizedBox(height: 20),
              _buildRatingsCard(analytics),
              const SizedBox(height: 20),
              _buildPerformanceCard(analytics),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsCard(AnalyticsModel analytics) {
    final completedPercent =
        analytics.totalRequests == 0
            ? 0.0
            : (analytics.completedRequests! / analytics.totalRequests!) * 100;
    final cancelledPercent =
        analytics.totalRequests == 0
            ? 0.0
            : (analytics.cancelledRequests! / analytics.totalRequests!) * 100;
    final pendingPercent = 100 - completedPercent - cancelledPercent;

    return _buildCard(
      title: 'Request Statistics',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('Total', '${analytics.totalRequests ?? 0}'),
              _buildStat('Completed', '${analytics.completedRequests ?? 0}'),
              _buildStat('Cancelled', '${analytics.cancelledRequests ?? 0}'),
            ],
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 2.5,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: const Color(0xff009379),
                    value: completedPercent,
                    title: '${completedPercent.toStringAsFixed(1)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: cancelledPercent,
                    title: '${cancelledPercent.toStringAsFixed(1)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: pendingPercent,
                    title: '${pendingPercent.toStringAsFixed(1)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                startDegreeOffset: -90,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 16,
            children: [
              _buildLegendItem('Completed', const Color(0xff009379)),
              _buildLegendItem('Cancelled', Colors.red),
              _buildLegendItem('Pending', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard(AnalyticsModel analytics) {
    // Convert String earnings to double for the chart
    final currentMonthEarnings =
        double.tryParse(analytics.currentMonthEarnings ?? '0') ?? 0;
    final previousMonthEarnings =
        double.tryParse(analytics.previousMonthEarnings ?? '0') ?? 0;
    final yearlyEarnings =
        double.tryParse(analytics.yearlyEarnings ?? '0') ?? 0;
    final totalEarnings = double.tryParse(analytics.totalEarnings ?? '0') ?? 0;

    return _buildCard(
      title: 'Earnings Analysis',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('Total', analytics.totalEarnings ?? '0'),
              _buildStat('This Month', analytics.currentMonthEarnings ?? '0'),
              _buildStat('Last Month', analytics.previousMonthEarnings ?? '0'),
            ],
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: yearlyEarnings * 1.2,
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: previousMonthEarnings,
                        gradient: _buildBarGradient(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: currentMonthEarnings,
                        gradient: _buildBarGradient(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: yearlyEarnings,
                        gradient: _buildBarGradient(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: totalEarnings,
                        gradient: _buildBarGradient(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final titles = [
                          'Last Month',
                          'This Month',
                          'Yearly',
                          'Total',
                        ];
                        final Widget text = Text(
                          titles[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xff004338),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        );
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsCard(AnalyticsModel analytics) {
    final ratings = [
      analytics.rate1 ?? 0,
      analytics.rate2 ?? 0,
      analytics.rate3 ?? 0,
      analytics.rate4 ?? 0,
      analytics.rate5 ?? 0,
    ];
    final maxRating =
        ratings.reduce((curr, next) => curr > next ? curr : next).toDouble();

    return _buildCard(
      title: 'Rating & Feedback',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatWithIcon(
                'Rating',
                analytics.averageRating ?? '0',
                Icons.star,
                Colors.amber,
              ),
              _buildStat('Feedbacks', '${analytics.totalFeedbacks ?? 0}'),
            ],
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxRating * 1.2,
                barGroups: List.generate(5, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: ratings[index].toDouble(),
                        gradient: LinearGradient(
                          colors: [
                            index < 2
                                ? Colors.redAccent
                                : (index < 3
                                    ? Colors.amberAccent
                                    : const Color(0xff009379)),
                            index < 2
                                ? Colors.red
                                : (index < 3
                                    ? Colors.amber
                                    : const Color(0xff004338)),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        width: 20,
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${value.toInt() + 1}',
                                style: const TextStyle(
                                  color: Color(0xff004338),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(AnalyticsModel analytics) {
    return _buildCard(
      title: 'Performance Metrics',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatWithIcon(
                'Acceptance Rate',
                '${analytics.acceptanceRate?.toStringAsFixed(1) ?? "0"}%',
                Icons.check_circle,
                const Color(0xff009379),
              ),
              _buildStatWithIcon(
                'Cancellation Rate',
                '${analytics.cancellationRate?.toStringAsFixed(1) ?? "0"}%',
                Icons.cancel,
                Colors.redAccent,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildLinearProgressIndicator(
            'Acceptance Rate',
            analytics.acceptanceRate?.toDouble() ?? 0,
            const Color(0xff009379),
          ),
          const SizedBox(height: 10),
          _buildLinearProgressIndicator(
            'Cancellation Rate',
            analytics.cancellationRate!.toDouble(),
            Colors.redAccent,
          ),
          const SizedBox(height: 20),
          _buildCompletionTimeDisplay(
            analytics.averageCompletionTime?.toDouble() ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionTimeDisplay(double time) {
    final hours = time.floor();
    final minutes = ((time - hours) * 60).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time, color: Color(0xff004338), size: 28),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Average Completion Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff004338),
                ),
              ),
              Text(
                '$hours hr ${minutes.toString().padLeft(2, '0')} min',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff009379),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinearProgressIndicator(
    String label,
    double value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xff004338), fontSize: 12),
            ),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff004338),
            ),
          ),
          const Divider(color: Color(0xff009379), thickness: 1),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff004338),
          ),
        ),
      ],
    );
  }

  Widget _buildStatWithIcon(
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff004338),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xff004338)),
        ),
      ],
    );
  }

  LinearGradient _buildBarGradient() {
    return const LinearGradient(
      colors: [Color(0xff009379), Color(0xff004338)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}
