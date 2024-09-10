
/// Base class of all persistable entity
class IdentifiableEntity {
  int? id;
}

/// Base class of all patient management parameters
class ManagedParameters extends IdentifiableEntity {
  String? dayDate;
}

/// Description of measured glucose
class Glucose extends ManagedParameters {
  double? takenValue;
}

/// Description of injected insulin
class Insulin extends ManagedParameters {
  double injectedQuantity;
  InsulinType? type;

  Insulin({int id = 0, String dayDate = "", this.injectedQuantity = 0, this.type}) {
    this.id = id;
    this.dayDate = dayDate;
  }
}

/// Description of taken bread
class BreadUnit extends ManagedParameters {
  double? serving;
  BreadConfig? bread;
}

/// Configuration of usable insulin
class InsulinType extends IdentifiableEntity {
  String name;
  InsulinType({int id = 0, this.name = ""}) {
    this.id = id;
  }

  @override
  String toString() {
    return name;
  }
}

/// Configuration of usable bread in our app
class BreadConfig extends IdentifiableEntity {
  String name;
  double carbohydratePerServing;

  BreadConfig({int id = 0, this.name = "", this.carbohydratePerServing = 0.0});
}