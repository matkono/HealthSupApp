import 'package:healthsup/features/disease/data/models/disease_model.dart';
import 'package:healthsup/features/disease/data/models/diseases_list_model.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';

abstract class DiseaseRemoteDataSource {
  Future<DiseaseListModel> getDiseaseList(Pagination pagination);
}

class DiseaseRemoteDataSourceImpl implements DiseaseRemoteDataSource {
  @override
  Future<DiseaseListModel> getDiseaseList(Pagination pagination) async {
    var listDisease = [
      {"id": 1, "name": "Cardiomiopatia Periparto"},
      {"id": 2, "name": "Covid 1"},
      {"id": 3, "name": "Covid 2"},
      {"id": 4, "name": "Covid 3"},
      {"id": 5, "name": "Covid 4"},
      {"id": 6, "name": "Covid 5"},
      {"id": 7, "name": "Covid 6"},
      {"id": 8, "name": "Covid 7"},
      {"id": 9, "name": "Covid 8"},
      {"id": 10, "name": "Covid 9"},
      {"id": 11, "name": "Covid 10"},
      {"id": 12, "name": "Covid 11"},
      {"id": 13, "name": "Covid 12"},
      {"id": 14, "name": "Covid 13"},
      {"id": 15, "name": "Covid 14"},
      {"id": 16, "name": "Covid 15"},
      {"id": 17, "name": "Covid 16"},
      {"id": 18, "name": "Covid 17"},
      {"id": 19, "name": "Covid 18"},
      {"id": 20, "name": "Covid 19"},
      {"id": 21, "name": "Covid 20"},
      {"id": 22, "name": "Covid 21"},
      {"id": 23, "name": "Covid 22"},
      {"id": 24, "name": "Covid 23"},
      {"id": 25, "name": "Covid 24"},
      {"id": 26, "name": "Covid 25"},
      {"id": 27, "name": "Covid 26"},
      {"id": 28, "name": "Covid 27"},
      {"id": 29, "name": "Covid 28"},
      {"id": 30, "name": "Covid 29"},
    ];

    int start = pagination.pageNumber * pagination.pageSize;
    int end = start + pagination.pageSize;

    var currentList = listDisease.sublist(
        start > (listDisease.length) ? (listDisease.length) : start,
        end > (listDisease.length) ? (listDisease.length) : end);

    var diseaseList = new DiseaseListModel(
      disease: DiseasesModel.listFromJson(currentList),
      pageNumber: pagination.pageNumber,
      pageSize: pagination.pageSize,
      totalRows: listDisease.length,
    );

    return diseaseList;
  }
}
