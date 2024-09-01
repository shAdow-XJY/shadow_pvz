import 'package:shadow_pvz/Util/Asset/SPAssetImages.dart';

enum SPVMBuildingType { house, school }

class SPVMBuildingInfo {
  double positionX;
  double positionY;
  SPVMBuildingType type;

  SPVMBuildingInfo({
    required this.positionX,
    required this.positionY,
    required this.type,
  });
}

// Map to store type and imagePath pairs
final Map<SPVMBuildingType, String> buildingImagePathMap = {
  SPVMBuildingType.house: SPAssetImages.houseOfBuildingOfMap,
  SPVMBuildingType.school: SPAssetImages.schoolOfBuildingOfMap,
};

// Function to get imagePath based on type
String getImagePathForType(SPVMBuildingType type) {
  return buildingImagePathMap[type] ?? SPAssetImages.houseOfBuildingOfMap; // Default image if type not found
}