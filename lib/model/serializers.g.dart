

part of 'serializers.dart';



Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Countries.serializer)
      ..add(Covid19Dashboard.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Countries)]),
          () => new ListBuilder<Countries>()))
    .build();

