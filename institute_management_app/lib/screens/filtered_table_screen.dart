import 'package:flutter/material.dart';
import 'package:institute_management_app/components/build_content.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:institute_management_app/reusable_widgets/label_heading_widget.dart';
import 'package:institute_management_app/services/time_table_service.dart';

class FilterTableScreen extends StatefulWidget {
  final String filterLabel;
  final String filterValue;
  const FilterTableScreen(
      {Key? key, required this.filterValue, required this.filterLabel})
      : super(key: key);

  @override
  State<FilterTableScreen> createState() => _FilterTableScreenState();
}

class _FilterTableScreenState extends State<FilterTableScreen> {
  final _scrollController = ScrollController();
  double _opacity = 0.0;
  double _padding = 0.0;
  late final String label;
  late final String value;

  @override
  void initState() {
    super.initState();
    label = widget.filterLabel.toUpperCase();
    value = widget.filterValue;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _padding = 8.0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Free up any resources that the ScrollController uses
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151e3d),
      appBar: AppBar(
        backgroundColor: const Color(0xff191923),
        title: const Text("Filtered Time Table"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.all(_padding),
        child: Opacity(
          opacity: _opacity,
          child: Column(children: [
            const SizedBox(height: 16),
            LabelHeading(
                label: '$label: ${value.toUpperCase()}',
                color: const Color(0xffffffff)),
            Expanded(
              child: StreamBuilder<List<TimeTable>>(
                stream: getTimeTables(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<TimeTable> timeTables = snapshot.data!;

                    if (label == 'SUBJECT') {
                      timeTables = timeTables
                          .where((timeTable) => timeTable.subject == value)
                          .toList();
                      timeTables.sort((a, b) => a.grade.compareTo(b.grade));
                    } else {
                      timeTables = timeTables
                          .where((timeTable) =>
                              timeTable.grade == int.tryParse(value))
                          .toList();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: timeTables.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (BuildContext context, int index) {
                            TimeTable timeTable = timeTables[index];
                            return BuildContent(timeTable: timeTable);
                          }),
                    );
                  } else {
                    return const Center(child: Text('No data to display'));
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
