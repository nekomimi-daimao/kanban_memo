// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMemoDataCollection on Isar {
  IsarCollection<MemoData> get memoDatas => getCollection();
}

const MemoDataSchema = CollectionSchema(
  name: 'MemoData',
  schema:
      '{"name":"MemoData","idName":"id","properties":[{"name":"boardId","type":"Long"},{"name":"categoryId","type":"Long"},{"name":"index","type":"Long"},{"name":"memo","type":"String"},{"name":"title","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'boardId': 0,
    'categoryId': 1,
    'index': 2,
    'memo': 3,
    'title': 4
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _memoDataGetId,
  setId: _memoDataSetId,
  getLinks: _memoDataGetLinks,
  attachLinks: _memoDataAttachLinks,
  serializeNative: _memoDataSerializeNative,
  deserializeNative: _memoDataDeserializeNative,
  deserializePropNative: _memoDataDeserializePropNative,
  serializeWeb: _memoDataSerializeWeb,
  deserializeWeb: _memoDataDeserializeWeb,
  deserializePropWeb: _memoDataDeserializePropWeb,
  version: 3,
);

int? _memoDataGetId(MemoData object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _memoDataSetId(MemoData object, int id) {
  object.id = id;
}

List<IsarLinkBase> _memoDataGetLinks(MemoData object) {
  return [];
}

void _memoDataSerializeNative(
    IsarCollection<MemoData> collection,
    IsarRawObject rawObj,
    MemoData object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.boardId;
  final _boardId = value0;
  final value1 = object.categoryId;
  final _categoryId = value1;
  final value2 = object.index;
  final _index = value2;
  final value3 = object.memo;
  final _memo = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_memo.length) as int;
  final value4 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_title.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _boardId);
  writer.writeLong(offsets[1], _categoryId);
  writer.writeLong(offsets[2], _index);
  writer.writeBytes(offsets[3], _memo);
  writer.writeBytes(offsets[4], _title);
}

MemoData _memoDataDeserializeNative(IsarCollection<MemoData> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = MemoData(
    boardId: reader.readLongOrNull(offsets[0]),
    categoryId: reader.readLongOrNull(offsets[1]),
  );
  object.id = id;
  object.index = reader.readLong(offsets[2]);
  object.memo = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  return object;
}

P _memoDataDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _memoDataSerializeWeb(
    IsarCollection<MemoData> collection, MemoData object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'boardId', object.boardId);
  IsarNative.jsObjectSet(jsObj, 'categoryId', object.categoryId);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'index', object.index);
  IsarNative.jsObjectSet(jsObj, 'memo', object.memo);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  return jsObj;
}

MemoData _memoDataDeserializeWeb(
    IsarCollection<MemoData> collection, dynamic jsObj) {
  final object = MemoData(
    boardId: IsarNative.jsObjectGet(jsObj, 'boardId'),
    categoryId: IsarNative.jsObjectGet(jsObj, 'categoryId'),
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.index =
      IsarNative.jsObjectGet(jsObj, 'index') ?? double.negativeInfinity;
  object.memo = IsarNative.jsObjectGet(jsObj, 'memo') ?? '';
  object.title = IsarNative.jsObjectGet(jsObj, 'title') ?? '';
  return object;
}

P _memoDataDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'boardId':
      return (IsarNative.jsObjectGet(jsObj, 'boardId')) as P;
    case 'categoryId':
      return (IsarNative.jsObjectGet(jsObj, 'categoryId')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'index':
      return (IsarNative.jsObjectGet(jsObj, 'index') ?? double.negativeInfinity)
          as P;
    case 'memo':
      return (IsarNative.jsObjectGet(jsObj, 'memo') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _memoDataAttachLinks(IsarCollection col, int id, MemoData object) {}

extension MemoDataQueryWhereSort on QueryBuilder<MemoData, MemoData, QWhere> {
  QueryBuilder<MemoData, MemoData, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MemoDataQueryWhere on QueryBuilder<MemoData, MemoData, QWhereClause> {
  QueryBuilder<MemoData, MemoData, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MemoData, MemoData, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MemoData, MemoData, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MemoData, MemoData, QAfterWhereClause> idBetween(
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

extension MemoDataQueryFilter
    on QueryBuilder<MemoData, MemoData, QFilterCondition> {
  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> boardIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'boardId',
      value: null,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> boardIdEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'boardId',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> boardIdGreaterThan(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> boardIdLessThan(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> boardIdBetween(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> categoryIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'categoryId',
      value: null,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> categoryIdEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> categoryIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> categoryIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> categoryIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'categoryId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> indexEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'index',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'memo',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> memoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'memo',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'title',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MemoData, MemoData, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension MemoDataQueryLinks
    on QueryBuilder<MemoData, MemoData, QFilterCondition> {}

extension MemoDataQueryWhereSortBy
    on QueryBuilder<MemoData, MemoData, QSortBy> {
  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByBoardId() {
    return addSortByInternal('boardId', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByBoardIdDesc() {
    return addSortByInternal('boardId', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByIndex() {
    return addSortByInternal('index', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByIndexDesc() {
    return addSortByInternal('index', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByMemo() {
    return addSortByInternal('memo', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByMemoDesc() {
    return addSortByInternal('memo', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension MemoDataQueryWhereSortThenBy
    on QueryBuilder<MemoData, MemoData, QSortThenBy> {
  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByBoardId() {
    return addSortByInternal('boardId', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByBoardIdDesc() {
    return addSortByInternal('boardId', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByIndex() {
    return addSortByInternal('index', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByIndexDesc() {
    return addSortByInternal('index', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByMemo() {
    return addSortByInternal('memo', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByMemoDesc() {
    return addSortByInternal('memo', Sort.desc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<MemoData, MemoData, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension MemoDataQueryWhereDistinct
    on QueryBuilder<MemoData, MemoData, QDistinct> {
  QueryBuilder<MemoData, MemoData, QDistinct> distinctByBoardId() {
    return addDistinctByInternal('boardId');
  }

  QueryBuilder<MemoData, MemoData, QDistinct> distinctByCategoryId() {
    return addDistinctByInternal('categoryId');
  }

  QueryBuilder<MemoData, MemoData, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MemoData, MemoData, QDistinct> distinctByIndex() {
    return addDistinctByInternal('index');
  }

  QueryBuilder<MemoData, MemoData, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('memo', caseSensitive: caseSensitive);
  }

  QueryBuilder<MemoData, MemoData, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }
}

extension MemoDataQueryProperty
    on QueryBuilder<MemoData, MemoData, QQueryProperty> {
  QueryBuilder<MemoData, int?, QQueryOperations> boardIdProperty() {
    return addPropertyNameInternal('boardId');
  }

  QueryBuilder<MemoData, int?, QQueryOperations> categoryIdProperty() {
    return addPropertyNameInternal('categoryId');
  }

  QueryBuilder<MemoData, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MemoData, int, QQueryOperations> indexProperty() {
    return addPropertyNameInternal('index');
  }

  QueryBuilder<MemoData, String, QQueryOperations> memoProperty() {
    return addPropertyNameInternal('memo');
  }

  QueryBuilder<MemoData, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }
}
