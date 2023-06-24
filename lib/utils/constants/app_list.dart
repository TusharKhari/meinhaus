import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/features/customer%20support/screens/customer_support_chat_screen.dart';
import 'package:new_user_side/features/estimate/screens/all_estimate_work_screen.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/features/ongoing%20projects/screens/all_ongoing_projects_screen.dart';
import 'package:new_user_side/features/ongoing%20projects/screens/project_history_screen.dart';
import 'package:new_user_side/features/settings/screens/setting_screen.dart';

import '../../../features/home/screens/home_screen.dart';

// Ongoing Project
List<String> ongoingProjectDesList = [
  "Need to fix the furniture in manner it can’t break again.",
  "clean them off to remove dirt and grime, repair any chips and cracks, then apply gel stain and finish",
  "clean them off to remove dirt and grime, repair any chips and cracks, then apply gel stain and finish",
  "Need to fix the furniture in manner it can’t break again.",
  "Need to fix the furniture in manner it can’t break again.",
  "clean them off to remove dirt and grime, repair any chips and cracks, then apply gel stain and finish",
  "clean them off to remove dirt and grime, repair any chips and cracks, then apply gel stain and finish",
  "Need to fix the furniture in manner it can’t break again.",
];

// Drawer
List drawerList = [
  [
    CupertinoIcons.home,
    "Home",
    HomeScreen.routeName,
  ],
  [
    CupertinoIcons.square_favorites_fill,
    "Estimated Work",
    AllEstimatedWorkScreen.routeName,
  ],
  [
    CupertinoIcons.time,
    "Ongoing Projects",
    AllOngoingJobs.routeName,
  ],
  [
    Icons.feed_outlined,
    "Create new estimate",
    EstimateGenerationScreen.routeName,
  ],
  [
    Icons.settings,
    "Settings",
    SettingScreen.routeName,
  ],
  [
    Icons.history,
    "Project History",
    ProjectHistory.routeName,
  ],
  [
    Icons.contact_support_outlined,
    "Customer Support",
    CustomerSupportChatScreen.routeName,
  ],
];

// chat with pro
List chatList = [
  [
    false,
    false,
    "assets/images/face/man_1.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "Just Now",
    "Bathroom Renovation",
  ],
  [
    false,
    false,
    "assets/images/face/women.png",
    "Katherin Murphy",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Window Fixing",
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Sandy Roy",
    "Lorem ipsum dolor sit amet",
    "5 min ago",
    "Roof Fixing & Fitting"
  ],
  [
    false,
    false,
    "assets/images/face/women.png",
    "Katherin Murphy",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Furniture Fixing",
  ],
  [
    true,
    true,
    "assets/images/face/man_1.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "03.04 PM",
    "Bathroom Renovation",
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Sam Kohli ",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Window Fixing",
  ],
  [
    false,
    false,
    "assets/images/face/women.png",
    "Katherin Murphy",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Furniture Fixing",
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Roof Fixing & Fitting"
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Window Fixing",
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Bathroom Renovation",
  ],
  [
    true,
    true,
    "assets/images/face/man_2.png",
    "Nate Diaz",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...",
    "5 min ago",
    "Furniture Fixing",
  ],
];

// User Details
Map<String, List<String>> statesCities = {
  'Andhra Pradesh': [
    'Visakhapatnam',
    'Vijayawada',
    'Guntur',
    'Nellore',
    'Kurnool',
    'Tirupati',
    'Kadapa',
    'Rajahmundry',
    'Kakinada',
    'Anantapur'
  ],
  'Arunachal Pradesh': [
    'Itanagar',
    'Naharlagun',
    'Tawang',
    'Ziro',
    'Bomdila',
    'Pasighat',
    'Khonsa',
    'Roing',
    'Tezu',
    'Namsai'
  ],
  'Assam': [
    'Guwahati',
    'Silchar',
    'Dibrugarh',
    'Jorhat',
    'Nagaon',
    'Tezpur',
    'Lakhimpur',
    'Diphu',
    'Goalpara',
    'Tinsukia'
  ],
  'Bihar': [
    'Patna',
    'Gaya',
    'Bhagalpur',
    'Muzaffarpur',
    'Purnia',
    'Darbhanga',
    'Aurangabad',
    'Siwan',
    'Chhapra',
    'Katihar'
  ],
  'Chhattisgarh': [
    'Raipur',
    'Bhilai',
    'Bilaspur',
    'Korba',
    'Rajnandgaon',
    'Jagdalpur',
    'Ambikapur',
    'Dhamtari',
    'Durg',
    'Raigarh'
  ],
  'Goa': [
    'Panaji',
    'Margao',
    'Vasco da Gama',
    'Ponda',
    'Mapusa',
    'Curchorem',
    'Cuncolim',
    'Sanguem',
    'Bicholim',
    'Valpoi'
  ],
  'Gujarat': [
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
    'Bhavnagar',
    'Jamnagar',
    'Junagadh',
    'Gandhinagar',
    'Nadiad',
    'Morbi'
  ],
  'Haryana': [
    'Faridabad',
    'Gurgaon',
    'Panipat',
    'Ambala',
    'Yamunanagar',
    'Rohtak',
    'Hisar',
    'Karnal',
    'Sonipat',
    'Panchkula'
  ],
  'Himachal Pradesh': [
    'Shimla',
    'Manali',
    'Mandi',
    'Dharamshala',
    'Solan',
    'Palampur',
    'Kullu',
    'Una',
    'Bilaspur',
    'Chamba'
  ],
  'Jharkhand': [
    'Ranchi',
    'Jamshedpur',
    'Dhanbad',
    'Bokaro',
    'Deoghar',
    'Hazaribagh',
    'Giridih',
    'Ramgarh',
    'Chatra',
    'Godda'
  ],
  'Karnataka': [
    'Bengaluru',
    'Mysuru',
    'Hubli-Dharwad',
    'Mangaluru',
    'Belagavi',
    'Shivamogga',
    'Ballari',
    'Davanagere',
    'Tumakuru',
    'Raichur'
  ],
  'Kerala': [
    'Thiruvananthapuram',
    'Kochi',
    'Kozhikode',
    'Thrissur',
    'Kollam',
    'Palakkad',
    'Alappuzha',
    'Kannur',
    'Kottayam',
    'Malappuram'
  ],
  'Madhya Pradesh': [
    'Indore',
    'Bhopal',
    'Gwalior',
    'Jabalpur',
    'Ujjain',
    'Sagar',
    'Dewas',
    'Satna',
  ],
  'Maharashtra': [
    'Mumbai',
    'Pune',
    'Nagpur',
    'Nashik',
    'Aurangabad',
    'Solapur',
    'Kolhapur',
    'Sangli',
    'Jalgaon',
    'Akola',
    'Ahmednagar',
    'Amravati',
    'Latur',
    'Dhule',
    'Nanded',
    'Satara',
    'Chandrapur',
    'Parbhani',
    'Yavatmal',
    'Raigad'
  ],
  'Manipur': ['Imphal'],
  'Meghalaya': ['Shillong'],
  'Mizoram': ['Aizawl'],
  'Nagaland': ['Kohima'],
  'Odisha': [
    'Bhubaneswar',
    'Cuttack',
    'Rourkela',
    'Puri',
  ],
  'Punjab': [
    'Chandigarh',
    'Ludhiana',
    'Amritsar',
    'Jalandhar',
  ],
  'Rajasthan': [
    'Jaipur',
    'Jodhpur',
    'Udaipur',
    'Ajmer',
  ],
  'Sikkim': [
    'Gangtok',
    'Namchi',
    'Mangan',
    'Ravangla',
  ],
  'Tamil Nadu': [
    'Chennai',
    'Coimbatore',
    'Madurai',
    'Tiruchirappalli',
  ],
  'Telangana': [
    'Hyderabad',
    'Warangal',
    'Karimnagar',
    'Nizamabad',
  ],
  'Tripura': [
    'Agartala',
    'Dharmanagar',
    'Kailashahar',
    'Udaipur',
  ],
  'Uttarakhand': [
    'Dehradun',
    'Haridwar',
    'Rishikesh',
    'Nainital',
  ],
  'Uttar Pradesh': [
    'Lucknow',
    'Kanpur',
    'Varanasi',
    'Agra',
  ],
  'West Bengal': [
    'Kolkata',
    'Asansol',
    'Darjeeling',
    'Siliguri',
  ]
};
