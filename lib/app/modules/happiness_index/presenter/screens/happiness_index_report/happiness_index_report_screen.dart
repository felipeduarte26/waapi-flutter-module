import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import 'widgets/happiness_index_report_analytics_widget.dart';
import 'widgets/happiness_index_report_calendar_widget.dart';

class HappinessIndexReportScreen extends StatefulWidget {
  final String employeeId;

  const HappinessIndexReportScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<HappinessIndexReportScreen> createState() => _HappinessIndexReportScreenState();
}

class _HappinessIndexReportScreenState extends State<HappinessIndexReportScreen> {
  int tabIndex = 0;
  final PageController _pageController = PageController();
  final _scrollController = ScrollController(
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          titleLabel: context.translate.moodDiary,
          scrollController: _scrollController,
          tabBarConfig: _tabBarConfig(
            tabs: [
              context.translate.calendar,
              context.translate.analysis,
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _onSelect(value);
                    });
                  },
                  controller: _pageController,
                  children: [
                    HappinessIndexReportCalendarWidget(
                      employeeId: widget.employeeId,
                    ),
                    HappinessIndexReportAnalyticsWidget(
                      employeeId: widget.employeeId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onWillPop() {
    Modular.to.pop();
  }

  dynamic _onSelect(int newValue) {
    if (newValue == 0) {
      setState(() {
        _pageController.jumpToPage(0);
      });
    }

    if (newValue == 1) {
      setState(() {
        _pageController.jumpToPage(1);
      });
    }
    tabIndex = newValue;
  }

  TabBarConfig _tabBarConfig({
    required List<String> tabs,
  }) {
    return TabBarConfig(
      tabs: tabs,
      onSelect: _onSelect,
      tabIndex: tabIndex,
    );
  }
}
