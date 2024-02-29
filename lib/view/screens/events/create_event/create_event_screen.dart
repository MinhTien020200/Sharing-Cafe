import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/view/components/date_time_picker.dart';
import 'package:sharing_cafe/view/components/form_field.dart';

class CreateEventScreen extends StatefulWidget {
  static String routeName = "/create-event";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // You will need to manage the state for the inputs and selections
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo sự kiện',
          style: heading2Style,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // Handle attend action
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kPrimaryColor),
                padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.symmetric(horizontal: 16.0)),
              ),
              child: const Text(
                'Đăng',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Open image picker
              },
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                    color: kFormFieldColor,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.grey[600],
                      size: 48,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Thêm ảnh bìa bài viết",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const KFormField(
              hintText: "Tên sự kiện",
            ),
            const SizedBox(height: 16),
            const DateTimePicker(),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle attend action
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kPrimaryLightColor),
                      padding: MaterialStateProperty.resolveWith((states) =>
                          const EdgeInsets.symmetric(horizontal: 24.0)),
                    ),
                    child: const Text(
                      'Thêm thời gian kết thúc',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Handle attend action
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kPrimaryLightColor),
                      padding: MaterialStateProperty.resolveWith((states) =>
                          const EdgeInsets.symmetric(horizontal: 24.0)),
                    ),
                    child: const Text(
                      'Lặp lại sự kiện',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const KFormField(hintText: "Hãy mô tả chi tiết về sự kiện"),
            const SizedBox(height: 16),
            const KSelectForm(
              hintText: 'Chọn chủ đề',
              options: ['Option 1', 'Option 2', 'Option 3'],
            )
          ],
        ),
      ),
    );
  }
}

class KSelectForm extends StatefulWidget {
  final String hintText;
  final List<String> options;
  const KSelectForm({
    super.key,
    required this.hintText,
    required this.options,
  });

  @override
  State<KSelectForm> createState() => _KSelectFormState();
}

class _KSelectFormState extends State<KSelectForm> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: kFormFieldColor),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down),
        hint: Text(widget.hintText),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          isDense: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
