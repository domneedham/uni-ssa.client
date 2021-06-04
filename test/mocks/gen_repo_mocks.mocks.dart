// Mocks generated by Mockito 5.0.9 from annotations
// in ssa_app/test/mocks/gen_repo_mocks.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:ssa_app/app/data/models/skill/staff_skill.dart' as _i4;
import 'package:ssa_app/app/data/models/user/staff.dart' as _i3;
import 'package:ssa_app/app/data/models/user/user.dart' as _i2;
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart' as _i6;
import 'package:ssa_app/app/data/repository/user_repository.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUser extends _i1.Fake implements _i2.User {}

class _FakeStaff extends _i1.Fake implements _i3.Staff {}

class _FakeStaffSkill extends _i1.Fake implements _i4.StaffSkill {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i5.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.User get user =>
      (super.noSuchMethod(Invocation.getter(#user), returnValue: _FakeUser())
          as _i2.User);
  @override
  _i3.Staff get staff =>
      (super.noSuchMethod(Invocation.getter(#staff), returnValue: _FakeStaff())
          as _i3.Staff);
}

/// A class which mocks [SkillRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSkillRepository extends _i1.Mock implements _i6.SkillRepository {
  MockSkillRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.StaffSkill get skillOne =>
      (super.noSuchMethod(Invocation.getter(#skillOne),
          returnValue: _FakeStaffSkill()) as _i4.StaffSkill);
  @override
  _i4.StaffSkill get skillTwo =>
      (super.noSuchMethod(Invocation.getter(#skillTwo),
          returnValue: _FakeStaffSkill()) as _i4.StaffSkill);
  @override
  _i4.StaffSkill get skillThree =>
      (super.noSuchMethod(Invocation.getter(#skillThree),
          returnValue: _FakeStaffSkill()) as _i4.StaffSkill);
  @override
  _i4.StaffSkill get skillFour =>
      (super.noSuchMethod(Invocation.getter(#skillFour),
          returnValue: _FakeStaffSkill()) as _i4.StaffSkill);
  @override
  _i4.StaffSkill? getStaffSkillById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getStaffSkillById, [id]))
          as _i4.StaffSkill?);
}
