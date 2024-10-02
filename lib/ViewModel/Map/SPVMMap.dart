import 'SPVMBuilding.dart';

class SPVMMap {
  List<SPVMBuildingInfo> buildings = [];

  static double mapWidth = 1000;
  static double mapHeight = 1000;

  SPVMMap() {
    // Initialize buildings list (example data)
    buildings.add(SPVMBuildingInfo(positionX: 100, positionY: 100, type: SPVMBuildingType.house));
    buildings.add(SPVMBuildingInfo(positionX: 200, positionY: 200, type: SPVMBuildingType.school));
    buildings.add(SPVMBuildingInfo(positionX: 400, positionY: 400, type: SPVMBuildingType.school));
    buildings.add(SPVMBuildingInfo(positionX: 800, positionY: 100, type: SPVMBuildingType.school));
    buildings.add(SPVMBuildingInfo(positionX: 200, positionY: 800, type: SPVMBuildingType.school));
  }
}