// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetConfigCollection on Isar {
  IsarCollection<Config> get configs => getCollection();
}

const ConfigSchema = CollectionSchema(
  name: 'Config',
  schema:
      '{"name":"Config","idName":"id","properties":[{"name":"categoryListWidth","type":"Double"},{"name":"hashCode","type":"Long"},{"name":"themeModeInt","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'categoryListWidth': 0, 'hashCode': 1, 'themeModeInt': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _configGetId,
  setId: _configSetId,
  getLinks: _configGetLinks,
  attachLinks: _configAttachLinks,
  serializeNative: _configSerializeNative,
  deserializeNative: _configDeserializeNative,
  deserializePropNative: _configDeserializePropNative,
  serializeWeb: _configSerializeWeb,
  deserializeWeb: _configDeserializeWeb,
  deserializePropWeb: _configDeserializePropWeb,
  version: 3,
);

int? _configGetId(Config object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _configSetId(Config object, int id) {
  object.id = id;
}

List<IsarLinkBase> _configGetLinks(Config object) {
  return [];
}

void _configSerializeNative(
    IsarCollection<Config> collection,
    IsarRawObject rawObj,
    Config object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.categoryListWidth;
  final _categoryListWidth = value0;
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.themeModeInt;
  final _themeModeInt = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDouble(offsets[0], _categoryListWidth);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeLong(offsets[2], _themeModeInt);
}

Config _configDeserializeNative(IsarCollection<Config> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Config(
    categoryListWidth: reader.readDouble(offsets[0]),
    id: id,
    themeModeInt: reader.readLong(offsets[2]),
  );
  return object;
}

P _configDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _configSerializeWeb(IsarCollection<Config> collection, Config object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'categoryListWidth', object.categoryListWidth);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'themeModeInt', object.themeModeInt);
  return jsObj;
}

Config _configDeserializeWeb(IsarCollection<Config> collection, dynamic jsObj) {
  final object = Config(
    categoryListWidth: IsarNative.jsObjectGet(jsObj, 'categoryListWidth') ??
        double.negativeInfinity,
    id: IsarNative.jsObjectGet(jsObj, 'id'),
    themeModeInt: IsarNative.jsObjectGet(jsObj, 'themeModeInt') ??
        double.negativeInfinity,
  );
  return object;
}

P _configDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'categoryListWidth':
      return (IsarNative.jsObjectGet(jsObj, 'categoryListWidth') ??
          double.negativeInfinity) as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'themeModeInt':
      return (IsarNative.jsObjectGet(jsObj, 'themeModeInt') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _configAttachLinks(IsarCollection col, int id, Config object) {}

extension ConfigQueryWhereSort on QueryBuilder<Config, Config, QWhere> {
  QueryBuilder<Config, Config, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ConfigQueryWhere on QueryBuilder<Config, Config, QWhereClause> {
  QueryBuilder<Config, Config, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension ConfigQueryFilter on QueryBuilder<Config, Config, QFilterCondition> {
  QueryBuilder<Config, Config, QAfterFilterCondition>
      categoryListWidthGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'categoryListWidth',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> categoryListWidthLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'categoryListWidth',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> categoryListWidthBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'categoryListWidth',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hashCode',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeIntEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'themeModeInt',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeIntGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'themeModeInt',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeIntLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'themeModeInt',
      value: value,
    ));
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> themeModeIntBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'themeModeInt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ConfigQueryLinks on QueryBuilder<Config, Config, QFilterCondition> {}

extension ConfigQueryWhereSortBy on QueryBuilder<Config, Config, QSortBy> {
  QueryBuilder<Config, Config, QAfterSortBy> sortByCategoryListWidth() {
    return addSortByInternal('categoryListWidth', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByCategoryListWidthDesc() {
    return addSortByInternal('categoryListWidth', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByThemeModeInt() {
    return addSortByInternal('themeModeInt', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByThemeModeIntDesc() {
    return addSortByInternal('themeModeInt', Sort.desc);
  }
}

extension ConfigQueryWhereSortThenBy
    on QueryBuilder<Config, Config, QSortThenBy> {
  QueryBuilder<Config, Config, QAfterSortBy> thenByCategoryListWidth() {
    return addSortByInternal('categoryListWidth', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByCategoryListWidthDesc() {
    return addSortByInternal('categoryListWidth', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByThemeModeInt() {
    return addSortByInternal('themeModeInt', Sort.asc);
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByThemeModeIntDesc() {
    return addSortByInternal('themeModeInt', Sort.desc);
  }
}

extension ConfigQueryWhereDistinct on QueryBuilder<Config, Config, QDistinct> {
  QueryBuilder<Config, Config, QDistinct> distinctByCategoryListWidth() {
    return addDistinctByInternal('categoryListWidth');
  }

  QueryBuilder<Config, Config, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<Config, Config, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Config, Config, QDistinct> distinctByThemeModeInt() {
    return addDistinctByInternal('themeModeInt');
  }
}

extension ConfigQueryProperty on QueryBuilder<Config, Config, QQueryProperty> {
  QueryBuilder<Config, double, QQueryOperations> categoryListWidthProperty() {
    return addPropertyNameInternal('categoryListWidth');
  }

  QueryBuilder<Config, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<Config, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Config, int, QQueryOperations> themeModeIntProperty() {
    return addPropertyNameInternal('themeModeInt');
  }
}
