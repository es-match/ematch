import 'package:ematch/App/model/activityModel.dart';
import 'package:ematch/App/repository/activityRepository.dart';

class ActivitiesController {
  ActivityRepository _repository = ActivityRepository();

  Future<List<ActivityModel>> getActivities() async {
    return _repository.getActivities();
  }
}
