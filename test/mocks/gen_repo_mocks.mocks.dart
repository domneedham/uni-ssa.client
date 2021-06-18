// Mocks generated by Mockito 5.0.9 from annotations
// in ssa_app/test/mocks/gen_repo_mocks.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ssa_app/app/data/models/skill/category.dart' as _i7;
import 'package:ssa_app/app/data/models/skill/manager_staff_skill.dart' as _i6;
import 'package:ssa_app/app/data/models/skill/staff_skill.dart' as _i5;
import 'package:ssa_app/app/data/models/user/manager.dart' as _i4;
import 'package:ssa_app/app/data/models/user/staff.dart' as _i3;
import 'package:ssa_app/app/data/models/user/user.dart' as _i2;
import 'package:ssa_app/app/data/repository/categories_repository.dart' as _i12;
import 'package:ssa_app/app/data/repository/skill_manager_repository.dart'
    as _i11;
import 'package:ssa_app/app/data/repository/skill_staff_repository.dart'
    as _i10;
import 'package:ssa_app/app/data/repository/user_repository.dart' as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUser extends _i1.Fake implements _i2.User {}

class _FakeStaff extends _i1.Fake implements _i3.Staff {}

class _FakeManager extends _i1.Fake implements _i4.Manager {}

class _FakeStaffSkill extends _i1.Fake implements _i5.StaffSkill {}

class _FakeManagerStaffSkill extends _i1.Fake implements _i6.ManagerStaffSkill {
}

class _FakeCategory extends _i1.Fake implements _i7.Category {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i8.UserRepository {
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
  @override
  _i3.Staff get staff2 =>
      (super.noSuchMethod(Invocation.getter(#staff2), returnValue: _FakeStaff())
          as _i3.Staff);
  @override
  _i4.Manager get manager => (super.noSuchMethod(Invocation.getter(#manager),
      returnValue: _FakeManager()) as _i4.Manager);
  @override
  _i9.Future<_i3.Staff> getStaffById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getStaffById, [id]),
              returnValue: Future<_i3.Staff>.value(_FakeStaff()))
          as _i9.Future<_i3.Staff>);
}

/// A class which mocks [SkillStaffRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSkillStaffRepository extends _i1.Mock
    implements _i10.SkillStaffRepository {
  MockSkillStaffRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.StaffSkill get skillOne =>
      (super.noSuchMethod(Invocation.getter(#skillOne),
          returnValue: _FakeStaffSkill()) as _i5.StaffSkill);
  @override
  _i5.StaffSkill get skillTwo =>
      (super.noSuchMethod(Invocation.getter(#skillTwo),
          returnValue: _FakeStaffSkill()) as _i5.StaffSkill);
  @override
  _i5.StaffSkill get skillThree =>
      (super.noSuchMethod(Invocation.getter(#skillThree),
          returnValue: _FakeStaffSkill()) as _i5.StaffSkill);
  @override
  _i5.StaffSkill get skillFour =>
      (super.noSuchMethod(Invocation.getter(#skillFour),
          returnValue: _FakeStaffSkill()) as _i5.StaffSkill);
  @override
  _i5.StaffSkill get skillFive =>
      (super.noSuchMethod(Invocation.getter(#skillFive),
          returnValue: _FakeStaffSkill()) as _i5.StaffSkill);
  @override
  _i9.Future<List<_i5.StaffSkill>> get skills => (super.noSuchMethod(
          Invocation.getter(#skills),
          returnValue: Future<List<_i5.StaffSkill>>.value(<_i5.StaffSkill>[]))
      as _i9.Future<List<_i5.StaffSkill>>);
  @override
  _i5.StaffSkill? getStaffSkillById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getStaffSkillById, [id]))
          as _i5.StaffSkill?);
  @override
  _i9.Future<List<_i5.StaffSkill>> getSkillsByIds(List<int>? ids) =>
      (super.noSuchMethod(Invocation.method(#getSkillsByIds, [ids]),
              returnValue:
                  Future<List<_i5.StaffSkill>>.value(<_i5.StaffSkill>[]))
          as _i9.Future<List<_i5.StaffSkill>>);
}

/// A class which mocks [SkillManagerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSkillManagerRepository extends _i1.Mock
    implements _i11.SkillManagerRepository {
  MockSkillManagerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.ManagerStaffSkill get skillOne =>
      (super.noSuchMethod(Invocation.getter(#skillOne),
          returnValue: _FakeManagerStaffSkill()) as _i6.ManagerStaffSkill);
  @override
  _i6.ManagerStaffSkill get skillTwo =>
      (super.noSuchMethod(Invocation.getter(#skillTwo),
          returnValue: _FakeManagerStaffSkill()) as _i6.ManagerStaffSkill);
  @override
  _i9.Future<List<_i6.ManagerStaffSkill>> get skills =>
      (super.noSuchMethod(Invocation.getter(#skills),
              returnValue: Future<List<_i6.ManagerStaffSkill>>.value(
                  <_i6.ManagerStaffSkill>[]))
          as _i9.Future<List<_i6.ManagerStaffSkill>>);
  @override
  _i9.Future<_i6.ManagerStaffSkill> getManagerStaffSkillById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getManagerStaffSkillById, [id]),
              returnValue:
                  Future<_i6.ManagerStaffSkill>.value(_FakeManagerStaffSkill()))
          as _i9.Future<_i6.ManagerStaffSkill>);
}

/// A class which mocks [CategoriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoriesRepository extends _i1.Mock
    implements _i12.CategoriesRepository {
  MockCategoriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Category get categoryOne =>
      (super.noSuchMethod(Invocation.getter(#categoryOne),
          returnValue: _FakeCategory()) as _i7.Category);
  @override
  _i7.Category get categoryTwo =>
      (super.noSuchMethod(Invocation.getter(#categoryTwo),
          returnValue: _FakeCategory()) as _i7.Category);
  @override
  _i9.Future<List<_i7.Category>> get categories =>
      (super.noSuchMethod(Invocation.getter(#categories),
              returnValue: Future<List<_i7.Category>>.value(<_i7.Category>[]))
          as _i9.Future<List<_i7.Category>>);
  @override
  _i9.Future<_i7.Category> getCategoryById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getCategoryById, [id]),
              returnValue: Future<_i7.Category>.value(_FakeCategory()))
          as _i9.Future<_i7.Category>);
}
