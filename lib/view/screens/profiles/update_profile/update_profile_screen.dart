import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/image_helper.dart';
import 'package:sharing_cafe/provider/user_profile_provider.dart';
import 'package:sharing_cafe/service/image_service.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String routeName = "/update_profile";
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String? _imageUrl;
  final TextEditingController _userNameController = TextEditingController();
  String? _age;
  final TextEditingController _storyController = TextEditingController();
  String? _address;
  String? _gender;
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _favoriteLocationController =
      TextEditingController();

  bool _isLoading = false;
  bool _isLoadingListInterests = false;
  bool _isUploading = false;

  var listProblem = const <ValueItem>[
    ValueItem(label: 'Công việc', value: 'Công việc'),
    ValueItem(label: 'Mối quan hệ', value: 'Mối quan hệ'),
    ValueItem(label: 'Học tập', value: 'Học tập'),
    ValueItem(label: 'Sức khỏe', value: 'Sức khỏe'),
    ValueItem(label: 'Tài Chính', value: 'Tài Chính'),
    ValueItem(label: 'Gia đình', value: 'Gia đình'),
    ValueItem(label: 'Định hướng', value: 'Định hướng'),
    ValueItem(label: 'Xã hội', value: 'Xã hội'),
    ValueItem(label: 'Không muốn đề cập', value: 'Không muốn đề cập'),
    ValueItem(
        label: 'Thoải mái với mọi ý tưởng', value: 'Thoải mái với mọi ý tưởng'),
  ];
  var listFavoriteDink = const <ValueItem>[
    ValueItem(label: 'Cà Phê', value: 'Cà Phê'),
    ValueItem(label: 'Trà', value: 'Trà'),
    ValueItem(label: 'Nước ép trái cây', value: 'Nước ép trái cây'),
    ValueItem(label: 'Sinh tố', value: 'Sinh tố'),
    ValueItem(label: 'Đồ uống có cồn', value: 'Đồ uống có cồn'),
    ValueItem(label: 'Smoothie', value: 'Smoothie'),
    ValueItem(label: 'Nước lọc', value: 'Nước lọc'),
    ValueItem(label: 'Đồ uống có ga', value: 'Đồ uống có ga'),
    ValueItem(label: 'Sữa', value: 'Sữa'),
  ];
  var listFreeTime = const <ValueItem>[
    ValueItem(label: 'Thứ 2', value: 'Thứ 2'),
    ValueItem(label: 'Thứ 3', value: 'Thứ 3'),
    ValueItem(label: 'Thứ 4', value: 'Thứ 4'),
    ValueItem(label: 'Thứ 5', value: 'Thứ 5'),
    ValueItem(label: 'Thứ 6', value: 'Thứ 6'),
    ValueItem(label: 'Thứ 7', value: 'Thứ 7'),
    ValueItem(label: 'Chủ nhật', value: 'Chủ nhật'),
    ValueItem(label: 'Không cụ thể', value: 'Không cụ thể'),
  ];

  @override
  void initState() {
    loadListInterests();
    setState(() {
      _isLoading = true;
    });
    Provider.of<UserProfileProvider>(context, listen: false)
        .getUserProfile()
        .then((value) {
      setState(() {
        if (value != null) {
          _userNameController.text = value.userName;
          _imageUrl = value.profileAvatar;
          _age = value.age;
          _storyController.text = value.story!;
          _address = value.address;
          _gender = value.gender;
          _purposeController.text = value.purpose!;
          _favoriteLocationController.text = value.favoriteLocation!;
        }
        _isLoading = false;
      });
    });
    super.initState();
  }

  void loadListInterests() {
    setState(() {
      _isLoadingListInterests = true;
    });
    Provider.of<UserProfileProvider>(context, listen: false)
        .getListInterests()
        .then((_) {
      setState(() {
        _isLoadingListInterests = false;
      });
    });
  }

  uploadImage(ImageSource source) async {
    var imageFile = await ImageHelper.pickImage(source);
    if (imageFile != null) {
      var url = await ImageService().uploadImage(imageFile);
      if (url.isNotEmpty) {
        setState(() {
          Provider.of<UserProfileProvider>(context, listen: false)
              .setUserAvt(url);
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
          'Sửa thông tin',
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
            child: _isUploading
                ? TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kPrimaryColor),
                      padding: MaterialStateProperty.resolveWith((states) =>
                          const EdgeInsets.symmetric(horizontal: 16.0)),
                    ),
                    child: const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator.adaptive()))
                : TextButton(
                    onPressed: () async {
                      setState(() {
                        _isUploading = true;
                      });
                      var result = await Provider.of<UserProfileProvider>(
                              context,
                              listen: false)
                          .updateUserProfile(
                        profileAvatar: _imageUrl,
                        userName: _userNameController.text,
                        age: _age,
                        story: _storyController.text,
                        address: _address,
                        gender: _gender,
                        purpose: _purposeController.text,
                        favoriteLocation: _favoriteLocationController.text,
                      );
                      setState(() {
                        _isUploading = false;
                      });
                      if (result == true) {
                        // ignore: use_build_context_synchronously
                        Provider.of<UserProfileProvider>(context, listen: false)
                            .getUserProfile();
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Thành công'),
                              content: const Text(
                                  'Thông tin của bạn đã được lưu thành công.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Đóng'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kPrimaryColor),
                      padding: MaterialStateProperty.resolveWith((states) =>
                          const EdgeInsets.symmetric(horizontal: 16.0)),
                    ),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Consumer<UserProfileProvider>(
              builder: (context, value, child) {
                var userProfile = value.userProfile;
                var listInterests = value.listInterests;
                return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showImageTypeSelector();
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:
                                          userProfile.profileAvatar.isNotEmpty
                                              ? Image.network(
                                                  userProfile.profileAvatar,
                                                  fit: BoxFit.cover)
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                      "Thêm ảnh",
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                    )),
                              ],
                            ),
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
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixText: "Họ và tên | ",
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  controller: _userNameController,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _age,
                                  decoration: const InputDecoration(
                                    prefixText: "Tuổi | ",
                                    contentPadding: EdgeInsets.all(16),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Chọn độ tuổi',
                                  ),
                                  items: [
                                    '16 - 20',
                                    '21 - 25',
                                    '26 - 30',
                                    '31 - 35',
                                    '36 - 40',
                                    '41 - 50',
                                    'Không đề cập'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(
                                    () {
                                      _age = value;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _address,
                                  decoration: const InputDecoration(
                                    prefixText: "Địa chỉ | ",
                                    contentPadding: EdgeInsets.all(16),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Chọn địa chỉ',
                                  ),
                                  items: [
                                    'Quận 1',
                                    'Quận 2',
                                    'Quận 3',
                                    'Quận 4',
                                    'Quận 5',
                                    'Quận 6',
                                    'Quận 7',
                                    'Quận 8',
                                    'Quận 9',
                                    'Quận 10',
                                    'Quận 11',
                                    'Quận 12',
                                    'Quận Tân Bình',
                                    'Quận Bình Tân',
                                    'Quận Bình Thạnh',
                                    'Quận Tân Phú',
                                    'Quận Gò Vấp',
                                    'Quận Phú Nhuận',
                                    'Quận Thủ Đức',
                                    'Không đề cập'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(
                                    () {
                                      _address = value;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: kFormFieldColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _gender,
                                  decoration: const InputDecoration(
                                    prefixText: "Giới tính | ",
                                    contentPadding: EdgeInsets.all(16),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Chọn giới tính',
                                  ),
                                  items: ['Nam', 'Nữ', 'Không đề cập']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(
                                    () {
                                      _gender = value;
                                    },
                                  ),
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
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  controller: _storyController,
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
                              SizedBox(
                                child: _isLoadingListInterests
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : MultiSelectDropDown(
                                        selectedOptionTextColor: kPrimaryColor,
                                        hint: 'Thêm sở thích',
                                        onOptionSelected: (options) async {
                                          var listString = options
                                              .map((e) => e.value.toString())
                                              .toList();
                                          await Provider.of<
                                                      UserProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .updateInterest(
                                                  interestId: listString);
                                        },
                                        maxItems: 5,
                                        options: listInterests.map((interest) {
                                          return ValueItem(
                                              label: interest.name,
                                              value: interest.interestId
                                                  .toString());
                                        }).toList(),
                                        selectedOptions: userProfile.interest
                                            .map((interest) {
                                          return ValueItem(
                                              label: interest.interestName,
                                              value: interest.interestId
                                                  .toString());
                                        }).toList(),
                                        selectionType: SelectionType.multi,
                                        chipConfig: const ChipConfig(
                                            wrapType: WrapType.scroll,
                                            backgroundColor: kPrimaryColor),
                                        dropdownHeight: 400,
                                        optionTextStyle:
                                            const TextStyle(fontSize: 16),
                                        selectedOptionIcon:
                                            const Icon(Icons.check_circle),
                                      ),
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
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  controller: _purposeController,
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
                                onOptionSelected: (options) async {
                                  var listString = options
                                      .map((e) => e.value.toString())
                                      .toList();
                                  await Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .updateProblem(problem: listString);
                                },
                                onOptionRemoved: (index, option) {},
                                maxItems: 3,
                                options: listProblem,
                                selectedOptions: listProblem
                                    .where((element) => userProfile.problem
                                        .map((e) => e.problem)
                                        .contains(element.value))
                                    .toList(),
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
                                onOptionSelected: (options) async {
                                  var listString = options
                                      .map((e) => e.value.toString())
                                      .toList();
                                  await Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .updateUnlikeTopic(
                                          unlikeTopic: listString);
                                },
                                onOptionRemoved: (index, option) {},
                                maxItems: 3,
                                options: listProblem,
                                selectedOptions: listProblem
                                    .where((element) => userProfile.unlikeTopic
                                        .map((e) => e.unlikeTopic)
                                        .contains(element.value))
                                    .toList(),
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
                                onOptionSelected: (options) async {
                                  var listString = options
                                      .map((e) => e.value.toString())
                                      .toList();
                                  await Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .updateFavoriteDrink(
                                          favoriteDrink: listString);
                                },
                                onOptionRemoved: (index, option) {},
                                maxItems: 3,
                                options: listFavoriteDink,
                                selectedOptions: listFavoriteDink
                                    .where((element) => userProfile
                                        .favoriteDrink
                                        .map((e) => e.favoriteDrink)
                                        .contains(element.value))
                                    .toList(),
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
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          100, 158, 158, 158)),
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  controller: _favoriteLocationController,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text("Thời gian rảnh rổi"),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Thêm',
                                onOptionSelected: (options) async {
                                  var listString = options
                                      .map((e) => e.value.toString())
                                      .toList();
                                  await Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .updateFreetime(freeTime: listString);
                                },
                                onOptionRemoved: (index, option) {},
                                maxItems: 3,
                                options: listFreeTime,
                                selectedOptions: listFreeTime
                                    .where((element) => userProfile.freeTime
                                        .map((e) => e.freeTime)
                                        .contains(element.value))
                                    .toList(),
                                selectionType: SelectionType.multi,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                dropdownHeight: 400,
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(height: 20),
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
