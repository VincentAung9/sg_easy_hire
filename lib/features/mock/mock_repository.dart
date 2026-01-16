import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class MockRepository {
  Future<void> likeHelper(String helperID) async {
    debugPrint("🌈 Liking Helper request....");
    await Amplify.API
        .mutate(
          request: ModelMutations.create(
            SavedHelper(
              createdAt: TemporalDateTime(DateTime.now()),
              helper: User(
                id: helperID,
                code: "",
                fullName: "",
                role: UserRole.HELPER,
                completeProgress: 0,
              ),
              employer: User(
                id: "e3177aff-a44f-43ad-8266-ace65f620dda",
                code: "",
                fullName: "",
                role: UserRole.HELPER,
                completeProgress: 0,
              ),
            ),
          ),
        )
        .response;
    debugPrint("🌈 Done Liking Helper request....");
  }

  Future<void> updateHelperVerifyStatus(
    String helperID,
    VerifyStatus status,
  ) async {
    debugPrint("🌈 Updating Helper Verify Status....");
    final response = await Amplify.API
        .query(
          request: ModelQueries.get(
            User.classType,
            UserModelIdentifier(id: helperID),
          ),
        )
        .response;
    final helper = response.data!;
    await Amplify.API
        .mutate(
          request: ModelMutations.update(
            helper.copyWith(
              updatedBy: UserRole.ADMIN,
              verifyStatus: status,
            ),
          ),
        )
        .response;
    debugPrint("🌈 Done Updating Helper Verify Status....");
  }

  Future<void> sendInterviewRequest(String helperID) async {
    debugPrint("🌈 Sending interview request....");
    await Amplify.API
        .mutate(
          request: ModelMutations.create(
            Interview(
              code: nanoid(10),
              status: InterviewStatus.PENDING,
              createdAt: TemporalDateTime(DateTime.now()),
              interviewDateOptions: [
                TemporalDateTime(DateTime(2026, 1, 16, 18)),
                TemporalDateTime(DateTime(2026, 1, 17, 18)),
                TemporalDateTime(DateTime(2026, 1, 15, 18)),
              ],
              updatedBy: UserRole.EMPLOYER,
              job: Job(
                code: "",
                title: "",
                location: "",
                salary: 0,
                status: JobStatus.APPROVE,
                id: "42a01576-b60f-4802-8719-a77f3b404db4",
              ),
              helper: User(
                id: helperID,
                code: "",
                fullName: "",
                role: UserRole.HELPER,
                completeProgress: 0,
              ),
              employer: User(
                id: "e3177aff-a44f-43ad-8266-ace65f620dda",
                code: "",
                fullName: "",
                role: UserRole.HELPER,
                completeProgress: 0,
              ),
            ),
          ),
        )
        .response;
    debugPrint("🌈 Done Sending interview request....");
  }

  Future<void> sendJobOffers(String helperID) async {
    debugPrint("🌈 Sending job offers....");
    final jobOffer = JobOffer(
      code: nanoid(),
      status: ApplicationStatus.PENDING,
      adminActionStatus: AdminActionStatus.PENDING,
      createdAt: TemporalDateTime(DateTime.now()),
      updatedBy: UserRole.EMPLOYER,
      job: Job(
        id: "42a01576-b60f-4802-8719-a77f3b404db4",
        code: "",
        title: "",
        location: "",
        salary: 0,
        status: JobStatus.PENDING,
      ),
      helper: User(
        id: helperID,
        code: "",
        fullName: "",
        role: UserRole.HELPER,
        completeProgress: 0,
      ),
      employer: User(
        id: "e3177aff-a44f-43ad-8266-ace65f620dda",
        code: "",
        fullName: "",
        role: UserRole.HELPER,
        completeProgress: 0,
      ),
    );
    await Amplify.API.mutate(request: ModelMutations.create(jobOffer)).response;
    debugPrint("🌈 Done Sending job offers....");
  }

  static final List<String> jobTagPool = [
    "Cleaner",
    "Maid",
    "Housekeeper",
    "Helper",
    "Babysitter",
    "Nanny",
    "Caregiver",
    "Elder Care",
    "Child Care",
    "Cook",
    "Private Chef",
    "Nurse Aid",
    "Care Assistant",
  ];

  static final List<String> skillsPool = [
    "Cleaning",
    "Cooking",
    "Baby Care",
    "Elderly Care",
    "Ironing",
    "Pet Care",
    "Grocery Shopping",
    "Gardening",
    "Car Wash",
    "Tutoring",
  ];

  static final List<String> locationPool = [
    "Orchard Road",
    "Bukit Timah",
    "Sentosa Cove",
    "Tampines",
    "Jurong East",
    "Woodlands",
    "Ang Mo Kio",
    "Bedok",
    "Punggol",
    "Sengkang",
    "Yishun",
    "Pasir Ris",
    "Choa Chu Kang",
    "Novena",
    "Newton",
    "Marine Parade",
    "Toa Payoh",
    "Clementi",
    "Hougang",
    "River Valley",
  ];
  static final List<String> homeTypes = ["Condo", "HDB", "Landed", "Penthouse"];
  static final List<String> roomTypes = [
    "Private Room",
    "Shared Room",
    "Partition Room",
  ];
  static final List<String> accommodationPool = ["Live-in", "Live-out"];
  static final List<String> offDaysPool = [
    "1 day/week",
    "2 days/month",
    "All Sundays off",
    "Flexible",
  ];

  Future<void> seedMockData(User currentHelper) async {
    final random = Random();
    try {
      safePrint("🚀 Starting Seed with all variables restored...");

      // 1. Create Mock Employer with ALL your original variables
      User mockEmployer = User(
        code: nanoid(10),
        fullName: "Global Agencies Ltd",
        email: "recruiter@example.sg",
        phone: "+65 8888 9999",
        role: UserRole.EMPLOYER,
        verifyStatus: VerifyStatus.VERIFIED,
        accountstatus: AccountStatus.ACTIVATED,
        completeProgress: 100,
        personalityType: "Managerial",
        nationality: "Singaporean",
        // The one we just added
        createdAt: TemporalDateTime(
          DateTime.now().subtract(const Duration(days: 10)),
        ),
      );
      await Amplify.DataStore.save(mockEmployer);

      List<Job> createdJobs = [];

      // 2. Generate 20 Jobs
      for (int i = 0; i < 20; i++) {
        List<String> shufflableTags = List.from(jobTagPool);
        shufflableTags.shuffle();
        List<String> selectedTags = shufflableTags.take(2).toList();
        List<String> shufflableSkills = List.from(skillsPool)..shuffle();
        List<String> selectedSkills = shufflableSkills.take(3).toList();
        List<String> shufflableLocations = List.from(locationPool)..shuffle();
        String selectedLocation = shufflableLocations.first;

        // Random Family Composition
        int cCount = random.nextInt(4); // 0 to 3 children
        int aCount = random.nextInt(3) + 1; // 1 to 3 adults
        int eCount = random.nextInt(2); // 0 or 1 elderly

        // Generate dynamic ages string if children exist
        String cAges = cCount > 0
            ? List.generate(
                    cCount,
                    (_) => "${random.nextInt(12) + 1}",
                  ).join(" and ") +
                  " years old"
            : "No children";

        String selectedHome = homeTypes[random.nextInt(homeTypes.length)];

        Job newJob = Job(
          code: nanoid(10),
          title: "${selectedTags.first} needed for ${i + 2} kids",
          creator: mockEmployer,
          location: selectedLocation,
          salary: 600 + (i * 25),
          currency: "SGD",
          payPeriod: "month",
          familyMembers: cCount + aCount + eCount,
          status: JobStatus.APPROVE,
          childCount: cCount,
          adultCount: aCount,
          childAges: cAges,
          elderlyCount: eCount,
          homeType: selectedHome,
          tags: selectedTags,
          requiredSkills: selectedSkills,
          roomType: roomTypes[random.nextInt(roomTypes.length)],
          accommodation:
              accommodationPool[random.nextInt(accommodationPool.length)],
          offdays: offDaysPool[random.nextInt(offDaysPool.length)],
          note:
              "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          createdAt: TemporalDateTime(
            DateTime.now().subtract(Duration(hours: i)),
          ),
        );

        await Amplify.DataStore.save(newJob);
        createdJobs.add(newJob);
      }

      // 3. Generate 20 Interviews
      final List<InterviewStatus> statuses = InterviewStatus.values;

      for (int i = 0; i < 20; i++) {
        Interview newInterview = Interview(
          code: nanoid(10),
          job: createdJobs[i],
          helper: currentHelper,
          employer: mockEmployer,
          status: statuses[i % statuses.length],
          interviewDateOptions: [
            TemporalDateTime(DateTime.now().add(Duration(days: i + 1))),
          ],
          updatedBy: UserRole.EMPLOYER,
          createdAt: TemporalDateTime(
            DateTime.now().subtract(Duration(minutes: i * 20)),
          ),
        );

        await Amplify.DataStore.save(newInterview);
      }

      safePrint("✅ Done. All variables restored and createdAt added.");
    } catch (e) {
      safePrint("❌ Seed error: $e");
    }
  }
}
