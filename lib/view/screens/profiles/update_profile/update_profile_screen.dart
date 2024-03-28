import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/image_helper.dart';
import 'package:sharing_cafe/service/image_service.dart';
import 'package:sharing_cafe/view/components/form_field.dart';
import 'package:sharing_cafe/view/screens/profiles/profile_page/profile_screen.dart';

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class UpdateProfileScreen extends StatefulWidget {
  static String routeName = "/update_profile";
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;
  String? _imageUrl;
  String? _fullname;
  String? _phonenumber;
  String? _story;
  String? _location;

  bool _isUploading = false;

  uploadImage(ImageSource source) async {
    var imageFile = await ImageHelper.pickImage(source);
    if (imageFile != null) {
      var url = await ImageService().uploadImage(imageFile);
      if (url.isNotEmpty) {
        setState(() {
          _imageUrl = url;
        });
      } else {
        ErrorHelper.showError(message: "Không tải được hình ảnh");
      }
    }
  }

  showImageTypeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.image_search),
              title: const Text('Chọn ảnh từ thư viện'),
              onTap: () {
                Navigator.pop(context);
                uploadImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Chụp ảnh mới'),
              onTap: () {
                Navigator.pop(context);
                uploadImage(ImageSource.camera);
              },
            ),
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sửa thông tin",
          style: heading2Style,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/cafe.png',
                            ))),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kPrimaryColor),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Form(
                    child: Column(
                  children: [
                    KFormField(
                      hintText: "Họ và tên",
                      onChanged: (p0) {
                        setState(() {
                          _fullname = p0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    KFormField(
                      hintText: "Số điện thoại",
                      onChanged: (p0) {
                        setState(() {
                          _phonenumber = p0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    KFormField(
                      hintText: "Hãy câu chuyện của bạn",
                      maxLines: 3,
                      onChanged: (p0) {
                        setState(() {
                          _story = p0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    KFormField(
                      hintText: "Địa chỉ",
                      onChanged: (p0) {
                        setState(() {
                          _location = p0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Tóm tắt', style: heading2Style),
                    ),
                    KFormField(
                      hintText: "Sở thích",
                      onChanged: (p0) {
                        setState(() {
                          _location = p0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    MultiSelectDropDown(
                      onOptionSelected: (options) {
                        debugPrint(options.toString());
                      },
                      options: const <ValueItem>[
                        ValueItem(label: 'Option 1', value: '1'),
                        ValueItem(label: 'Option 2', value: '2'),
                        ValueItem(label: 'Option 3', value: '3'),
                        ValueItem(label: 'Option 4', value: '4'),
                        ValueItem(label: 'Option 5', value: '5'),
                        ValueItem(label: 'Option 6', value: '6'),
                      ],
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                      dropdownHeight: 400,
                      optionTextStyle: const TextStyle(fontSize: 16),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Lưu",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
