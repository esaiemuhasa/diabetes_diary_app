
/// Base class of all persistable entity
class IdentifiableEntity {
  int? id;
}

/// Base class of all patient management parameters
class ManagedParameters extends IdentifiableEntity {
  DateTime? dayDate;
}

/// Description of measured glucose
class Glucose extends ManagedParameters {
  double? takenValue;
}

/// Description of injected insulin
class Insulin extends ManagedParameters {
  double? injectedQuantity;
  InsulinType? type;
}

/// Description of taken bread
class BreadUnit extends ManagedParameters {
  double? portion;
  BreadConfig? bread;
}

/// Configuration of usable insulin
class InsulinType extends IdentifiableEntity {
  String? name;
}

/// Configuration of usable bread in our app
class BreadConfig extends IdentifiableEntity {
  String? name;
  double? carbohydratePerServing;
}