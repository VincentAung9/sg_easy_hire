import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faker/faker.dart' hide Job;
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/faker/db_seed_data.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class DynamoDBSeeder {
  final faker = Faker();

  /* List<User> helpers = [];
  List<User> employers = [];
 List<Job> jobs = [];
  List<HiredJob> hiredJobs = [];
  List<Interview> interviews = [];
  List<ChatRoom> userChatRooms = [];
  List<ChatRoom> adminChatRooms = [];
  List<Wallet> employerWallets = [];
  List<Transaction> transactions = [];

  User? admin; */
  Future<void> seedAll() async {
    try {
      print("--- Starting Master Seed ---");

      // STAGE 1: Identity (Users & Profiles)
      /*  await _seedAdmin();
      await _seedHelpers();
      await _seedEmployers();
      await _seedPersonalInformations();
      await _seedContactFamilyDetails();
      await _seedMedicalHistories();
      await _seedOtherPersonalInfos();

      // STAGE 2: Preferences & History
      await _seedJobPreferences();
      await _seedWorkHistories();
      await _seedEmployerContacts();

      // STAGE 3: Job Market (Posting & Matching)
      await _seedJobTags();
      await _seedJobs();
      await _seedAppliedJobs();
      await _seedSavedJobs();
      await _seedSavedHelpers();
      await _seedViewHelpers();

      // STAGE 4: Hiring Process
      await _seedInterviews();
      await _seedJobOffers();
      await _seedHireJobs();

      // STAGE 5: Communication (User to User)
      await _seedUserChatRooms();
      await _seedUserChatMessages();
      await _seedConversationReports();

      // STAGE 6: Post-Hiring & Training
      await _seedUrgentActions();
      await _seedReviews();
      await _seedTrainingRecords(); 

      // STAGE 7: Financials
      await _seedWallets();
      await _seedTransactions();
      await _seedInvoices();
      await _seedFinancialAlerts();

      // STAGE 8: Admin Operations
      await _seedAdminRecentActions();
      await _seedAdminSupportSystems(); */
      await _seedAdminSupportSystems();
      await _seedOtherPersonalInfos();

      print("--- Master Seed Completed Successfully ---");
    } catch (e) {
      print("Error during seeding: $e");
    }
  }

  /*   Future<void> _seedAdmin() async {
    final adminModel = User(
      createdAt: TemporalDateTime(faker.date.dateTime()),
      code: nanoid(10),
      fullName: faker.person.name(),
      email: faker.internet.email(),
      phone: generatePhoneNumber(PhCountry.mm),
      avatarURL: generateAvatarUrl(1, UserRole.ADMIN),
      role: UserRole.ADMIN,
      completeProgress: 0,
    );
    final request = ModelMutations.create(adminModel);
    final response = await Amplify.API.mutate(request: request).response;
    if (!(response.data == null)) {
      admin = adminModel;
    }
  }

  Future<void> _seedHelpers() async {
    for (var i = 0; i < 50; i++) {
      final hasExperience = faker.randomGenerator.integer(100) > 20;
      final mockExperience = hasExperience
          ? "${faker.randomGenerator.integer(10, min: 1)} years"
          : null;

      final salaryOptionsWithNoExperiences = [
        jsonEncode({
          "name": 'No experiences',
          "salary": "500",
          "expectedSalary": faker.randomGenerator.integer(500, min: 200),
        }),
        jsonEncode({
          "name": 'No experiences but nursing aid certificates',
          "salary": "520",
          "expectedSalary": faker.randomGenerator.integer(520, min: 200),
        }),
      ];
      final salaryOptionsWithExperiences = [
        jsonEncode({
          "name": 'Middle east experiences',
          "salary": "520-580 ",
          "expectedSalary": faker.randomGenerator.integer(580, min: 520),
        }),
        jsonEncode({
          "name": 'Singapore experiences',
          "salary": "540-700",
          "expectedSalary": faker.randomGenerator.integer(700, min: 540),
        }),
        jsonEncode({
          "name": 'Taiwan experiences',
          "salary": "600-670",
          "expectedSalary": faker.randomGenerator.integer(670, min: 600),
        }),
      ];
      final helper = User(
        createdAt: TemporalDateTime(faker.date.dateTime()),
        code: nanoid(10),
        fullName: faker.person.name(),
        email: faker.internet.email(),
        phone: generatePhoneNumber(PhCountry.mm),
        avatarURL: generateAvatarUrl(i, UserRole.HELPER),
        verifyStatus: faker.randomGenerator.element([
          VerifyStatus.PENDING,
          VerifyStatus.UNVERIFIED,
          VerifyStatus.VERIFIED,
        ]),
        role: UserRole.HELPER,
        completeProgress: faker.randomGenerator.decimal(scale: 100),
        isOnline: false,
        accountstatus: faker.randomGenerator.element([
          AccountStatus.ACTIVATED,
          AccountStatus.DEACTIVATED,
        ]),
        currentAddress: faker.randomGenerator.element([
          'No. 45, Pyay Road, Mayangone Township, Yangon',
          '78th Street, Between 30th & 31st, Chanayethazan, Mandalay',
          'Bogyoke Aung San Road, Bahan Township, Yangon',
          'No. 12, Insein Road, Hlaing Township, Yangon',
          'Maha Bandula Street, Kyauktada Township, Yangon',
          'No. 102, 19th Street, Latha Township, Yangon',
          'Ziwaka Road, Dagon Township, Yangon',
          'Cherry Road, East Dagon, Yangon',
          'Main Road, Pyin Sar Village, Pyin Oo Lwin',
          'University Avenue Road, Kamayut Township, Yangon',
        ]),
        personalityType: faker.randomGenerator.element(personalityTypes),
        skills: pickRandomList([
          'Cleaning',
          'Cooking',
          'Laundry',
          'Ironing',
          'Dishwashing',
          'Childcare',
          'Elder care',
          'Pet care',
          'Grocery shopping',
          'Time management',
          'Basic first aid',
          'Organization',
          'Communication',
          'Punctuality',
          'Trustworthiness',
          'Multitasking',
          'Following instructions',
          'Safety awareness',
          'Problem solving',
          'Physical stamina',
        ], min: 3),
        nationality: "Burmese",
        languagesSpoken: pickRandomList([
          'English',
          'Mandarin',
          'Burmese',
          'Tamil',
          'Malay',
        ]),
        age: faker.randomGenerator.integer(30, min: 24),
        height: faker.randomGenerator.integer(200, min: 144).toString(),
        weight: faker.randomGenerator.integer(90, min: 45).toString(),
        totalExperiences: mockExperience,
        expectedSalary: mockExperience == null
            ? faker.randomGenerator.element(salaryOptionsWithNoExperiences)
            : faker.randomGenerator.element(salaryOptionsWithExperiences),
        passportStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        medicalStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        tranningStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        helperStatus: faker.randomGenerator.element([
          HelperStatus.PENDING,
          HelperStatus.INTRANNING,
        ]),
      );
      final request = ModelMutations.create(helper);
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        helpers.add(helper);
      }
    }
  }

  Future<void> _seedEmployers() async {
    for (var i = 0; i < 50; i++) {
      final hasExperience = faker.randomGenerator.integer(100) > 20;
      final mockExperience = hasExperience
          ? "${faker.randomGenerator.integer(10, min: 1)} years"
          : null;

      final salaryOptions = [
        jsonEncode({
          "name": 'No experiences',
          "salary": "500",
          "expectedSalary": faker.randomGenerator.integer(500, min: 200),
        }),
        jsonEncode({
          "name": 'No experiences but nursing aid certificates',
          "salary": "520",
          "expectedSalary": faker.randomGenerator.integer(520, min: 200),
        }),
        jsonEncode({
          "name": 'Middle east experiences',
          "salary": "520-580 ",
          "expectedSalary": faker.randomGenerator.integer(580, min: 520),
        }),
        jsonEncode({
          "name": 'Singapore experiences',
          "salary": "540-700",
          "expectedSalary": faker.randomGenerator.integer(700, min: 540),
        }),
        jsonEncode({
          "name": 'Taiwan experiences',
          "salary": "600-670",
          "expectedSalary": faker.randomGenerator.integer(670, min: 600),
        }),
      ];
      final employer = User(
        createdAt: TemporalDateTime(faker.date.dateTime()),
        code: nanoid(10),
        fullName: faker.person.name(),
        email: faker.internet.email(),
        phone: generatePhoneNumber(PhCountry.mm),
        avatarURL: generateAvatarUrl(i, UserRole.EMPLOYER),
        verifyStatus: faker.randomGenerator.element([
          VerifyStatus.PENDING,
          VerifyStatus.UNVERIFIED,
          VerifyStatus.VERIFIED,
        ]),
        location: faker.randomGenerator.element([
          'Orchard, Singapore',
          'Tampines, Singapore',
          'Jurong East, Singapore',
          'Woodlands, Singapore',
          'Ang Mo Kio, Singapore',
          'Kuala Lumpur, Malaysia',
          'Johor Bahru, Malaysia',
          'Penang, Malaysia',
          'Ipoh, Malaysia',
          'Melaka, Malaysia',
        ]),
        currentAddress: faker.randomGenerator.element([
          'Orchard, Singapore',
          'Tampines, Singapore',
          'Jurong East, Singapore',
          'Woodlands, Singapore',
          'Ang Mo Kio, Singapore',
          'Kuala Lumpur, Malaysia',
          'Johor Bahru, Malaysia',
          'Penang, Malaysia',
          'Ipoh, Malaysia',
          'Melaka, Malaysia',
        ]),
        hiredCount: faker.randomGenerator.integer(20),
        role: UserRole.EMPLOYER,
        completeProgress: faker.randomGenerator.decimal(scale: 100),
        isOnline: false,
        isVIP: faker.randomGenerator.element([false, true, false]),
        accountstatus: faker.randomGenerator.element([
          AccountStatus.ACTIVATED,
          AccountStatus.DEACTIVATED,
        ]),
        personalityType: faker.randomGenerator.element([
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
        ]),
        skills: pickRandomList([
          'Cleaning',
          'Cooking',
          'Laundry',
          'Ironing',
          'Dishwashing',
          'Childcare',
          'Elder care',
          'Pet care',
          'Grocery shopping',
          'Time management',
          'Basic first aid',
          'Organization',
          'Communication',
          'Punctuality',
          'Trustworthiness',
          'Multitasking',
          'Following instructions',
          'Safety awareness',
          'Problem solving',
          'Physical stamina',
        ], min: 3),
        nationality: "Burmese",
        languagesSpoken: pickRandomList([
          'English',
          'Mandarin',
          'Burmese',
          'Tamil',
          'Malay',
        ]),
        age: faker.randomGenerator.integer(30, min: 24),
        height: faker.randomGenerator.integer(200, min: 144).toString(),
        weight: faker.randomGenerator.integer(90, min: 45).toString(),
        totalExperiences: mockExperience,
        expectedSalary: faker.randomGenerator.element(salaryOptions),
        passportStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        medicalStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        tranningStatus: faker.randomGenerator.element([
          DocumentStatus.PENDING,
          DocumentStatus.READY,
          DocumentStatus.VERIFIED,
        ]),
        helperStatus: faker.randomGenerator.element([
          HelperStatus.PENDING,
          HelperStatus.INTRANNING,
        ]),
      );
      final request = ModelMutations.create(employer);
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        employers.add(employer);
      }
    }
  }

  Future<void> _seedPersonalInformations() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];

      final request = ModelMutations.create(
        PersonalInformation(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          dateOfBirth: TemporalDate(
            faker.date.dateTime(minYear: 1998, maxYear: 2000),
          ),
          placeOfBirth: helper.currentAddress,
          gender: faker.randomGenerator.element(["Male", "Female"]),
          user: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedContactFamilyDetails() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];
      final martialStatus = faker.randomGenerator.element([
        'Single',
        'Married',
        'Widowed',
        'Divorced',
        'Separated',
      ]);
      final request = ModelMutations.create(
        ContactFamilyDetails(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          residentialAddress: helper.currentAddress,
          contactNumber: helper.phone,
          airPort: faker.randomGenerator.element([
            "Yangon International Airport (RGN)",
            "Mandalay International Airport (MDL)",
            "Nay Pyi Taw International Airport (NYT)",
          ]),
          email: faker.internet.email(),
          religion: faker.randomGenerator.element([
            'Buddhism',
            'Christianity',
            'Islam',
            'Hinduism',
            'Animism',
          ]),
          educationLevel: faker.randomGenerator.element([
            'Primary School',
            'Middle School (Grade 9)',
            'High School (Grade 11/12)',
            'Vocational Training Certificate',
            'Diploma in Nursing',
            'Diploma in Caregiving',
            'Bachelor Degree',
            'Undergraduate',
          ]),
          numOfSiblings: faker.randomGenerator.integer(6).toString(),
          martialStatus: martialStatus,
          numOfChild: martialStatus != 'Single'
              ? faker.randomGenerator.integer(4).toString()
              : "0",
          ageOfChild: martialStatus != 'Single'
              ? faker.randomGenerator.integer(10).toString()
              : "0",
          user: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedMedicalHistories() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];

      final request = ModelMutations.create(
        MedicalHistory(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          type: faker.randomGenerator.element([
            'A+',
            'A-',
            'B+',
            'B-',
            'O+',
            'O-',
            'AB+',
            'AB-',
          ]),
          anyAllergies: faker.randomGenerator.element([
            'None',
            'Penicillin',
            'Dust mites',
            'Seafood (prawns/crabs)',
            'Peanuts',
            'Latex',
            'Sulfa drugs',
          ]),
          pastAndExistingIllnesses: faker.randomGenerator.element([
            [
              'Asthma',
              'Chicken Pox',
              'Dengue Fever',
              'High Blood Pressure',
              'Migraine',
              'Gastritis',
              'None',
            ],

            [],
          ]),
          otherIllnesses: faker.randomGenerator.element([
            'Asthma',
            'Chicken Pox',
            'Dengue Fever',
            'High Blood Pressure',
            'Migraine',
            'Gastritis',
            'None',
          ]),
          physicalDisabilities: faker.randomGenerator.element([
            'None',
            'Minor vision impairment (wears glasses)',
            'Partial hearing loss',
            'None - Fully fit for physical work',
          ]),
          dietaryRestrictions: faker.randomGenerator.element([
            'No Beef',
            'No Pork',
            'Vegetarian',
            'Halal only',
            'No Seafood',
            'None',
          ]),
          user: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }


  Future<void> _seedJobPreferences() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];

      final request = ModelMutations.create(
        JobPreferences(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          preferredOffDaysPerMonth: faker.randomGenerator.element([
            '0 days (Compensation given)',
            '1 day per month',
            '2 days per month',
            '4 days per month (All Sundays)',
            'Flexible / Negotiable',
          ]),
          preferredLocationInSingapore: faker.randomGenerator.element([
            'No Preference / Anywhere',
            'Central (Orchard/Novena)',
            'East (Tampines/Bedok)',
            'West (Jurong/Bukit Batok)',
            'North (Woodlands/Yishun)',
            'North-East (Sengkang/Punggol)',
            'South (Bukit Merah/Sentosa)',
          ]),
          willingWorkOnRestDays: faker.randomGenerator.element([true, false]),
          user: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedWorkHistories() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];
      if (helper.totalExperiences == null) {
        continue;
      }

      RegExp regExp = RegExp(r'\d+');
      String? result = regExp.stringMatch(helper.totalExperiences!);
      final expYear = int.tryParse(result ?? "0");
      final request = ModelMutations.create(
        WorkHistory(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          location: faker.randomGenerator.element([
            'Singapore (Lakeside)',
            'Singapore (Marine Parade)',
            'Kuala Lumpur, Malaysia',
            'George Town, Penang',
            'Dubai, UAE',
            'Riyadh, Saudi Arabia',
            'Hong Kong (Central)',
            'Yangon, Myanmar (Local)',
          ]),
          duration: expYear.toString(),
          description: faker.randomGenerator.element([
            'Worked for a Chinese family of 4 in a 3-bedroom HDB.',
            'Served a Malay family of 5 in a landed house.',
            'Worked for an elderly couple in a private condominium.',
            'General housework for a family with 2 newborn twins.',
            'Helper for a Western expat family with 3 school-going children.',
            'Sole helper for a 3-storey bungalow with 2 dogs.',
          ]),
          duties: faker.randomGenerator.element([
            [
              'General cleaning',
              'Grocery shopping',
              'Daily cooking',
              'Laundry & Ironing',
            ].join(", "),
            [
              'Elderly care',
              'Showering assistance',
              'Feeding',
              'Medication management',
            ].join(", "),
            [
              'Infant care',
              'Sterilizing bottles',
              'Preparing baby food',
              'Nanny duties',
            ].join(", "),
            [
              'Pet care (Dogs)',
              'Car washing',
              'Gardening',
              'Outdoor maintenance',
            ].join(", "),
            [
              'Chinese cuisine cooking',
              'Market marketing',
              'Deep cleaning',
              'Holiday prep',
            ].join(", "),
            [
              'Fetching children from school',
              'Tutoring assistance',
              'Kids meal prep',
            ].join(", "),
            [
              'Disabled care',
              'Wheelchair assistance',
              'Physical therapy support',
            ].join(", "),
          ]),
          helper: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedEmployerContacts() async {
    for (var i = 0; i < 50; i++) {
      final employer = employers[i];

      final request = ModelMutations.create(
        EmployerContact(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          mobile: generatePhoneNumber(PhCountry.sg),
          adress: faker.randomGenerator.element([
            'Orchard, Singapore',
            'Tampines, Singapore',
            'Jurong East, Singapore',
            'Woodlands, Singapore',
            'Ang Mo Kio, Singapore',
            'Kuala Lumpur, Malaysia',
            'Johor Bahru, Malaysia',
            'Penang, Malaysia',
            'Ipoh, Malaysia',
            'Melaka, Malaysia',
          ]),
          employer: employer,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedJobTags() async {
    for (var name in masterTagList) {
      await Amplify.API
          .mutate(
            request: ModelMutations.create(
              JobTag(name: name, createdAt: TemporalDateTime.now()),
            ),
          )
          .response;
    }
  }

  Future<void> _seedJobs() async {
    final allLocations = [...sgLocations, ...myLocations];
    for (var i = 0; i < 50; i++) {
      final employer = faker.randomGenerator.element(employers);
      // ignore: inference_failure_on_instance_creation
      final selectedTags = (List.from(
        masterTagList,
      )..shuffle()).take(3).cast<String>().toList();
      final title = "${selectedTags[0]} Needed";
      final location = faker.randomGenerator.element(allLocations);
      final currency = sgLocations.contains(location) ? "SGD" : "MYR";
      final childCount = faker.randomGenerator.integer(4);
      final adultCount = faker.randomGenerator.integer(6);
      final elderlyCount = faker.randomGenerator.integer(2);
      final familyMembers =
          childCount +
          adultCount +
          elderlyCount +
          (faker.randomGenerator.integer(2, min: 1));
      String childAges = "";

      if (childCount > 0) {
        List<int> ages = List.generate(
          childCount,
          (_) => faker.randomGenerator.integer(12, min: 1),
        )..sort(); //(e.g., "2 and 5" instead of "5 and 2")
        if (ages.length == 1) {
          childAges = "${ages[0]} years old";
        } else {
          String leadAges = ages.sublist(0, ages.length - 1).join(", ");
          childAges = "$leadAges and ${ages.last} years old";
        }
      }
      List<String> skillsList = [];

      for (var tag in selectedTags) {
        if (skillMap.containsKey(tag)) {
          skillsList.addAll(skillMap[tag]!.expand((i) => i));
        }
      }

      // Ensure unique values and a clean list
      final List<String> requiredSkills = skillsList.toSet().toList();
      final homeType = faker.randomGenerator.element(homeTypeOptions);
      final isImmediate = faker.randomGenerator.boolean();
      final startDate = isImmediate
          ? 'Immediate'
          : 'Starting ${faker.date.month()} ${DateTime.now().year}';

      final jobType = faker.randomGenerator.element([
        'Full-Time (Transfer)',
        'Full-Time (New/Ex-Pa)',
      ]);
      String contract;
      if (jobType.contains('Full-Time')) {
        contract = '2 Years (Standard)';
      } else {
        contract = '1 Year (Renewable)';
      }

      List<String> combinedResponsibilities = [];

      for (var tag in selectedTags) {
        // Check if the selected tag exists in  responsibilityMap
        if (responsibilityMap.containsKey(tag)) {
          combinedResponsibilities.addAll(responsibilityMap[tag]!);
        }
      }

      // 3. Add mandatory general tasks if the list is too short or empty
      if (combinedResponsibilities.length < 3) {
        combinedResponsibilities.addAll([
          'Maintain general household cleanliness',
          'Perform daily laundry and dishwashing',
        ]);
      }

      // 4. Final cleaning: remove duplicates and limit size for a clean UI
      final finalResponsibilities = combinedResponsibilities
          .toSet() // Removes duplicates if multiple tags share a responsibility
          .toList()
          .take(6) // Keeps the job post concise
          .toList();
      final job = Job(
        createdAt: TemporalDateTime(faker.date.dateTime()),
        code: nanoid(10),
        title: title,
        location: location,
        salary: faker.randomGenerator.integer(700, min: 500),
        currency: currency,
        payPeriod: faker.randomGenerator.element([
          'Monthly',
          'Bi-weekly',
          'Weekly',
          'Daily',
          'Hourly',
          'Per Task',
        ]),
        familyMembers: familyMembers,
        childCount: childCount,
        adultCount: adultCount,
        childAges: childAges,
        elderlyCount: elderlyCount,
        homeType: homeType,
        roomType: faker.randomGenerator.element(roomTypeOptions),
        requiredSkills: requiredSkills,
        note: generateJobNote(homeType, childAges, selectedTags),
        accommodation: faker.randomGenerator.element(accommodationOptions),
        offdays: faker.randomGenerator.element(offDayOptions),
        tags: selectedTags,
        requiredPersonalityType: faker.randomGenerator.element(
          personalityTypes,
        ),
        status: JobStatus.APPROVE,
        jobType: jobType,
        startDate: startDate,
        contract: contract,
        responsibilities: finalResponsibilities,
        isActive: faker.randomGenerator.element([true, false]),
        creator: employer,
      );
      final request = ModelMutations.create(job);
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        jobs.add(job);
      }
    }
  }

  Future<void> _seedAppliedJobs() async {
    for (var i = 0; i < 50; i++) {
      final helper = faker.randomGenerator.element(helpers);
      final job = faker.randomGenerator.element(jobs);
      final status = faker.randomGenerator.element([
        ApplicationStatus.ACCEPTED,
        ApplicationStatus.PENDING,
      ]);
      final adminActionStatus = faker.randomGenerator.element([
        AdminActionStatus.PENDING,
        AdminActionStatus.APPROVED,
        AdminActionStatus.REJECTED,
      ]);

      final request = ModelMutations.create(
        AppliedJob(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          status: status,
          adminActionStatus: adminActionStatus,
          updatedBy: adminActionStatus != AdminActionStatus.PENDING
              ? UserRole.ADMIN
              : status == ApplicationStatus.PENDING
              ? UserRole.HELPER
              : UserRole.EMPLOYER,
          job: job,
          helper: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedInterviews() async {
    for (var i = 0; i < 50; i++) {
      final helper = faker.randomGenerator.element(helpers);
      final job = faker.randomGenerator.element(jobs);
      final interviewStatus = faker.randomGenerator.element([
        InterviewStatus.PENDING,
        InterviewStatus.ACCEPTED,
        InterviewStatus.CANCELLED,
        InterviewStatus.COMPLETED,
        InterviewStatus.NO_SHOW,
      ]);
      final List<TemporalDateTime> interviewDateOptions = [
        nextWeekDateTime(),
        nextWeekDateTime(),
        nextWeekDateTime(),
      ];

      final TemporalDateTime? confirmedDateTime =
          interviewStatus != InterviewStatus.PENDING
          ? interviewDateOptions[0]
          : null;
      final interview = Interview(
        createdAt: TemporalDateTime(faker.date.dateTime()),
        code: nanoid(10),
        interviewDateOptions: interviewDateOptions,
        confirmedDateTime: confirmedDateTime,
        status: interviewStatus,
        updatedBy: faker.randomGenerator.element([
          UserRole.HELPER,
          UserRole.EMPLOYER,
          UserRole.ADMIN,
        ]),

        job: job,
        helper: helper,
        employer: job.creator,
      );
      final request = ModelMutations.create(
        interview,
      );
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        interviews.add(interview);
      }
    }
  }

  Future<void> _seedSavedJobs() async {
    for (var i = 0; i < 50; i++) {
      final helper = faker.randomGenerator.element(helpers);
      final job = jobs[i];

      final request = ModelMutations.create(
        SavedJob(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          user: helper,
          job: job,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedJobOffers() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];
      final job = faker.randomGenerator.element(jobs);
      final status = faker.randomGenerator.element([
        ApplicationStatus.PENDING,
        ApplicationStatus.ACCEPTED,
        ApplicationStatus.REJECTED,
      ]);
      final adminStatus = faker.randomGenerator.element([
        AdminActionStatus.PENDING,
        AdminActionStatus.APPROVED,
        AdminActionStatus.REJECTED,
      ]);
      final userRole = adminStatus != AdminActionStatus.PENDING
          ? UserRole.ADMIN
          : status == ApplicationStatus.PENDING
          ? UserRole.HELPER
          : UserRole.EMPLOYER;
      final request = ModelMutations.create(
        JobOffer(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          status: status,
          adminActionStatus: adminStatus,
          updatedBy: userRole,
          job: job,
          helper: helper,
          employer: job.creator,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedHireJobs() async {
    for (var i = 0; i < 10; i++) {
      final helper = helpers[i];
      final job = jobs[i];
      final status = faker.randomGenerator.element([
        HiredJobStatus.PENDING,
        HiredJobStatus.ACTIVE,
      ]);
      final adminStatus = faker.randomGenerator.element([
        AdminActionStatus.PENDING,
        AdminActionStatus.APPROVED,
        AdminActionStatus.REJECTED,
      ]);
      final startDate = hiredJobStartDate();
      final endDate = startDate.add(
        Duration(days: job.jobType!.contains('Full-Time') ? 365 * 2 : 365),
      );
      final hiredJob = HiredJob(
        createdAt: TemporalDateTime(faker.date.dateTime()),
        code: nanoid(10),
        status: status,
        adminActionStatus: adminStatus,
        updatedBy: adminStatus == AdminActionStatus.PENDING
            ? UserRole.EMPLOYER
            : UserRole.ADMIN,
        startDate: TemporalDateTime(startDate),
        endDate: TemporalDateTime(endDate),
        job: job,
        helper: helper,
        employer: job.creator,
      );
      final request = ModelMutations.create(hiredJob);
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        hiredJobs.add(hiredJob);
      }
    }
  }

  Future<void> _seedSavedHelpers() async {
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];
      final employer = faker.randomGenerator.element(employers);

      final request = ModelMutations.create(
        SavedHelper(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          employer: employer,
          helper: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedViewHelpers() async {
    for (var i = 0; i < 50; i++) {
      final helper = faker.randomGenerator.element(helpers);
      final employer = faker.randomGenerator.element(employers);

      final request = ModelMutations.create(
        ViewHelper(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          employer: employer,
          helper: helper,
        ),
      );
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedUserChatRooms() async {
    for (var i = 0; i < 20; i++) {
      final helper = helpers[i];
      final employer = employers[i];
      final chatRoom = ChatRoom(
        createdAt: TemporalDateTime(
          faker.date.dateTime(minYear: 2025, maxYear: 2026),
        ),
        name: "${helper.code}-${employer.code}",
        userA: helper,
        userB: employer,
      );
      final request = ModelMutations.create(chatRoom);
      final response = await Amplify.API.mutate(request: request).response;
      if (!(response.data == null)) {
        userChatRooms.add(chatRoom);
      }
    }
  }

  Future<void> _seedUserChatMessages() async {
    for (var cr in userChatRooms) {
      final userA = cr.userA;
      final userB = cr.userB;
      for (var i = 0; i < 5; i++) {
        final isATheSender = faker.randomGenerator.boolean();
        final sender = isATheSender ? userA : userB;
        final receiver = isATheSender ? userB : userA;

        final message = ChatMessage(
          createdAt: TemporalDateTime(
            faker.date.dateTimeBetween(DateTime(2025, 9), DateTime(2026, 1)),
          ),
          content: jsonEncode({"text": faker.lorem.sentence()}),
          status: faker.randomGenerator.element([
            //ChatStatus.PENDING,
            ChatStatus.RECEIVED,
            ChatStatus.SEEN,
            //ChatStatus.SENT,
            //ChatStatus.TYPING,
          ]),
          chatRoom: cr,
          sender: sender,
          receiver: receiver,
        );

        final request = ModelMutations.create(message);
        await Amplify.API.mutate(request: request).response;
      }
    }
  }

  Future<void> _seedUrgentActions() async {
    for (var hiredJob in hiredJobs) {
      // Pick a random urgent issue
      final sample = faker.randomGenerator.element(urgentIssueSamples);

      final urgentAction = UrgentAction(
        issue: sample['issue']!,
        deadline: sample['deadline'],
        status: faker.randomGenerator.element([
          UrgentActionStatus.PENDING,
          UrgentActionStatus.RESOLVE,
        ]),
        // Linking the relationship IDs
        helper: hiredJob.helper,
        employer: hiredJob.employer,
        hiredJob: hiredJob,

        // AWSJSON field for extra metadata
        custonFields: jsonEncode({
          "priority": faker.randomGenerator.element(["High", "Critical"]),
          "assignedTo": "Agency Admin",
          "notes": "Action required to avoid MOM penalties.",
        }),

        createdAt: TemporalDateTime(DateTime.now()),
        updatedAt: TemporalDateTime(DateTime.now()),
      );

      final request = ModelMutations.create(urgentAction);
      await Amplify.API.mutate(request: request).response;
    }
  }

  Future<void> _seedReviews() async {
    if (hiredJobs.isEmpty) {
      print("No hired jobs found to review.");
      return;
    }

    for (var hiredJob in hiredJobs) {
      // We only create a review for about 70% of jobs to make it look natural
      if (faker.randomGenerator.boolean()) {
        final sample = faker.randomGenerator.element(helperToEmployerReviews);

        final review = Review(
          review: sample['comment'] as String,
          rating: sample['rating'] as double,
          // Review By: Helper
          reviewedBy: hiredJob.helper,
          // Review To: Employer
          reviewedTo: hiredJob.employer,
          createdAt: TemporalDateTime(
            faker.date.dateTimeBetween(DateTime(2025, 6), DateTime(2026)),
          ),
          updatedAt: TemporalDateTime(DateTime.now()),
        );

        final request = ModelMutations.create(review);
        await Amplify.API.mutate(request: request).response;
      }
    }
  }

  Future<void> _seedTrainingRecords() async {
    if (helpers.isEmpty) {
      print("No helpers found. Seed Users first.");
      return;
    }

    for (var helper in helpers) {
      if (!(helper.verifyStatus == VerifyStatus.VERIFIED)) {
        continue;
      }
      // Pick a random number of modules completed by this helper
      // ignore: inference_failure_on_instance_creation
      final modulesToSeed = (List.from(
        trainingModules,
      )..shuffle()).take(faker.randomGenerator.integer(4, min: 2));

      for (var moduleName in modulesToSeed) {
        final trainingRecord = TrainingRecord(
          moduleName: moduleName as String,
          score: faker.randomGenerator.integer(100, min: 65),
          helper: helper,
          createdAt: TemporalDateTime(
            faker.date.dateTimeBetween(DateTime(2025, 1), DateTime(2025, 12)),
          ),
          updatedAt: TemporalDateTime(DateTime.now()),
        );

        final request = ModelMutations.create(trainingRecord);
        final response = await Amplify.API.mutate(request: request).response;

        if (response.data != null) {
          print("Seeded Training: $moduleName for Helper ${helper.fullName}");
        }
      }
    }
  }

  Future<void> _seedWallets() async {
    final employerList = await Amplify.API
        .query(
          request: ModelQueries.list(
            User.classType,
            where: User.ROLE.eq(UserRole.EMPLOYER),
          ),
        )
        .response;
    if (employerList.data?.items.isEmpty == true) {
      print("Employers is empyt");
      return;
    }
    employers = employerList.data!.items.whereType<User>().toList();

    //hire jobs
    final hireJobsList = await Amplify.API
        .query(
          request: ModelQueries.list(
            HiredJob.classType,
          ),
        )
        .response;
    if (hireJobsList.data?.items.isEmpty == true) {
      print("Hired jobs is empty");
      return;
    }
    hiredJobs = hireJobsList.data!.items.whereType<HiredJob>().toList();

    if (employers.isEmpty) {
      print("No employers found. Seed Users first.");
      return;
    }
    if (hiredJobs.isEmpty) {
      print("No hired jobs found.Seed hiredjobs first");
      return;
    }
    for (var employer in employers) {
      if (employer.id.isEmpty) {
        print("CRITICAL ERROR: Employer ${employer.fullName} has a NULL ID.");
        continue;
      }
      print("EMPLOYER ID: ${employer.id}");
      // Generate a random balance for testing
      // Some employers have 0, some have funds
      final balance = faker.randomGenerator.boolean()
          ? faker.randomGenerator.decimal(min: 50, scale: 500)
          : 0.0;

      final wallet = Wallet(
        outstanding_balance: balance,
        // The Primary Relationship
        employer: employer,
        createdAt: TemporalDateTime(DateTime.now()),
        updatedAt: TemporalDateTime(DateTime.now()),
      );

      final request = ModelMutations.create(wallet);
      final response = await Amplify.API.mutate(request: request).response;
      if (response.hasErrors) {
        print("ERROR: ${response.errors}");
        return;
      }
      if (response.data != null) {
        print(
          "Seeded Wallet for Employer: ${employer.fullName} | Balance: \$${balance.toStringAsFixed(2)}",
        );
        employerWallets.add(wallet);
      }
    }
  }

  Future<void> _seedTransactions() async {
    if (employerWallets.isEmpty) {
      print("No wallets found. Seed Wallets first.");
      return;
    }

    for (var wallet in employerWallets) {
      final employer = wallet.employer;
      // Find a Helper related to this Employer (via HiredJobs)
      // If no hired job exists, we skip or pick a random helper for testing
      final relatedJob = hiredJobs.firstWhere(
        (j) => j.employer?.id == employer?.id,
        orElse: () => hiredJobs.first,
      );
      final helper = relatedJob.helper;

      for (int i = 0; i < 3; i++) {
        final type = faker.randomGenerator.element(transactionTypes);
        final amount = faker.randomGenerator.decimal(
          min: type['min'] as double,
          scale: (type['max'] as double) - (type['min'] as double),
        );

        final transaction = Transaction(
          code:
              "${type['code_prefix']}-${faker.randomGenerator.integer(99999)}",
          amount: amount,
          currency: relatedJob.job?.currency,
          status: faker.randomGenerator.element([
            TransactionStatus.PENDING,
            TransactionStatus.PAID,
            TransactionStatus.FAILED,
            //TransactionStatus.OVERDUE,
            //TransactionStatus.REFUND_PROCESSING,
          ]),
          actionBy: UserRole.EMPLOYER,
          wallet: wallet,
          transferBy: employer,
          transferTo: helper,
          createdAt: TemporalDateTime(
            faker.date.dateTimeBetween(DateTime(2025, 10), DateTime(2026, 1)),
          ),
          updatedAt: TemporalDateTime(DateTime.now()),
        );

        final request = ModelMutations.create(transaction);
        final response = await Amplify.API.mutate(request: request).response;

        if (response.data != null) {
          print(
            "Seeded ${type['desc']} of \$${amount.toStringAsFixed(2)} for ${employer?.fullName}",
          );
          transactions.add(transaction);
        }
      }
    }
  }

  Future<void> _seedInvoices() async {
    if (transactions.isEmpty) {
      print("No transactions found. Seed Transactions first.");
      return;
    }

    for (var tx in transactions) {
      if (tx.status == TransactionStatus.FAILED) {
        continue;
      }

      final invoice = Invoice(
        code: tx.code.replaceFirst(RegExp(r'^[A-Z]{3}'), 'INV'),
        amount: tx.amount,
        status: tx.status,
        actionBy: tx.actionBy,
        transaction: tx,
        createdAt: tx.createdAt,
        updatedAt: TemporalDateTime(DateTime.now()),
      );

      final request = ModelMutations.create(invoice);
      final response = await Amplify.API.mutate(request: request).response;

      if (response.data != null) {
        print("Seeded Invoice: ${invoice.code} for amount \$${invoice.amount}");
      }
    }
  }

  Future<void> _seedFinancialAlerts() async {
    if (transactions.isEmpty) {
      print("No transactions found. Seed Transactions first.");
      return;
    }

    for (var tx in transactions) {
      String title = "";
      String description = "";

      if (tx.status == TransactionStatus.PAID) {
        title = "Payment Successful";
        description =
            "Your payment of \$${tx.amount.toStringAsFixed(2)} for ${tx.code} has been processed successfully.";
      } else if (tx.status == TransactionStatus.FAILED) {
        title = "Payment Failed";
        description =
            "The transaction ${tx.code} failed. Please check your wallet balance or payment method.";
      } else {
        title = "Transaction Pending";
        description = "Your payment ${tx.code} is currently being processed.";
      }

      final alert = FinancialAlert(
        title: title,
        description: description,
        transaction: tx,
        wallet: tx.wallet,
        createdAt: TemporalDateTime(DateTime.now()),
        updatedAt: TemporalDateTime(DateTime.now()),
      );

      final request = ModelMutations.create(alert);
      final response = await Amplify.API.mutate(request: request).response;
      if (response.data != null) {
        print(
          "Seeded Financial Alert: ${alert.title} for Transaction ${tx.code}",
        );
      }
    }
  }

   Future<void> _seedConversationReports() async {
    if (interviews.isEmpty) return;

    for (var interview in interviews) {
      if (interview.confirmedDateTime == null) {
        continue;
      }
      print("Seeding 30 messages for Interview: ${interview.id}");

      for (int i = 0; i < 30; i++) {
        final template = faker.randomGenerator.element(translationTemplates);
        bool isEmployerSender = i % 2 == 0;
        final sender = isEmployerSender ? interview.employer : interview.helper;
        final receiver = isEmployerSender
            ? interview.helper
            : interview.employer;
        final contentJson = isEmployerSender
            ? {"original": template['en'], "translated": template['mm']}
            : {"original": template['mm'], "translated": template['en']};

        final report = ConversationReport(
          interview: interview,
          sender: sender,
          receiver: receiver,
          content: jsonEncode(contentJson),
          createdAt: TemporalDateTime(
            interview.confirmedDateTime!.getDateTimeInUtc().add(
              Duration(minutes: i),
            ),
          ),
          updatedAt: TemporalDateTime(DateTime.now()),
        );

        final request = ModelMutations.create(report);
        await Amplify.API.mutate(request: request).response;
      }
    }
  }

  Future<void> _seedAdminRecentActions() async {
    for (int i = 0; i < 50; i++) {
      final template = faker.randomGenerator.element(adminActionTemplates);

      // Randomly pick a helper or employer name to inject into the description
      final randomHelper =
          helpers[faker.randomGenerator.integer(helpers.length)];
      final randomEmployer =
          employers[faker.randomGenerator.integer(employers.length)];

      // Dynamic description replacement
      String finalDesc = template['desc']!
          .replaceAll('{name}', randomHelper.fullName)
          .replaceAll('{employer}', randomEmployer.fullName)
          .replaceAll('{id}', faker.randomGenerator.integer(9999).toString());

      final action = RecentAction(
        title: template['title']!,
        description: finalDesc,
        user: admin,
        createdAt: TemporalDateTime(
          DateTime.now().subtract(Duration(hours: i * 3)),
        ),
        updatedAt: TemporalDateTime(DateTime.now()),
      );

      final request = ModelMutations.create(action);
      await Amplify.API.mutate(request: request).response;
    }

    print("Seeded 50 Admin Recent Actions.");
  }
 */

  Future<void> _seedOtherPersonalInfos() async {
    final helpersList = await Amplify.API
        .query(
          request: ModelQueries.list(
            User.classType,
            where: User.ROLE.eq(UserRole.HELPER),
          ),
        )
        .response;
    if (helpersList.data?.items.isEmpty == true) {
      print("Helpers is empyt");
      return;
    }
    final helpers = helpersList.data!.items;
    for (var i = 0; i < 50; i++) {
      final helper = helpers[i];

      final request = ModelMutations.create(
        OtherPersonalInfo(
          createdAt: TemporalDateTime(faker.date.dateTime()),
          code: nanoid(10),
          foodPreferences: faker.randomGenerator.element([
            [
              'Can handle pork',
              'Can handle beef',
              'Vegetarian cooking only',
              'Comfortable with spicy food',
              'Halal food preparation',
              'Chinese cuisine',
              'Western cuisine',
              'No restrictions on food handling',
            ],
            [],
          ]),
          accommodationPreferences: faker.randomGenerator.element([
            [
              'Own room preferred',
              'Sharing room is okay',
              'Stay-in only',
              'No pets in the house',
              'Comfortable with dogs',
              'Comfortable with cats',
              'Urban area preferred',
            ],
            [],
          ]),
          languagesSpoken: faker.randomGenerator.element([
            [
              'English (Basic)',
              'English (Fluent)',
              'Mandarin (Basic)',
              'Mandarin (Fluent)',
              'Burmese (Native)',
              'Malay (Basic)',
              'Tamil (Basic)',
              'Cantonese',
              'Hokkien',
            ],
            [],
          ]),
          user: helper,
        ),
      );
      final response = await Amplify.API.mutate(request: request).response;
      if (response.hasErrors) {
        print("Error: ${response.errors}");
        return;
      }
      print("Seed: ${response.data?.code}");
    }
  }

  Future<void> _seedAdminSupportSystems() async {
    final employerList = await Amplify.API
        .query(
          request: ModelQueries.list(
            User.classType,
            where: User.ROLE.eq(UserRole.EMPLOYER),
          ),
        )
        .response;
    if (employerList.data?.items.isEmpty == true) {
      print("Employers is empyt");
      return;
    }
    final helpersList = await Amplify.API
        .query(
          request: ModelQueries.list(
            User.classType,
            where: User.ROLE.eq(UserRole.HELPER),
          ),
        )
        .response;
    if (helpersList.data?.items.isEmpty == true) {
      print("Helpers is empyt");
      return;
    }
    final hiredJobsList = await Amplify.API
        .query(
          request: ModelQueries.list(
            HiredJob.classType,
          ),
        )
        .response;
    if (hiredJobsList.data?.items.isEmpty == true) {
      print("HiredJobs is empyt");
      return;
    }
    final transactionsList = await Amplify.API
        .query(
          request: ModelQueries.list(
            Transaction.classType,
          ),
        )
        .response;
    if (transactionsList.data?.items.isEmpty == true) {
      print("Transactions list is empyt");
      return;
    }
    final adminList = await Amplify.API
        .query(
          request: ModelQueries.get(
            User.classType,
            UserModelIdentifier(id: "0450c45a-6c94-4cc8-97ed-03c9227285db"),
          ),
        )
        .response;
    if (adminList.data == null) {
      print("Admin list is empyt");
      return;
    }
    final admin = adminList.data!;
    final transactions = transactionsList.data!.items
        .whereType<Transaction>()
        .toList();
    final hiredJobs = hiredJobsList.data!.items.whereType<HiredJob>().toList();
    final helpers = helpersList.data!.items.whereType<User>().toList();
    final employers = employerList.data!.items.whereType<User>().toList();
    for (var i = 0; i < 20; i++) {
      final helper = helpers[faker.randomGenerator.integer(helpers.length)];
      final employer =
          employers[faker.randomGenerator.integer(employers.length)];
      final reportingUser = faker.randomGenerator.boolean() ? helper : employer;

      final scenario = faker.randomGenerator.element(supportScenarios);
      final subject = faker.randomGenerator.element(
        scenario['subjects'] as List<String>,
      );
      final desc = faker.randomGenerator.element(
        scenario['descriptions'] as List<String>,
      );

      // 2. Determine the Related ID based on the Type
      String relatedId = "GENERAL_ENQUIRY";
      if (scenario['type'] == RelatedModelType.HIRED_JOB &&
          hiredJobs.isNotEmpty) {
        relatedId =
            hiredJobs[faker.randomGenerator.integer(hiredJobs.length)].id;
      } else if (scenario['type'] == RelatedModelType.TRANSACTION &&
          transactions.isNotEmpty) {
        relatedId =
            transactions[faker.randomGenerator.integer(transactions.length)].id;
      }
      final ticket = SupportTicket(
        subject: "$subject (${reportingUser.fullName})",
        description: desc,
        status: faker.randomGenerator.element(TicketStatus.values),
        user: reportingUser,
        relatedModelType: scenario['type'] as RelatedModelType,
        relatedModelID: relatedId,
        createdAt: TemporalDateTime(DateTime.now()),
      );

      final ticketResponse = await Amplify.API
          .mutate(request: ModelMutations.create(ticket))
          .response;
      final createdTicket = ticketResponse.data;
      if (ticketResponse.hasErrors) {
        print("Error ticket: ${ticketResponse.errors}");
        return;
      }

      if (createdTicket != null) {
        final chatRoom = ChatRoom(
          name: "Support: ${subject.split(' ').first} #${i + 100}",
          supportTicket: createdTicket,
          userA: admin,
          userB: reportingUser, // Helper or Employer
          createdAt: TemporalDateTime(DateTime.now()),
        );

        final roomResponse = await Amplify.API
            .mutate(request: ModelMutations.create(chatRoom))
            .response;
        if (roomResponse.hasErrors) {
          print("Error: ${roomResponse.errors}");
          return;
        }
        final createdRoom = roomResponse.data;

        if (createdRoom != null) {
          // 3. Seed 30+ Messages for this specific room
          await _seedAdminSupportMessagesForRoom(
            createdRoom,
            admin!,
            reportingUser,
          );
        }
      }
    }
  }

  Future<void> _seedAdminSupportMessagesForRoom(
    ChatRoom room,
    User adminUser,
    User otherUser,
  ) async {
    for (var i = 0; i < 30; i++) {
      final isAdminSender = i % 2 == 0;
      final sender = isAdminSender ? adminUser : otherUser;
      final receiver = isAdminSender ? otherUser : adminUser;
      final content = jsonEncode({"text": faker.lorem.sentence()});

      final message = ChatMessage(
        content: content,
        status: i < 25 ? ChatStatus.SEEN : ChatStatus.RECEIVED,
        chatRoom: room,
        sender: sender,
        receiver: receiver,
        createdAt: TemporalDateTime(
          DateTime.now().subtract(Duration(days: 1, minutes: 60 - i)),
        ),
      );

      await Amplify.API
          .mutate(request: ModelMutations.create(message))
          .response;
    }
  }
}
