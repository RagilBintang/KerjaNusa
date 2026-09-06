import 'package:flutter/material.dart';

import '../service/api_client.dart';

class CreateJobPage extends StatefulWidget {
  const CreateJobPage({super.key});

  @override
  State<CreateJobPage> createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController(text: 'Aurea Artisan Goods');
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _apiClient = ApiClient();
  String _type = 'Full-time';
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _apiClient.dispose();
    super.dispose();
  }

  Future<void> _saveJob() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await _apiClient.createJob(
        title: _titleController.text.trim(),
        company: _companyController.text.trim(),
        location: _locationController.text.trim(),
        salary: _salaryController.text.trim(),
        type: _type,
        description: _descriptionController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lowongan berhasil disimpan ke API.')),
      );
      Navigator.pushReplacementNamed(context, '/hrd/management');
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan lowongan: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: const Color(0xFF8C4A36),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _field(_titleController, 'Judul lowongan'),
                  _field(_companyController, 'Nama perusahaan'),
                  _field(_locationController, 'Lokasi'),
                  _field(_salaryController, 'Rentang gaji'),
                  DropdownButtonFormField<String>(
                    value: _type,
                    decoration: const InputDecoration(labelText: 'Tipe pekerjaan'),
                    items: const [
                      DropdownMenuItem(value: 'Full-time', child: Text('Full-time')),
                      DropdownMenuItem(value: 'Part-time', child: Text('Part-time')),
                      DropdownMenuItem(value: 'Magang / PKL', child: Text('Magang / PKL')),
                    ],
                    onChanged: (value) => setState(() => _type = value ?? _type),
                  ),
                  _field(_descriptionController, 'Deskripsi', maxLines: 5),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveJob,
                    icon: _isSaving
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.save),
                    label: Text(_isSaving ? 'Menyimpan...' : 'Simpan Lowongan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        validator: (value) => value == null || value.trim().isEmpty ? 'Wajib diisi' : null,
      ),
    );
  }
}
