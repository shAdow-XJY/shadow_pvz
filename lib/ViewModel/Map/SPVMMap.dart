import 'SPVMBuilding.dart';

class SPVMMap {
  List<SPVMBuildingInfo> buildings = [];

  SPVMMap() {
    // Initialize buildings list (example data)
    buildings.add(SPVMBuildingInfo(positionX: 0.2, positionY: 0.8, type: SPVMBuildingType.house));
    buildings.add(SPVMBuildingInfo(positionX: 0.8, positionY: 0.2, type: SPVMBuildingType.school));
  }
}