import 'package:dio/dio.dart';
import 'package:mobileriverpod/constand.dart';
import 'package:mobileriverpod/domain/job/model/job_model.dart';
import 'package:mobileriverpod/domain/job/model/update_job_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDataProvider {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  JobDataProvider(this.dio, this.sharedPreferences);

  Future<Map<String, String>> _authenticatedHeaders() async {
    final token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception('Missing token in local storage.');
    }

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Assuming JSON content type
    };
  }

  Future<Job> createJob(Job job) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.post('$x/jobs',
          data: job.toJson(), options: Options(headers: headers));

      if (response.statusCode == 201) {
        final data = response.data;
        return Job.fromJson(data);
      } else {
        throw Exception('Failed to create job');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.delete('$x/jobs/$jobId',
          options: Options(headers: headers));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete job');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<UpdateJobDto> updateJob(String jobId, UpdateJobDto job) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.patch('$x/jobs/$jobId',
          data: job.toJson(), options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data;
        return UpdateJobDto.fromJson(data);
      } else {
        throw Exception('Failed to update job');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Job>> getJobsByUserId(int userId) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.get(
        '$x/jobs/user-jobs/$userId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data['jobs'] as List;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Job>> getJobsForEmployees() async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.get('$x/jobs/forEmployees',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data['jobs'] as List;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs for employees');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Job>> getJobsForJobSeekers() async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.get('$x/jobs/forJobSeekers',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data['jobs'] as List;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs for job seekers');
      }
    } catch (error) {
      rethrow;
    }
  }
}
