class AnalyticsModel {
  int? totalRequests;
  int? completedRequests;
  int? cancelledRequests;
  int? currentMonthRequests;
  int? previousMonthRequests;
  String? totalEarnings;
  String? currentMonthEarnings;
  String? previousMonthEarnings;
  String? yearlyEarnings;
  String? averageRating;
  int? totalFeedbacks;
  int? rate5, rate4, rate3, rate2, rate1;
  int? averageCompletionTime;
  int? acceptanceRate;
  int? cancellationRate;

  AnalyticsModel({
    required this.totalRequests,
    required this.completedRequests,
    required this.cancelledRequests,
    required this.currentMonthRequests,
    required this.previousMonthRequests,
    required this.totalEarnings,
    required this.currentMonthEarnings,
    required this.previousMonthEarnings,
    required this.yearlyEarnings,
    required this.averageRating,
    required this.totalFeedbacks,
    required this.averageCompletionTime,
    required this.acceptanceRate,
    required this.cancellationRate,
    required this.rate1,
    required this.rate2,
    required this.rate3,
    required this.rate4,
    required this.rate5,
  });

  AnalyticsModel.fromJson({required Map json}) {
    Map requestStatistics = json["request_statistics"];
    Map earningsAnalysis = json["earnings_analysis"];
    Map feedbackAnalysis = json["feedback_analysis"];
    Map performanceMetrics = json["performance_metrics"];
    totalRequests = requestStatistics["total_requests"];
    completedRequests = requestStatistics["completed_requests"];
    cancelledRequests = requestStatistics["cancelled_requests"];
    currentMonthRequests = requestStatistics["current_month_requests"];
    previousMonthRequests =
        requestStatistics["totalprevious_month_requests_requests"];
    totalEarnings = earningsAnalysis["total_earnings"].toString();
    currentMonthEarnings =
        earningsAnalysis["current_month_earnings"].toString();
    previousMonthEarnings =
        earningsAnalysis["previous_month_earnings"].toString();
    yearlyEarnings = earningsAnalysis["yearly_earnings"].toString();
    averageRating = feedbackAnalysis["average_rating"].toString();
    totalRequests = feedbackAnalysis["total_feedbacks"];
    rate1 = feedbackAnalysis["rating_distribution"]["1"] ?? 0;
    rate2 = feedbackAnalysis["rating_distribution"]["2"] ?? 0;
    rate3 = feedbackAnalysis["rating_distribution"]["3"] ?? 0;
    rate4 = feedbackAnalysis["rating_distribution"]["4"] ?? 0;
    rate5 = feedbackAnalysis["rating_distribution"]["5"] ?? 0;
    averageCompletionTime = performanceMetrics["average_completion_time"];
    acceptanceRate = performanceMetrics["acceptance_rate"] ?? 0;
    cancellationRate = performanceMetrics["cancellation_rate"];
  }
}
