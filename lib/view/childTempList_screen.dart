import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/controller/temp_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';

class ChildTempListScreen extends GetView<TempController> {
  const ChildTempListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      DateTime selectedDate = DateTime.now(); 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temp History',
          style: robotoHugeWhite,
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the desired date to view Deema's past high temperatures:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
              Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: DateFormat('yyyy-MM-dd').format(controller.selectedDate.value),
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
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
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                    
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryColor,
                    ),
                    child: Text(
                      'Display Records',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 24),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Date'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Temperature'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Condition'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('2023-01-01'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('38.5°C'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('high temperature'),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}
