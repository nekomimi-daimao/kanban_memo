// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCategoryDataCollection on Isar {
  IsarCollection<CategoryData> get categoryDatas => getCollection();
}

const CategoryDataSchema = CollectionSchema(
  name: 'CategoryData',
  schema:
      '{"name":"CategoryData","idName":"id","properties":[{"name":"boardId","type":"Long"},{"name":"category","type":"String"},{"name":"created","type":"Long"},{"name":"hashCode","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'boardId': 0, 'category': 1, 'created': 2, 'hashCode': 3},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _categoryDataGetId,
  setId: _categoryDataSetId,
  getLinks: _categoryDataGetLinks,
  attachLinks: _categoryDataAttachLinks,
  serializeNative: _categoryDataSerializeNative,
  deserializeNative: _categoryDataDeserializeNative,
  deserializePropNative: _categoryDataDeserializePropNative,
  serializeWeb: _categoryDataSerializeWeb,
  deserializeWeb: _categoryDataDeserializeWeb,
  deserializePropWeb: _categoryDataDeserializePropWeb,
  version: 3,
);

int? _categoryDataGetId(CategoryData object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _categoryDataSetId(CategoryData object, int id) {
  object.id = id;
}

List<IsarLinkBase> _categoryDataGetLinks(CategoryData object) {
  return [];
}

void _categoryDataSerializeNative(
    IsarCollection<CategoryData> collection,
    IsarRawObject rawObj,
    CategoryData object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.boardId;
  final _boardId = value0;
  final value1 = object.category;
  final _category = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_category.length) as int;
  final value2 = object.created;
  final _created = value2;
  final value3 = object.hashCode;
  final _hashCode = value3;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _boardId);
  writer.writeBytes(offsets[1], _category);
  writer.writeDateTime(offsets[2], _created);
  writer.writeLong(offsets[3], _hashCode);
}

CategoryData _categoryDataDeserializeNative(
    IsarCollection<CategoryData> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CategoryData();
  object.boardId = reader.readLongOrNull(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.created = reader.readDateTime(offsets[2]);
  object.id = id;
  return object;
}

P _categoryDataDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _categoryDataSerializeWeb(
    IsarCollection<CategoryData> collection, CategoryData object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'boardId', object.boardId);
  IsarNative.jsObjectSet(jsObj, 'category', object.category);
  IsarNative.jsObjectSet(
      jsObj, 'created', object.created.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  return jsObj;
}

CategoryData _categoryDataDeserializeWeb(
    IsarCollection<CategoryData> collection, dynamic jsObj) {
  final object = CategoryData();
  object.boardId = IsarNative.jsObjectGet(jsObj, 'boardId');
  object.category = IsarNative.jsObjectGet(jsObj, 'category') ?? '';
  object.created = IsarNative.jsObjectGet(jsObj, 'created') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'created'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  return object;
}

P _categoryDataDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'boardId':
      return (IsarNative.jsObjectGet(jsObj, 'boardId')) as P;
    case 'category':
      return (IsarNative.jsObjectGet(jsObj, 'category') ?? '') as P;
    case 'created':
      return (IsarNative.jsObjectGet(jsObj, 'created') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'created'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _categoryDataAttachLinks(
    IsarCollection col, int id, CategoryData object) {}

extension CategoryDataQueryWhereSort
    on QueryBuilder<CategoryData, CategoryData, QWhere> {
  QueryBuilder<CategoryData, CategoryData, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CategoryDataQueryWhere
    on QueryBuilder<CategoryData, CategoryData, QWhereClause> {
  QueryBuilder<CategoryData, CategoryData, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<CategoryData, CategoryData, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CategoryData, CategoryData, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CategoryData, CategoryData, QAfterWhereClause> idBetween(
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

extension CategoryDataQueryFilter
    on QueryBuilder<CategoryData, CategoryData, QFilterCondition> {
  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      boardIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'boardId',
      value: null,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      boardIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'boardId',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      boardIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'boardId',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      boardIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'boardId',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      boardIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boardId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'category',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'category',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      createdEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      createdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      createdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      createdBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'created',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      hashCodeGreaterThan(
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

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      hashCodeLessThan(
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

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition>
      hashCodeBetween(
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

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CategoryData, CategoryData, QAfterFilterCondition> idBetween(
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
}

extension CategoryDataQueryLinks
    on QueryBuilder<CategoryData, CategoryData, QFilterCondition> {}

extension CategoryDataQueryWhereSortBy
    on QueryBuilder<CategoryData, CategoryData, QSortBy> {
  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByBoardId() {
    return addSortByInternal('boardId', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByBoardIdDesc() {
    return addSortByInternal('boardId', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension CategoryDataQueryWhereSortThenBy
    on QueryBuilder<CategoryData, CategoryData, QSortThenBy> {
  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByBoardId() {
    return addSortByInternal('boardId', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByBoardIdDesc() {
    return addSortByInternal('boardId', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CategoryData, CategoryData, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension CategoryDataQueryWhereDistinct
    on QueryBuilder<CategoryData, CategoryData, QDistinct> {
  QueryBuilder<CategoryData, CategoryData, QDistinct> distinctByBoardId() {
    return addDistinctByInternal('boardId');
  }

  QueryBuilder<CategoryData, CategoryData, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('category', caseSensitive: caseSensitive);
  }

  QueryBuilder<CategoryData, CategoryData, QDistinct> distinctByCreated() {
    return addDistinctByInternal('created');
  }

  QueryBuilder<CategoryData, CategoryData, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<CategoryData, CategoryData, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }
}

extension CategoryDataQueryProperty
    on QueryBuilder<CategoryData, CategoryData, QQueryProperty> {
  QueryBuilder<CategoryData, int?, QQueryOperations> boardIdProperty() {
    return addPropertyNameInternal('boardId');
  }

  QueryBuilder<CategoryData, String, QQueryOperations> categoryProperty() {
    return addPropertyNameInternal('category');
  }

  QueryBuilder<CategoryData, DateTime, QQueryOperations> createdProperty() {
    return addPropertyNameInternal('created');
  }

  QueryBuilder<CategoryData, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<CategoryData, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
