import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faker/faker.dart';
import 'package:sg_easy_hire/models/RelatedModelType.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

final Map<String, List<String>> responsibilityMap = {
  // Caregiving
  'Infant Care': [
    'Prepare and sterilize milk bottles',
    'Monitor infant sleep and nap schedules',
    'Change diapers and maintain hygiene',
  ],
  'Newborn Care': [
    'Assist with nighttime feedings',
    'Perform umbilical cord care and sponge baths',
    'Track baby’s feeding and diaper patterns',
  ],
  'Elderly Care': [
    'Assist with daily mobility and transfers',
    'Ensure timely administration of medications',
    'Accompany the elderly to medical appointments',
  ],
  'Dementia Care': [
    'Provide constant supervision for safety',
    'Engage in memory-stimulating activities',
    'Maintain a calm and patient environment',
  ],

  // Cooking & Kitchen
  'Chinese Cooking': [
    'Prepare daily stir-fry dishes and Chinese soups',
    'Handle wok cooking and traditional ingredients',
    'Plan weekly menus for the family',
  ],
  'Indian Cooking': [
    'Prepare authentic Indian vegetarian/non-veg meals',
    'Manage spice inventory and fresh dough prep',
    'Make fresh chapatis/dosas for breakfast',
  ],
  'Marketing': [
    'Visit the wet market for fresh produce',
    'Manage grocery budget and receipts',
    'Keep track of kitchen inventory',
  ],

  // Housekeeping
  'Housekeeping': [
    'Maintain cleanliness of the entire household',
    'Perform deep cleaning of toilets and kitchen',
    'Organize wardrobes and living spaces',
  ],
  'Ironing': [
    'Iron clothes for the whole family weekly',
    'Handle delicate fabrics like silk and wool',
    'Ensure clothes are folded and kept away',
  ],
  'Car Wash': [
    'Wash and wax the family car weekly',
    'Vacuum and clean the car interior',
    'Check basic fluid levels and tire pressure',
  ],
  'Pet Care': [
    'Feed and provide water to pets regularly',
    'Clean pet living areas and litter boxes',
    'Perform basic pet grooming',
  ],
  'Dog Walker': [
    'Walk the dogs twice daily',
    'Ensure the dog is cleaned after walks',
    'Monitor pet behavior and health',
  ],

  // Home Environment
  'Gardening': [
    'Water the plants and maintain the lawn',
    'Perform pruning and basic fertilization',
    'Ensure garden tools are cleaned and stored',
  ],
  'Tutoring': [
    'Supervise children during homework time',
    'Teach basic English or Mathematics',
    'Conduct educational play sessions',
  ],
};

final List<String> startDateOptions = [
  'Immediate',
  'Flexible',
  'Within 1 month',
  'In 2 months',
  'After Chinese New Year',
  'After Hari Raya',
  'Beginning of next month',
];

final List<String> contractOptions = [
  '2 Years (Standard)',
  '1 Year (Renewable)',
  'Short-term (3-6 months)',
  'No Contract (Part-time)',
];
final List<String> personalityTypes = [
  'INTJ',
  'INTP',
  'ENTJ',
  'ENTP',
  'INFJ',
  'INFP',
  'ENFJ',
  'ENFP',
  'ISTJ',
  'ISFJ',
  'ESTJ',
  'ESFJ',
  'ISTP',
  'ISFP',
  'ESTP',
  'ESFP',
];
final List<String> offDayOptions = [
  'Every Sunday (4 days/month)',
  '2 Sundays per month',
  '1 Sunday per month',
  'No off-days (Compensated with pay)',
  'Every Sunday & Public Holidays',
  'Flexible (1 day during weekdays)',
  '2 Saturdays and 2 Sundays',
];
final List<String> accommodationOptions = [
  'Private Room provided',
  'Private Room with attached Bathroom',
  'Shared Room with children',
  'Shared Room with elderly',
  'Shared Room with another helper',
  'Standard Utility Room (Bomb Shelter)',
  'Partitioned private space',
];

String generateJobNote(String homeType, String childAges, List<String> tags) {
  String urgency = tags.contains('Urgent Hiring')
      ? "We need someone to start immediately."
      : "Looking for a reliable helper.";
  String homeDetails = "Our home is a $homeType.";
  String kids = childAges.isNotEmpty
      ? " We have children aged $childAges."
      : " No young children at home.";

  return "$urgency $homeDetails$kids Please be hardworking and honest.";
}

final Map<String, List<List<String>>> skillMap = {
  // Status & Urgency (General Skills)
  'Transfer Only': [
    ['Immediate Adaptation', 'Local Navigation'],
    ['Advanced Housekeeping'],
  ],
  'New Helper': [
    ['Basic Instructions', 'Willingness to Learn'],
    ['Introductory Cooking'],
  ],
  'Ex-Singapore': [
    ['SG Grocery Knowledge', 'MRT/Bus Routes'],
    ['Local Dialect Basics'],
  ],
  'Ex-Middle East': [
    ['Arabic Cuisine', 'Large Household Mgt'],
    ['Multitasking'],
  ],
  'Ex-Hong Kong': [
    ['Chinese Cooking', 'Small Space Mgt'],
    ['Cantonese Basics'],
  ],
  'Ex-Taiwan': [
    ['Mandarin Speaking', 'Taiwanese Cooking'],
    ['Elderly Care'],
  ],
  'Immediate Start': [
    ['Fast Learner', 'Ready to Work'],
    ['Quick Adaptation'],
  ],
  'Urgent Hiring': [
    ['Efficiency', 'Time Management'],
    ['High Productivity'],
  ],
  'Direct Hire': [
    ['Communication', 'Trustworthiness'],
    ['Independent Work'],
  ],
  'Replacement': [
    ['Problem Solving', 'Adaptability'],
    ['Conflict Resolution'],
  ],

  // Caregiving
  'Infant Care': [
    ['Bottle Sterilization', 'Diaper Changing'],
    ['Infant CPR', 'Sleep Training'],
  ],
  'Newborn Care': [
    ['Swaddling', 'Burping'],
    ['Umbilical Cord Care', 'Lactation Support'],
  ],
  'Toddler Care': [
    ['Potty Training', 'Toddler Meal Prep'],
    ['Educational Play', 'Safety'],
  ],
  'Elderly Care': [
    ['Mobility Support', 'Hygiene Care'],
    ['Vital Signs', 'Medication Admin'],
  ],
  'Dementia Care': [
    ['Patience', 'Safety Monitoring'],
    ['Memory Exercises', 'Behavior Mgt'],
  ],
  'Bedridden Care': [
    ['Pressure Sore Prevention', 'Sponge Bathing'],
    ['Tube Feeding', 'Suctioning'],
  ],
  'Special Needs': [
    ['Behavioral Support', 'Routine Mgt'],
    ['Therapy Exercise Assist'],
  ],
  'Stroke Patient': [
    ['Physiotherapy Assist', 'Assisted Feeding'],
    ['Speech Support'],
  ],
  'Nursing Skills': [
    ['Wound Dressing', 'Injection Assist'],
    ['Medical Charting'],
  ],
  'Companion': [
    ['Conversation', 'Escorting to Appts'],
    ['Leisure Activities'],
  ],

  // Skills & Tasks
  'Chinese Cooking': [
    ['Stir-fry', 'Soup Making'],
    ['Dim Sum', 'Herbal Tonics'],
  ],
  'Indian Cooking': [
    ['Curry Prep', 'Chapati Making'],
    ['Spice Blending', 'Vegetarian'],
  ],
  'Western Cooking': [
    ['Salad Prep', 'Roasting/Grilling'],
    ['Baking', 'Pasta Making'],
  ],
  'Malay Cooking': [
    ['Sambal Making', 'Halal Prep'],
    ['Traditional Kuih', 'Rendang'],
  ],
  'Baking': [
    ['Measuring Ingredients', 'Oven Safety'],
    ['Cake Decorating', 'Bread Making'],
  ],
  'Grocery Shopping': [
    ['Budgeting', 'Freshness Check'],
    ['Online Ordering'],
  ],
  'Car Wash': [
    ['Exterior Cleaning', 'Vacuuming'],
    ['Polishing', 'Leather Care'],
  ],
  'Gardening': [
    ['Watering', 'Weeding'],
    ['Pruning', 'Fertilizing'],
  ],
  'Pet Care': [
    ['Feeding', 'Walking'],
    ['Pet Grooming', 'Basic Vet Care'],
  ],
  'Dog Walker': [
    ['Leash Control', 'Waste Disposal'],
    ['Basic Obedience Training'],
  ],
  'Tutoring': [
    ['Homework Help', 'Reading'],
    ['Language Teaching', 'Science/Math Basics'],
  ],
  'Housekeeping': [
    ['Laundry', 'Vacuuming'],
    ['Ironing Silk', 'Deep Cleaning'],
  ],
  'Ironing': [
    ['Basic Ironing', 'Steam Ironing'],
    ['Folding Techniques', 'Fabric Care'],
  ],
  'Marketing': [
    ['Wet Market Shopping', 'Price Negotiation'],
    ['Meal Planning'],
  ],
  'Disability Care': [
    ['Transferring Skills', 'Equipment Handling'],
    ['Emotional Support'],
  ],

  // Home & Environment
  'HDB': [
    ['Space Optimization', 'General Cleaning'],
    ['Window Cleaning Safety'],
  ],
  'Condo': [
    ['Facility Booking', 'Intercom Handling'],
    ['Balcony Maintenance'],
  ],
  'Landed House': [
    ['Large Area Cleaning', 'Gate Mgt'],
    ['Outdoor Maintenance'],
  ],
  'No Pets': [
    ['Allergy Awareness', 'General Hygiene'],
    ['Sanitization'],
  ],
  'Cat Friendly': [
    ['Litter Box Cleaning', 'Cat Feeding'],
    ['Cat Playtime'],
  ],
  'Halal Kitchen': [
    ['Halal Ingredients', 'Separate Cookware'],
    ['Cross-contamination Prevention'],
  ],
  'No Pork': [
    ['Dietary Restriction Adherence'],
    ['Alternative Protein Prep'],
  ],
  'No Beef': [
    ['Dietary Restriction Adherence'],
    ['Menu Planning'],
  ],
  'Vegetarian': [
    ['Plant-based Cooking'],
    ['Vegetable Nutrition'],
  ],
  'Non-Smoking': [
    ['Healthy Environment Mgt'],
    ['Smoke-free Maintenance'],
  ],

  // Benefits & Terms
  'Sunday Off': [
    ['Schedule Planning'],
    ['Independent Living'],
  ],
  'Saturday Off': [
    ['Weekend Task Mgt'],
    ['Weekly Planning'],
  ],
  'Flexible Off': [
    ['Adaptability'],
    ['Open Communication'],
  ],
  'Own Room': [
    ['Room Maintenance'],
    ['Privacy Respect'],
  ],
  'Shared Room': [
    ['Organization', 'Consideration'],
    ['Shared Space Hygiene'],
  ],
  'WiFi Provided': [
    ['Digital Communication'],
    ['Online Learning'],
  ],
  'Stay-in': [
    ['Household Integration'],
    ['Home Safety'],
  ],
  'Stay-out': [
    ['Punctuality', 'Commuting'],
    ['Time Tracking'],
  ],
  'High Salary': [
    ['Advanced Skills', 'High Responsibility'],
    ['Specialized Care'],
  ],
  'Bonus Included': [
    ['Performance Focus'],
    ['Goal Setting'],
  ],
  'Phone Allowed': [
    ['Tech Savvy', 'Responsible Usage'],
    ['Emergency Contact Mgt'],
  ],
  'No Agency Fee': [
    ['Direct Communication'],
    ['Document Handling'],
  ],
  'Training Provided': [
    ['Eagerness to Learn'],
    ['Fast Implementation'],
  ],
  'Passport Ready': [
    ['Documentation Mgt'],
    ['Travel Readiness'],
  ],
  'Medical Ready': [
    ['Health Awareness'],
    ['First Aid Basics'],
  ],
};
final List<String> roomTypeOptions = [
  'Private Room (Attached Bath)',
  'Private Room',
  'Shared Room (with Children)',
  'Shared Room (with Elderly)',
  'Partitioned Space',
];
final List<String> homeTypeOptions = [
  // Singapore Public Housing (HDB)
  'HDB 3-Room Flat',
  'HDB 4-Room Flat',
  'HDB 5-Room Flat',
  'HDB Executive Mansionette',

  // Private Apartments
  'Condominium (Studio)',
  'Condominium (2-3 Bedroom)',
  'Condominium (Penthouse)',
  'Service Apartment',

  // Landed Properties (Usually require more work/higher salary)
  'Terrace House',
  'Semi-Detached House',
  'Bungalow / Detached House',
  'Good Class Bungalow (GCB)',
  'Townhouse',
  'Cluster House',

  // Malaysia Specific
  'Double Storey Terrace',
  'Link House',
  'Apartment / Flat',
];

final List<String> sgLocations = [
  'Orchard / River Valley (D09)',
  'Newton / Novena (D11)',
  'Bukit Timah / Holland (D10)',
  'Tampines / Pasir Ris (East)',
  'Bedok / Marine Parade (East Coast)',
  'Jurong / Bukit Batok (West)',
  'Choa Chu Kang / Woodlands (North)',
  'Ang Mo Kio / Bishan (Central)',
  'Sengkang / Punggol (North-East)',
  'Tiong Bahru / Queenstown',
  'Sentosa / Harbourfront',
  'Hougang / Serangoon',
  'Yishun / Sembawang',
  'Jurong East / Boon Lay',
  'Toa Payoh / Balestier',
];
final List<String> myLocations = [
  'Kuala Lumpur (KLCC)',
  'Mont Kiara / Bangsar',
  'Petaling Jaya (Selangor)',
  'Subang Jaya / Sunway',
  'George Town (Penang)',
  'Johor Bahru (JB)',
  'Ipoh (Perak)',
  'Shah Alam',
  'Cyberjaya / Putrajaya',
  'Melaka City',
];

final List<String> masterTagList = [
  // Status & Urgency
  'Transfer Only',
  'New Helper',
  'Ex-Singapore',
  'Ex-Middle East',
  'Ex-Hong Kong',
  'Ex-Taiwan', 'Immediate Start', 'Urgent Hiring', 'Direct Hire', 'Replacement',

  // Caregiving
  'Infant Care',
  'Newborn Care',
  'Toddler Care',
  'Elderly Care',
  'Dementia Care',
  'Bedridden Care',
  'Special Needs',
  'Stroke Patient',
  'Nursing Skills',
  'Companion',

  // Skills & Tasks
  'Chinese Cooking',
  'Indian Cooking',
  'Western Cooking',
  'Malay Cooking',
  'Baking',
  'Grocery Shopping', 'Car Wash', 'Gardening', 'Pet Care', 'Dog Walker',
  'Tutoring', 'Housekeeping', 'Ironing', 'Marketing', 'Disability Care',

  // Home & Environment
  'HDB', 'Condo', 'Landed House', 'No Pets', 'Cat Friendly',
  'Halal Kitchen', 'No Pork', 'No Beef', 'Vegetarian', 'Non-Smoking',

  // Benefits & Terms
  'Sunday Off', 'Saturday Off', 'Flexible Off', 'Own Room', 'Shared Room',
  'WiFi Provided', 'Stay-in', 'Stay-out', 'High Salary', 'Bonus Included',
  'Phone Allowed',
  'No Agency Fee',
  'Training Provided',
  'Passport Ready',
  'Medical Ready',
];

enum PhCountry { sg, mm }

String generatePhoneNumber(PhCountry country) {
  final faker = Faker();
  if (country == PhCountry.sg) {
    // Singapore pattern: 8 or 9 followed by 7 random digits
    final start = faker.randomGenerator.element(['8', '9']);
    final rest = faker.randomGenerator.fromPattern(['#######']);
    return '+65 $start$rest';
  } else {
    // Myanmar pattern: prefix 9 followed by 7 to 9 random digits
    // Using a 9-digit mobile pattern as standard
    final rest = faker.randomGenerator.fromPattern(['#########']);
    return '+95 9 $rest';
  }
}

String generateAvatarUrl(int index, UserRole role) {
  // Define categories based on roles
  final category = (role == UserRole.EMPLOYER) ? 'business' : 'person';

  // Logic: 300x300 image, based on category, with a 'lock' (index)
  // so User #1 always gets the same face.
  return 'https://loremflickr.com/300/300/$category?lock=$index';
}

List<T> pickRandomList<T>(List<T> source, {int min = 1}) {
  if (source.isEmpty) return [];
  final list = List<T>.from(source)..shuffle();
  final count = min + faker.randomGenerator.integer(list.length - min + 1);
  return list.take(count).toList();
}

TemporalDateTime nextWeekDateTime() {
  final now = DateTime.now();
  final randomDay = faker.randomGenerator.integer(7, min: 1);
  final randomHour = faker.randomGenerator.integer(18, min: 9); // 9 AM to 6 PM

  final futureDate = now
      .add(Duration(days: randomDay))
      .copyWith(
        hour: randomHour,
        minute: 0,
        second: 0,
        millisecond: 0,
      );

  return TemporalDateTime(futureDate);
}

DateTime hiredJobStartDate() {
  final now = DateTime.now();
  final randomDay = faker.randomGenerator.integer(60, min: 20);

  final futureDate = now
      .add(Duration(days: randomDay))
      .copyWith(
        minute: 0,
        second: 0,
        millisecond: 0,
      );

  return futureDate;
}

final List<Map<String, String>> urgentIssueSamples = [
  // Original Items
  {'issue': 'Passport Renewal', 'deadline': '14 Days'},
  {'issue': 'Work Permit Expiry', 'deadline': '7 Days'},
  {'issue': 'Six-Monthly Medical (6ME)', 'deadline': '21 Days'},
  {'issue': 'Insurance Renewal', 'deadline': '30 Days'},
  {'issue': 'Address Update (MOM)', 'deadline': '3 Days'},
  {'issue': 'Security Bond Escrow', 'deadline': '5 Days'},

  // Government & Compliance
  {'issue': 'E-Levy Payment Overdue', 'deadline': '2 Days'},
  {'issue': 'POEA Contract Verification', 'deadline': '10 Days'},
  {'issue': 'Work Permit Issuance (Card)', 'deadline': '5 Days'},
  {'issue': 'Employment Contract Renewal', 'deadline': '45 Days'},
  {'issue': 'OEC Application (Holiday Return)', 'deadline': '14 Days'},

  // Health & Safety
  {'issue': 'Follow-up Vaccination', 'deadline': '4 Days'},
  {'issue': 'Dental Emergency Checkup', 'deadline': '1 Day'},
  {'issue': 'Employer Orientation Program', 'deadline': '7 Days'},
  {'issue': 'Helper Settling-In Programme (SIP)', 'deadline': '3 Days'},

  // Travel & Exit
  {'issue': 'Home Leave Approval', 'deadline': '60 Days'},
  {'issue': 'Repatriation Ticket Booking', 'deadline': '14 Days'},
  {'issue': 'Embassy Attestation', 'deadline': '10 Days'},

  // Financial & Administrative
  {'issue': 'Salary Dispute Resolution', 'deadline': '48 Hours'},
  {'issue': 'Bank Account Opening', 'deadline': '5 Days'},
  {'issue': 'Performance Review', 'deadline': '30 Days'},
  {'issue': 'Rest Day Compensation Setup', 'deadline': '7 Days'},
];

final List<Map<String, dynamic>> helperToEmployerReviews = [
  // High Praise
  {
    'comment': 'Very kind family, they treated me like a member of the home.',
    'rating': 5.0,
  },
  {
    'comment': 'Generous with food and always pays salary on time.',
    'rating': 5.0,
  },
  {
    'comment': 'The children are very well-behaved and easy to care for.',
    'rating': 5.0,
  },
  {
    'comment':
        'Employer is very understanding if I need to call my family back home.',
    'rating': 5.0,
  },
  {
    'comment':
        'I highly recommend this employer; they respect my rest days completely.',
    'rating': 5.0,
  },

  // Positive but Balanced
  {
    'comment': 'Good environment, provided me with a private room and WiFi.',
    'rating': 4.5,
  },
  {
    'comment': 'Workload is heavy but the employer is very appreciative.',
    'rating': 4.0,
  },
  {
    'comment': 'Clear instructions given, no confusion about my daily tasks.',
    'rating': 4.0,
  },
  {
    'comment':
        'They taught me how to cook their family recipes with great patience.',
    'rating': 4.0,
  },
  {
    'comment':
        'A busy household with many pets, but the family is very supportive.',
    'rating': 4.5,
  },

  // Average / Neutral
  {
    'comment': 'Sometimes a bit strict with timings, but overall fair.',
    'rating': 3.5,
  },
  {
    'comment':
        'House is very large so cleaning takes a lot of time, but salary is okay.',
    'rating': 3.5,
  },
  {
    'comment':
        'Employer follows the contract strictly. Professional relationship.',
    'rating': 3.0,
  },
  {
    'comment':
        'Expectations are very high for cooking, but they provide all ingredients.',
    'rating': 3.5,
  },

  // Constructive / Lower Rating
  {
    'comment':
        'The work hours are quite long, usually starting at 5 AM and ending late.',
    'rating': 2.5,
  },
  {
    'comment': 'Living space is a bit small and shared with the laundry area.',
    'rating': 2.5,
  },
  {
    'comment':
        'Communication was difficult at first because of the language barrier.',
    'rating': 3.0,
  },
  {
    'comment':
        'A lot of last-minute changes to my schedule, which was a bit stressful.',
    'rating': 2.5,
  },
];

final List<String> trainingModules = [
  // --- Basic & Mandatory ---
  'General Housekeeping & Sanitization',
  'First Aid & Emergency Response',
  'Food Safety & Hygiene Standards',
  'Workplace Safety & Health (MOM Guidelines)',
  'Communication & Conflict Resolution',

  // --- Specialized Caregiving ---
  'Infant Care & Safety Essentials',
  'Newborn Care & Breastfeeding Support',
  'Elderly Care & Mobility Assistance',
  'Dementia & Alzheimer’s Care Awareness',
  'Special Needs & Disability Support',
  'Bedridden Patient Care & Hygiene',
  'Medication Management & Vital Signs Monitoring',
  'Palliative Care Support',

  // --- Cooking & Culinary ---
  'Advanced Chinese Cooking (Soups & Stir-fry)',
  'Authentic Indian Cuisine (Veg & Non-Veg)',
  'Western Meal Prep & Table Etiquette',
  'Malay & Halal Food Preparation',
  'Baking & Pastry Basics',
  'Healthy Meal Planning & Nutrition for Kids',

  // --- Household & Personal Development ---
  'Financial Literacy & Savings Strategies',
  'Urban Gardening & Plant Maintenance',
  'Pet Care & Basic Dog Grooming',
  'Time Management for Multi-Tasking Households',
  'Deep Cleaning & Home Organization Techniques',
  'English Language Proficiency (Intermediate)',
  'Understanding Employment Rights & Contracts',
];

final List<Map<String, dynamic>> transactionTypes = [
  // --- Original Salary Items ---
  {'desc': 'Monthly Salary', 'min': 600.0, 'max': 900.0, 'code_prefix': 'SAL'},
  {'desc': 'Rest Day Pay', 'min': 25.0, 'max': 100.0, 'code_prefix': 'RDP'},
  {
    'desc': 'Performance Bonus',
    'min': 50.0,
    'max': 200.0,
    'code_prefix': 'BON',
  },
  {
    'desc': 'Medical Reimbursement',
    'min': 30.0,
    'max': 150.0,
    'code_prefix': 'MED',
  },

  // --- Agency & Placement Fees ---
  {
    'desc': 'Agency Service Fee',
    'min': 100.0,
    'max': 300.0,
    'code_prefix': 'AGY',
  },
  {
    'desc': 'Contract Renewal Fee',
    'min': 150.0,
    'max': 250.0,
    'code_prefix': 'RNW',
  },
  {
    'desc': 'Documentation Fee',
    'min': 50.0,
    'max': 120.0,
    'code_prefix': 'DOC',
  },

  // --- Government & Compliance ---
  {
    'desc': 'Foreign Worker Levy',
    'min': 60.0,
    'max': 300.0,
    'code_prefix': 'LEV',
  },
  {
    'desc': 'Work Permit Application',
    'min': 35.0,
    'max': 70.0,
    'code_prefix': 'WPA',
  },
  {
    'desc': 'Security Bond Deposit',
    'min': 100.0,
    'max': 500.0,
    'code_prefix': 'BND',
  },

  // --- Insurance & Health ---
  {
    'desc': 'Medical Insurance Premium',
    'min': 200.0,
    'max': 450.0,
    'code_prefix': 'INS',
  },
  {
    'desc': 'Personal Accident Cover',
    'min': 50.0,
    'max': 100.0,
    'code_prefix': 'PAC',
  },
  {
    'desc': '6ME Medical Checkup Fee',
    'min': 40.0,
    'max': 80.0,
    'code_prefix': 'CHK',
  },

  // --- Travel & Welfare ---
  {
    'desc': 'Home Leave Airfare',
    'min': 300.0,
    'max': 700.0,
    'code_prefix': 'FLT',
  },
  {
    'desc': 'Settling-In Programme (SIP)',
    'min': 75.0,
    'max': 150.0,
    'code_prefix': 'SIP',
  },
  {
    'desc': 'Emergency Loan Disbursement',
    'min': 100.0,
    'max': 500.0,
    'code_prefix': 'LON',
  },
];

final List<Map<String, String>> translationTemplates = [
  // --- Original Items ---
  {
    "en":
        "The helper has 5 years of experience in Singapore and is good at cooking.",
    "mm":
        "အကူသည် စင်ကာပူတွင် အတွေ့အကြုံ ၅ နှစ်ရှိပြီး ချက်ပြုတ်ရာတွင် ကျွမ်းကျင်ပါသည်။",
  },
  {
    "en":
        "She is very patient with elderly care and knows how to use a wheelchair.",
    "mm":
        "သူမသည် လူကြီးမိဘများကို ပြုစုစောင့်ရှောက်ရာတွင် အလွန်စိတ်ရှည်ပြီး ဝှီးချဲအသုံးပြုပုံကိုလည်း သိပါသည်။",
  },
  {
    "en": "Employer agreed to provide one day off per week and a private room.",
    "mm":
        "အလုပ်ရှင်က တစ်ပတ်လျှင် တစ်ရက်နားရက်နှင့် သီးသန့်အခန်းပေးရန် သဘောတူခဲ့သည်။",
  },
  {
    "en":
        "Communication is clear; she understands basic household instructions well.",
    "mm":
        "ဆက်သွယ်ပြောဆိုမှု ရှင်းလင်းပါသည်။ သူမသည် အခြေခံအိမ်မှုကိစ္စ ညွှန်ကြားချက်များကို ကောင်းစွာနားလည်သည်။",
  },

  // --- New Items: Salary & Logistics ---
  {
    "en": "I am okay with the offered salary of 700 SGD per month.",
    "mm": "ကမ်းလှမ်းထားတဲ့ တစ်လလစာ စင်ကာပူဒေါ်လာ ၇၀၀ ကို ကျွန်မသဘောတူပါတယ်။",
  },
  {
    "en": "Does the house have a dedicated WiFi connection for my use?",
    "mm": "အိမ်မှာ ကျွန်မသုံးဖို့အတွက် သီးသန့် WiFi ရှိပါသလား။",
  },
  {
    "en": "I need to send money back to my family in Myanmar every month.",
    "mm": "ကျွန်မ လစဉ် မြန်မာပြည်က မိသားစုဆီ ပိုက်ဆံပြန်ပို့ဖို့ လိုအပ်ပါတယ်။",
  },

  // --- New Items: Childcare & Tasks ---
  {
    "en": "I have experience taking care of newborn babies and toddlers.",
    "mm":
        "ကျွန်မမှာ မွေးကင်းစကလေးငယ်တွေနဲ့ လမ်းလျှောက်တတ်စ ကလေးတွေကို ပြုစုစောင့်ရှောက်ဖူးတဲ့ အတွေ့အကြုံရှိပါတယ်။",
  },
  {
    "en": "Can you show me how to operate the washing machine and dryer?",
    "mm":
        "အဝတ်လျှော်စက်နဲ့ အခြောက်ခံစက် ဘယ်လိုသုံးရမလဲဆိုတာ ကျွန်မကို ပြပေးလို့ရမလား။",
  },
  {
    "en": "I am comfortable living with small dogs and cats.",
    "mm": "ကျွန်မ ခွေးလေးတွေ၊ ကြောင်လေးတွေနဲ့ အတူတူနေရတာ အဆင်ပြေပါတယ်။",
  },

  // --- New Items: Food & Health ---
  {
    "en": "I can cook basic Western food like pasta and salad.",
    "mm":
        "ကျွန်မ ပါစတာနဲ့ ဆလတ်လိုမျိုး အခြေခံ အနောက်တိုင်းအစားအစာတွေကို ချက်တတ်ပါတယ်။",
  },
  {
    "en": "Please let me know if anyone in the family has food allergies.",
    "mm":
        "မိသားစုထဲမှာ အစားအသောက်နဲ့ ဓာတ်မတည့်တာမျိုး ရှိရင် ကျွန်မကို ပြောပြပေးပါ။",
  },
  {
    "en": "I don't eat pork, but I am okay with handling it for the family.",
    "mm":
        "ကျွန်မ ဝက်သားမစားပေမယ့် မိသားစုအတွက် ချက်ပြုတ်ပြင်ဆင်ပေးဖို့ အဆင်ပြေပါတယ်။",
  },

  // --- New Items: Emergency & Safety ---
  {
    "en": "In case of emergency, who is the first person I should call?",
    "mm": "အရေးပေါ်အခြေအနေမျိုးမှာ ကျွန်မ ဘယ်သူ့ကို အရင်ဆုံး ဖုန်းဆက်ရမလဲ။",
  },
  {
    "en": "I understand the safety rules for the high-rise building.",
    "mm":
        "တိုက်ခန်းမြင့်မှာ နေထိုင်တဲ့အခါ လိုက်နာရမယ့် ဘေးကင်းလုံခြုံရေး စည်းကမ်းတွေကို ကျွန်မ နားလည်ပါတယ်။",
  },
];

final List<Map<String, String>> adminActionTemplates = [
  // Financial Actions
  {
    'title': 'Large Transaction Detected',
    'desc': 'Employer {name} processed a payment of \$1,200.',
  },
  {
    'title': 'Wallet Withdrawal',
    'desc': 'Agency fee withdrawal of \$500 initiated.',
  },

  // Hiring & Conversion
  {
    'title': 'New Placement Successful',
    'desc': 'Helper {name} has been officially hired by {employer}.',
  },
  {
    'title': 'Interview Feedback Received',
    'desc': 'A new conversation report was filed for Interview #{id}.',
  },

  // Compliance & Security
  {
    'title': 'Verification Approved',
    'desc': 'User {name} has successfully passed the KYC verification.',
  },
  {
    'title': 'Contract Dispute Logged',
    'desc': 'A notification was triggered regarding a contract disagreement.',
  },
  {
    'title': 'Document Expiry Warning',
    'desc': 'Helper {name}\'s work permit is expiring in 30 days.',
  },

  // System Growth
  {
    'title': 'New Employer Registered',
    'desc': 'A new employer profile "{name}" was created.',
  },
  {
    'title': 'Training Milestone',
    'desc': 'Over 50 helpers completed the "Food Safety" module today.',
  },
];

final List<Map<String, dynamic>> supportScenarios = [
  {
    'type': RelatedModelType.HIRED_JOB,
    'subjects': [
      "Contract Dispute",
      "Job Cancellation",
      "Work Scope Clarification",
    ],
    'descriptions': [
      "The employer is asking for tasks not in the contract.",
      "The helper did not show up for the scheduled start date.",
      "I need to update the rest day arrangements in the digital contract.",
    ],
  },
  {
    'type': RelatedModelType.TRANSACTION,
    'subjects': ["Payment Not Received", "Double Charge", "Incorrect Amount"],
    'descriptions': [
      "The salary was deducted from my wallet but the helper hasn't received it.",
      "I was charged twice for the insurance processing fee.",
      "The monthly levy amount looks higher than expected.",
    ],
  },
  {
    'type': RelatedModelType.WALLET,
    'subjects': ["Top-up Failure", "Wallet Frozen", "Withdrawal Issue"],
    'descriptions': [
      "My credit card was declined during the wallet top-up process.",
      "I cannot access my wallet funds after the recent update.",
      "The withdrawal to my bank account is taking longer than 3 days.",
    ],
  },
];
