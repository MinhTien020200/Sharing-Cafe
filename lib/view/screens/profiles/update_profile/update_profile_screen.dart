import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/image_helper.dart';
import 'package:sharing_cafe/model/profile_info_model.dart';
import 'package:sharing_cafe/provider/user_profile_provider.dart';
import 'package:sharing_cafe/service/image_service.dart';
import 'package:sharing_cafe/view/components/form_field.dart';
import 'package:sharing_cafe/view/screens/profiles/profile_page/profile_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String routeName = "/update_profile";
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // String? _imageUrl;
  String? _fullname;
  String? _age;
  String? _story;
  String? _address;
  String? _gender;
  String? _purpose;
  String? _favoriteLocation;

  bool _isLoading = false;
  // bool _isUploading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<UserProfileProvider>(context, listen: false)
        .getUserProfile()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  // uploadImage(ImageSource source) async {
  //   var imageFile = await ImageHelper.pickImage(source);
  //   if (imageFile != null) {
  //     var url = await ImageService().uploadImage(imageFile);
  //     if (url.isNotEmpty) {
  //       setState(() {
  //         _imageUrl = url;
  //       });
  //     } else {
  //       ErrorHelper.showError(message: "Không tải được hình ảnh");
  //     }
  //   }
  // }

  // showImageTypeSelector() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //           content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           ListTile(
  //             leading: const Icon(Icons.image_search),
  //             title: const Text('Chọn ảnh từ thư viện'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               uploadImage(ImageSource.gallery);
  //             },
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.camera_alt_outlined),
  //             title: const Text('Chụp ảnh mới'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               uploadImage(ImageSource.camera);
  //             },
  //           ),
  //         ],
  //       ));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sửa thông tin",
          style: heading2Style,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Consumer<UserProfileProvider>(
              builder: (context, value, child) {
                var userProfile = value.userProfile;

                return SingleChildScrollView(
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
                                      child: Image.network(
                                          userProfile.profileAvatar,
                                          fit: BoxFit.cover))),
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
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('THÔNG TIN CÁ NHÂN',
                                    style: heading2Style,
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Họ và tên | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.userName,
                                  onChanged: (p0) {
                                    setState(() {
                                      _fullname = p0;
                                    });
                                  },
                                  maxLines: 1,
                                ),
                              ),

                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Tuổi | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.age,
                                  onChanged: (p0) {
                                    setState(() {
                                      _age = p0;
                                    });
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Địa chỉ | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.address,
                                  onChanged: (p0) {
                                    setState(() {
                                      _address = p0;
                                    });
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Giới tính | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.gender,
                                  onChanged: (p0) {
                                    setState(() {
                                      _gender = p0;
                                    });
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('CÂU CHUYỆN',
                                    style: heading2Style,
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Câu chuyện | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.story,
                                  onChanged: (p0) {
                                    setState(() {
                                      _story = p0;
                                    });
                                  },
                                  maxLines: 3,
                                ),
                              ),

                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('SỞ THÍCH',
                                    style: heading2Style,
                                    textAlign: TextAlign.left),
                              ),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm sở thích',
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options: userProfile.interest.map((interest) {
                                  return ValueItem(
                                      label: interest.interestName,
                                      value: interest.interestId.toString());
                                }).toList(),
                                selectedOptions:
                                    userProfile.interest.map((interest) {
                                  return ValueItem(
                                      label: interest.interestName,
                                      value: interest.interestId.toString());
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),

                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('MỤC ĐÍCH HẸN CAFE',
                                    style: heading2Style,
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.purpose,
                                  onChanged: (p0) {
                                    setState(() {
                                      _purpose = p0;
                                    });
                                  },
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('THÔNG TIN THÊM',
                                    style: heading2Style,
                                    textAlign: TextAlign.left),
                              ),
                              const Text("Bạn đang gặp khó khăn với điều gì?"),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm',
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options: userProfile.problem.map((problem) {
                                  return ValueItem(
                                      label: problem.problem,
                                      value:
                                          problem.personalProblemId.toString());
                                }).toList(),
                                selectedOptions:
                                    userProfile.problem.map((problem) {
                                  return ValueItem(
                                      label: problem.problem,
                                      value:
                                          problem.personalProblemId.toString());
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                  "Khi trò chuyện, bạn không muốn đề cập tới điều gì?"),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm',
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options:
                                    userProfile.unlikeTopic.map((unlikeTopic) {
                                  return ValueItem(
                                      label: unlikeTopic.unlikeTopic,
                                      value:
                                          unlikeTopic.unlikeTopicId.toString());
                                }).toList(),
                                selectedOptions:
                                    userProfile.unlikeTopic.map((unlikeTopic) {
                                  return ValueItem(
                                      label: unlikeTopic.unlikeTopic,
                                      value:
                                          unlikeTopic.unlikeTopicId.toString());
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(height: 10),
                              const Text("Thức uống yêu thích"),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm',
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options: userProfile.favoriteDrink
                                    .map((favoriteDrink) {
                                  return ValueItem(
                                      label: favoriteDrink.favoriteDrink,
                                      value: favoriteDrink.favoriteDrinkId
                                          .toString());
                                }).toList(),
                                selectedOptions: userProfile.favoriteDrink
                                    .map((favoriteDrink) {
                                  return ValueItem(
                                      label: favoriteDrink.favoriteDrink,
                                      value: favoriteDrink.favoriteDrinkId
                                          .toString());
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(height: 10),
                              const Text("Địa điểm yêu thích"),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  initialValue: userProfile.favoriteLocation,
                                  onChanged: (p0) {
                                    setState(() {
                                      _favoriteLocation = p0;
                                    });
                                  },
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text("Thời gian rảnh rổi"),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm',
                                onOptionSelected: (options) {
                                  debugPrint(options.toString());
                                },
                                options: userProfile.freeTime.map((freeTime) {
                                  return ValueItem(
                                      label: freeTime.freeTime,
                                      value: freeTime.freeTimeId.toString());
                                }).toList(),
                                selectedOptions:
                                    userProfile.freeTime.map((freeTime) {
                                  return ValueItem(
                                      label: freeTime.freeTime,
                                      value: freeTime.freeTimeId.toString());
                                }).toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              // const SizedBox(height: 10),
                              // const Padding(
                              //   padding: EdgeInsets.symmetric(vertical: 8.0),
                              //   child: Text('ĐANG SỐNG TẠI',
                              //       style: heading2Style,
                              //       textAlign: TextAlign.left),
                              // ),

                              const SizedBox(height: 20),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ProfileScreen.routeName);
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
                );
              },
            ),
    );
  }
}
