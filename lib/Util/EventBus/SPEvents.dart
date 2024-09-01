import '../../ViewModel/Map/SPVMBuilding.dart';
import 'SPEventCode.dart';

class SPEvent {
  final SPEventCode eventCode; // 必需参数
  final Map<String, dynamic>? data; // 可空参数

  SPEvent(this.eventCode, {this.data});
}

class SPMapEnterBuildingEvent extends SPEvent {
  final SPVMBuildingType buildingType;

  SPMapEnterBuildingEvent(this.buildingType) : super(
      SPEventCode.mapEnterBuilding,
      data: {'buildingType': buildingType}
  );
}

class SPBackToMapHomeEvent extends SPEvent {

  SPBackToMapHomeEvent() : super(
      SPEventCode.backToMapHome
  );
}
