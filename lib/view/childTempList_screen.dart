import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temp_tracker/controller/temp_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';

class ChildTempListScreen extends GetView<TempController> {
  const ChildTempListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temp History',
          style: robotoHugeWhite,
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                "Enter the desired date to view ${controller.name}'s past high temperatures:",
                style: robotoMedium,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: DateFormat('dd-MM-yyyy').format(controller.selectedDate.value),
                        ),
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Select Date',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && pickedDate != controller.selectedDate.value) {
                            controller.updateSelectedDate(pickedDate);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        controller.fetchChildrenTemps();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                      ),
                      child: const Text(
                        'Display Records',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Obx(() => Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text('Date'))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text('Temperature'))),
                    TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text('Condition'))),
                  ],
                ),
                for (var record in controller.childrenTemps)
                  TableRow(
                    children: [
                      TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(record['Date']))),
                      TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text('${record['Temp']}°C'))),
                      TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(record['Condition']))),
                    ],
                  ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

