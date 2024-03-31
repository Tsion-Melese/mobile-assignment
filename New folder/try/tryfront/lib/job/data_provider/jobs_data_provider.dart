import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/job/model/job_model.dart';

class JobRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  JobRepository(this.dio, this.sharedPreferences);

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

  Future<List<Job>> getJobs() async {
    try {
      final headers =
          await _authenticatedHeaders(); // Include authentication headers
      final response = await dio.get('http://localhost:3000/jobs',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Job> createJob(Job job) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.post('http://localhost:3000/jobs',
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
      final response = await dio.delete('http://localhost:3000/jobs/$jobId',
          options: Options(headers: headers));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete job');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Job> updateJob(String jobId, Job job) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.put('http://localhost:3000/jobs/$jobId',
          data: job.toJson(), options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data;
        return Job.fromJson(data);
      } else {
        throw Exception('Failed to update job');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Job>> getJobsByUserId(String userId) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.get(
          'http://localhost:3000/jobs/user-jobs/$userId',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs for user');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Job>> getJobsForEmployees() async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.get('http://localhost:3000/jobs/forEmployees',
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
      final response = await dio.get('http://localhost:3000/jobs/forJobSeekers',
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

  // Implement other methods similarly to include authentication headers
}
