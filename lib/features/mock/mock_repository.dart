import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sg_easy_hire/models/ContactFamilyDetails.dart';
import 'package:sg_easy_hire/models/JobPreferences.dart';
import 'package:sg_easy_hire/models/MedicalHistory.dart';
import 'package:sg_easy_hire/models/OtherPersonalInformations.dart';
import 'package:sg_easy_hire/models/PersonalInformation.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

/* class MockRepository {
  static Future<void> seedMockData() async {
    try {
      // USERS
      final employer = await _createEmployer();
      final helper = await _createHelper();

      // HELPER RELATED DATA
      await _createHelperProfile(helper);
      await _createWorkHistory(helper);

      // JOB
      final job = await _createJob(employer);

      // APPLICATION
      final appliedJob = await _applyJob(helper, job);

      // INTERVIEW
      await _createInterview(employer, helper, job);

      // JOB OFFER
      await _createJobOffer(employer, helper, job);

      // SAVED & VIEW
      await _saveJob(helper, job);
      await _saveHelper(employer, helper);
      await _viewHelper(employer, helper);

      // NOTIFICATION
      await _createNotification(helper);

      safePrint('✅ Mock data seeded successfully');
    } catch (e) {
      safePrint('❌ Seed error: $e');
    }
  }

  Future<User> _createEmployer() async {
    final user = User(
      cognitoId: 'employer-001',
      fullName: 'John Employer',
      role: UserRole.EMPLOYER,
      isActive: true,
    );

    await Amplify.DataStore.save(user);
    return user;
  }

  Future<User> _createHelper() async {
    final user = User(
      cognitoId: 'helper-001',
      fullName: 'Mary Helper',
      role: UserRole.HELPER,
      isActive: true,
    );

    await Amplify.DataStore.save(user);
    return user;
  }

  Future<void> _createHelperProfile(User helper) async {
  await Amplify.DataStore.save(
    PersonalInformation(
      fullName: helper.fullName!,
      dateOfBirth: '1998-05-01',
      placeOfBirth: 'Myanmar',
      nationality: 'Myanmar',
      gender: 'Female',
      height: '160cm',
      weight: '50kg',
      userID: helper.id,
    ),
  );

  await Amplify.DataStore.save(
    ContactFamilyDetails(
      residentialAddress: 'Yangon',
      contactNumber: '0912345678',
      portAriport: 'Yangon Airport',
      religion: 'Buddhist',
      educationLevel: 'High School',
      numberOfSiblings: '2',
      martialStatus: 'Single',
      userID: helper.id,
    ),
  );

  await Amplify.DataStore.save(
    MedicalHistory(
      anyAllergies: 'None',
      dietaryRestrictions: 'Halal',
      userID: helper.id,
    ),
  );

  await Amplify.DataStore.save(
    OtherPersonalInformations(
      foodPreferences: ['Asian'],
      languagesSpoken: ['English', 'Burmese'],
      userID: helper.id,
    ),
  );

  await Amplify.DataStore.save(
    JobPreferences(
      experience: '2 years',
      skills: ['Cleaning', 'Cooking'],
      expectedMonthlySalary: '600',
      preferredOffDaysPerMonth: '4',
      willingWorkOnRestDays: true,
      userID: helper.id,
    ),
  );

  await Amplify.DataStore.save(
    UploadedDocuments(
      profilePhoto: 'profile.jpg',
      passport: 'passport.pdf',
      userID: helper.id,
    ),
  );
}

}
 */
