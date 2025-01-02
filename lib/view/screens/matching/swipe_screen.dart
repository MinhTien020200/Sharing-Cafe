import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/model/interest_model.dart';
import 'package:sharing_cafe/model/province_model.dart';
import 'package:sharing_cafe/provider/match_provider.dart';
import 'package:sharing_cafe/provider/user_profile_provider.dart';
import 'package:sharing_cafe/service/location_service.dart';
import 'package:sharing_cafe/service/match_service.dart';
import 'package:sharing_cafe/view/screens/friends/friends_screen.dart';
import 'package:sharing_cafe/view/screens/friends/pending_screen.dart';
import 'package:sharing_cafe/view/screens/matching/components/profile_card.dart';

class SwipeScreen extends StatefulWidget {
  static String routeName = "/swipe";
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  bool _isLoading = false;
  bool _showIcon = false;
  bool _isLikeIcon = true;
  List<ValueItem> selectedFilterByAge = [];
  List<ValueItem> selectedFilterByGender = [];
  List<ValueItem> selectedFilterByProvince = [];
  List<ValueItem> selectedFilterByDistrict = [];
  List<ValueItem> selectedFilterByInterest = [];
  String? _selectedProvinceId;
  late Set<ProvinceModel> provinces;
  late Set<DistrictModel> districts;
  late List<InterestModel> interests;
  RangeValues _ageRange = const RangeValues(18, 100);
  bool? _byInterest;
  @override
  void initState() {
    getProfilesV2();
    super.initState();
  }

  void getProfiles({String? filterByAge, String? filterByGender}) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<MatchProvider>(context, listen: false)
        .initListProfiles(
            filterByAge: filterByAge, filterByGender: filterByGender)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void getProfilesV2() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<MatchProvider>(context, listen: false)
        .initListProfilesV2()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void filterProfiles() {
    setState(() {
      _isLoading = true;
    });
    var priorityInterestIds = selectedFilterByInterest.isNotEmpty
        ? selectedFilterByInterest.map((e) => e.value).join(";")
        : null;
    Provider.of<MatchProvider>(context, listen: false)
        .filterProfile(
            minAge: _ageRange.start.round(),
            maxAge: _ageRange.end.round(),
            filterByGender: selectedFilterByGender.isNotEmpty
                ? selectedFilterByGender.first.value
                : null,
            filterByProvince: selectedFilterByProvince.isNotEmpty
                ? selectedFilterByProvince.first.value
                : null,
            filterByDistrict: selectedFilterByDistrict.isNotEmpty
                ? selectedFilterByDistrict.first.value
                : null,
            byInterest: _byInterest,
            priorityInterestIds: priorityInterestIds)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  showIcon({isLike = true}) async {
    setState(() {
      _showIcon = true;
      _isLikeIcon = isLike;
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showIcon = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/cafe.png',
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text('Kết nối',
                style: heading2Style.copyWith(color: kPrimaryColor)),
          ],
        ),
        actions: [
          //filter
          IconButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onPressed: () async {
                var filter = await MatchService().getFilterSetting();
                double maxAge = filter.maxAge?.toDouble() == null ||
                        filter.maxAge!.toDouble() > 100
                    ? 100
                    : filter.maxAge!.toDouble();
                double minAge = filter.minAge?.toDouble() == null ||
                        filter.minAge!.toDouble() < 18
                    ? 18
                    : filter.minAge!.toDouble();
                _ageRange = RangeValues(minAge, maxAge);
                var genders = await MatchService().getListGender();
                selectedFilterByGender = genders
                    .where((element) => element.genderId == filter.sexId)
                    .map((e) => ValueItem(value: e.genderId, label: e.gender))
                    .toList();
                provinces = await LocationService().getProvince();
                selectedFilterByProvince = provinces
                    .where((element) => element.provinceId == filter.provinceId)
                    .map((e) =>
                        ValueItem(value: e.provinceId, label: e.province))
                    .toList();
                _selectedProvinceId = filter.provinceId;
                districts =
                    await LocationService().getDistrict(filter.provinceId);
                selectedFilterByDistrict = districts
                    .where((element) => element.id == filter.districtId)
                    .map((e) => ValueItem(value: e.id, label: e.fullName))
                    .toList();
                _byInterest = filter.byInterest;
                await Provider.of<UserProfileProvider>(context, listen: false)
                    .getListInterests();
                if (filter.priorityInterestIds != null) {
                  var inte =
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .listInterests;
                  selectedFilterByInterest = filter.priorityInterestIds!
                      .split(";")
                      .map((e) => ValueItem(
                          value: e,
                          label: inte
                              .firstWhere((element) =>
                                  element.interestId.toString() == e)
                              .name))
                      .toList();
                }
                showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: const Text(
                            "Bộ lọc",
                            style: heading2Style,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Chọn độ tuổi",
                              ),
                              RangeSlider(
                                values: _ageRange,
                                min: 10,
                                max: 100,
                                divisions: 82,
                                labels: RangeLabels(
                                  _ageRange.start.round().toString(),
                                  _ageRange.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _ageRange = values;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Chọn giới tính',
                                onOptionSelected: (options) async {
                                  setState(() {
                                    selectedFilterByGender = options;
                                  });
                                },
                                options: genders.map((gender) {
                                  return ValueItem(
                                      label: gender.gender,
                                      value: gender.genderId);
                                }).toList(),
                                selectedOptions: selectedFilterByGender,
                                selectionType: SelectionType.single,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MultiSelectDropDown(
                                selectedOptionTextColor: kPrimaryColor,
                                hint: 'Chọn tỉnh / thành phố',
                                onOptionSelected: (options) async {
                                  var selectedId = options.firstOrNull?.value;
                                  var disByProvince = await LocationService()
                                      .getDistrict(selectedId);
                                  setState(() {
                                    selectedFilterByProvince = options;
                                    _selectedProvinceId = selectedId;
                                    districts = disByProvince;
                                    selectedFilterByDistrict.clear();
                                  });
                                },
                                searchEnabled: true,
                                searchLabel: 'Tìm kiếm',
                                options: provinces.map((province) {
                                  return ValueItem(
                                      label: province.province,
                                      value: province.provinceId);
                                }).toList(),
                                selectedOptions: selectedFilterByProvince,
                                selectionType: SelectionType.single,
                                chipConfig: const ChipConfig(
                                    wrapType: WrapType.scroll,
                                    backgroundColor: kPrimaryColor),
                                optionTextStyle: const TextStyle(fontSize: 16),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              if (_selectedProvinceId != null)
                                MultiSelectDropDown(
                                  selectedOptionTextColor: kPrimaryColor,
                                  hint: 'Chọn quận / huyện',
                                  onOptionSelected: (options) async {
                                    setState(() {
                                      selectedFilterByDistrict = options;
                                    });
                                  },
                                  options: districts.map((district) {
                                    return ValueItem(
                                        label: district.fullName,
                                        value: district.id);
                                  }).toList(),
                                  selectedOptions: selectedFilterByDistrict,
                                  selectionType: SelectionType.single,
                                  chipConfig: const ChipConfig(
                                      wrapType: WrapType.scroll,
                                      backgroundColor: kPrimaryColor),
                                  optionTextStyle:
                                      const TextStyle(fontSize: 16),
                                  selectedOptionIcon:
                                      const Icon(Icons.check_circle),
                                ),
                              const SizedBox(
                                height: 8,
                              ),
                              // select box by_interest
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Áp dụng theo sở thích của bạn"),
                                  Checkbox(
                                    value: _byInterest ?? false,
                                    onChanged: (value) {
                                      setState(() {
                                        _byInterest = value ?? false;
                                      });
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Chọn sở thích ưu tiên"),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 300,
                                child: MultiSelectDropDown(
                                  selectedOptionTextColor: kPrimaryColor,
                                  hint: 'Thêm sở thích',
                                  onOptionSelected: (options) async {
                                    setState(() {
                                      selectedFilterByInterest = options;
                                    });
                                  },
                                  maxItems: 5,
                                  options: Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .listInterests
                                      .map((interest) {
                                    return ValueItem(
                                        label: interest.name,
                                        value: interest.interestId.toString());
                                  }).toList(),
                                  selectedOptions: selectedFilterByInterest,
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
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  filterProfiles();
                                  Navigator.pop(context);
                                },
                                child: const Text("Áp dụng"),
                              )
                            ],
                          ),
                        );
                      });
                    });
              }),
          IconButton(
            icon: const Icon(Icons.pending_actions),
            onPressed: () {
              Navigator.pushNamed(context, PendingScreen.routeName);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Badge(
              label: FutureBuilder(
                future: MatchService().getListFriends(pending: false),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("0");
                  }
                  var friends = snapshot.data;
                  return Text(friends?.length.toString() ?? "0");
                },
              ),
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.supervisor_account),
                onPressed: () {
                  Navigator.pushNamed(context, FriendsScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Consumer<MatchProvider>(builder: (context, value, child) {
              var profiles = value.profiles;

              return profiles.isEmpty
                  ? const Center(child: Text("Chưa có người dùng mới"))
                  : Stack(children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                            // child: Swiper(
                            //   itemCount: profiles.length,
                            //   itemBuilder: (context, index) {
                            //     return ProfileCard(
                            //       image: profiles[index].image,
                            //       name: profiles[index].name,
                            //       description: profiles[index].description,
                            //       age: profiles[index].age,
                            //     );
                            //   },
                            //   layout: SwiperLayout.STACK,
                            //   loop: true,
                            //   itemWidth: MediaQuery.of(context).size.width,
                            //   itemHeight: MediaQuery.of(context).size.height,
                            //   onIndexChanged: (index) {
                            //     // When swipe right, selected user index is index - 1
                            //     // When swipe left, selected user index is index + 1
                            //     value.setCurrentProfileByIndex(index);
                            //   },
                            // ),
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet(
                                  context: context,
                                  shape: const Border(top: BorderSide.none),
                                  builder: (context) {
                                    return Consumer<MatchProvider>(
                                        builder: (context, value, child) {
                                      return FutureBuilder(
                                          future: value.getProfileInfo(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                            }
                                            var info = snapshot.data;
                                            if (info == null) {
                                              return const Center(
                                                child:
                                                    Text("Không có thông tin"),
                                              );
                                            }
                                            // create jobs string with ,
                                            var jobs = info.problem.isNotEmpty
                                                ? info.problem
                                                    .map((e) => e.problem)
                                                    .join(", ")
                                                : "Không có";
                                            var unlikeTopics = info
                                                    .problem.isNotEmpty
                                                ? info.unlikeTopic
                                                    .map((e) => e.unlikeTopic)
                                                    .join(", ")
                                                : "Không có";
                                            var favoriteDrinks = info
                                                    .problem.isNotEmpty
                                                ? info.favoriteDrink
                                                    .map((e) => e.favoriteDrink)
                                                    .join(", ")
                                                : "Không có";
                                            var freeTime =
                                                info.problem.isNotEmpty
                                                    ? info.freeTime
                                                        .map((e) => e.freeTime)
                                                        .join(", ")
                                                    : "Không có";

                                            return SizedBox(
                                              height: 800,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 500,
                                                      child: ProfileCard(
                                                        refId: profiles
                                                            .first.userId,
                                                        image: profiles
                                                            .first.image,
                                                        name:
                                                            profiles.first.name,
                                                        description: profiles
                                                            .first.description,
                                                        age: profiles.first.age,
                                                        isDetailPage: true,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            kPrimaryLightColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.search),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                  "Đang tìm kiếm")
                                                            ],
                                                          ),
                                                          Text(
                                                            info.purpose ?? "",
                                                            style:
                                                                heading2Style,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    if (info.story != null)
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                    Visibility(
                                                      visible:
                                                          info.story != null,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              kPrimaryLightColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .format_quote_rounded),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                    "Câu chuyện",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold))
                                                              ],
                                                            ),
                                                            Text(
                                                              info.story ?? "",
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            kPrimaryLightColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .info_outline),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "Thông tin chính",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .location_on_outlined),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                  "Cách xa ${info.distance}")
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .home_outlined),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Đang sống tại ${info.address}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            kPrimaryLightColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .info_outline),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "Thông tin cơ bản",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .question_mark_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "Bạn đang gặp khó khăn",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 27,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  jobs,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .question_mark_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Khi trò chuyện, bạn không muốn đề cập",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 27,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  unlikeTopics,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .local_drink_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Thức uống yêu thích",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 27,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  favoriteDrinks,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .park_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Địa điểm yêu thích",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 27,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                    info.favoriteLocation ??
                                                                        ""),
                                                              ),
                                                            ],
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .free_breakfast_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Thời gian rảnh rỗi",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 27,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  freeTime,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (info.avgRating !=
                                                              null)
                                                            const Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .star_border_outlined),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "Đánh giá trung bình",
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          if (info.avgRating !=
                                                              null)
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 27,
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      double.parse(
                                                                          info.avgRating!),
                                                                  itemCount: 5,
                                                                  ignoreGestures:
                                                                      true,
                                                                  itemSize: 32,
                                                                  onRatingUpdate:
                                                                      (rating) {},
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    switch (
                                                                        index) {
                                                                      case 0:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_very_dissatisfied,
                                                                          color:
                                                                              Colors.red,
                                                                        );
                                                                      case 1:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_dissatisfied,
                                                                          color:
                                                                              Colors.redAccent,
                                                                        );
                                                                      case 2:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_neutral,
                                                                          color:
                                                                              Colors.amber,
                                                                        );
                                                                      case 3:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_satisfied,
                                                                          color:
                                                                              Colors.lightGreen,
                                                                        );
                                                                      case 4:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_very_satisfied,
                                                                          color:
                                                                              Colors.green,
                                                                        );
                                                                      default:
                                                                        return const Icon(
                                                                          Icons
                                                                              .sentiment_very_dissatisfied,
                                                                          color:
                                                                              Colors.red,
                                                                        );
                                                                    }
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                    "(${info.avgRating})")
                                                              ],
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            kPrimaryLightColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .interests_outlined),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "Sở thích",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // List chip
                                                          Wrap(
                                                            spacing: 6,
                                                            runSpacing: 0,
                                                            children: info
                                                                .interest
                                                                .map((e) => Chip(
                                                                    label: Text(e
                                                                        .interestName
                                                                        .toString())))
                                                                .toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  ProfileCard(
                                    refId: profiles.first.userId,
                                    image: profiles.first.image,
                                    name: profiles.first.name,
                                    description: profiles.first.description,
                                    age: profiles.first.age,
                                    isDetailPage: false,
                                  ),
                                  if (_showIcon)
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Lottie.asset(
                                            _isLikeIcon
                                                ? 'assets/animations/like.json'
                                                : 'assets/animations/dislike.json',
                                            fit: BoxFit.cover,
                                            repeat: false,
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FloatingActionButton(
                                  heroTag: "dislike",
                                  onPressed: () async {
                                    await showIcon(isLike: false);
                                    var filterByAge =
                                        selectedFilterByAge.isNotEmpty
                                            ? selectedFilterByAge.first.value
                                            : null;
                                    var filterByGender =
                                        selectedFilterByGender.isNotEmpty
                                            ? selectedFilterByGender.first.value
                                            : null;
                                    await value.likeOrUnlike(
                                        MatchStatus.dislike,
                                        filterByAge: filterByAge,
                                        filterByGender: filterByGender);
                                  },
                                  backgroundColor: Colors.white,
                                  child: const Icon(Icons.close,
                                      color: Colors.red),
                                ),
                                FloatingActionButton(
                                  heroTag: "like",
                                  onPressed: () async {
                                    await showIcon(isLike: true);
                                    var filterByAge =
                                        selectedFilterByAge.isNotEmpty
                                            ? selectedFilterByAge.first.value
                                            : null;
                                    var filterByGender =
                                        selectedFilterByGender.isNotEmpty
                                            ? selectedFilterByGender.first.value
                                            : null;
                                    await value.likeOrUnlike(
                                        MatchStatus.pending,
                                        filterByAge: filterByAge,
                                        filterByGender: filterByGender);
                                  },
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/cafe.png',
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]);
            }),
    );
  }
}
