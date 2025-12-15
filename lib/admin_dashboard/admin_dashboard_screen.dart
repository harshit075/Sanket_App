import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/hotspot.dart';
import 'models/worker.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/section_title.dart';
import 'widgets/hotspot_card.dart';
import 'widgets/map_card.dart';
import 'widgets/download_card.dart';
import 'widgets/chart_placeholder.dart';
import 'widgets/manage_workers_card.dart';
import 'widgets/worker_tile.dart';
import 'widgets/manage_education_card.dart';
import 'widgets/education_tile.dart';
import 'provider/education_provider.dart';
import 'models/education_content.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final int totalReports = 411;
  final int highRiskAreas = 9;
  final String mostAffected = 'Kamrup, Assam';
  final String lastUpdate = 'Live Data';

  final List<Hotspot> hotspots = [
    Hotspot(
      name: 'Sitapur',
      district: 'West Siang, Arunachal Pradesh',
      risk: RiskLevel.high,
      reports: 42,
    ),
    Hotspot(
      name: 'Aizawl',
      district: 'Aizawl, Mizoram',
      risk: RiskLevel.medium,
      reports: 30,
    ),
    Hotspot(
      name: 'Rampur',
      district: 'Kamrup, Assam',
      risk: RiskLevel.low,
      reports: 5,
    ),
  ];

  final List<Worker> workers = [
    Worker(name: 'Sunita Devi', location: 'Kamrup, Assam', reportsFiled: 120),
    Worker(
      name: 'Priya Sharma',
      location: 'West Siang, Arunachal Pradesh',
      reportsFiled: 35,
    ),
  ];

  String? selectedState = 'Mizoram';
  String? selectedDistrict = 'West Siang';
  String? selectedWard = 'Ward 2';

  final _workerNameController = TextEditingController();
  final _workerLocController = TextEditingController();

  final _eduTitleController = TextEditingController();
  final _eduDetailsController = TextEditingController();
  final _eduLinkController = TextEditingController();

  String? selectedType;

  @override
  void dispose() {
    _workerNameController.dispose();
    _workerLocController.dispose();
    _eduTitleController.dispose();
    _eduDetailsController.dispose();
    _eduLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eduProvider = Provider.of<EducationProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DashboardHeader(
            highRiskAreas: highRiskAreas,
            mostAffected: mostAffected,
            totalReports: totalReports,
            lastUpdate: lastUpdate,
          ),
          const SizedBox(height: 16),

          const SectionTitle("High-Risk Hotspots"),
          ...hotspots.map((h) => HotspotCard(hotspot: h)),

          const SizedBox(height: 20),
          const SectionTitle("Regional Risk Map"),
          const MapCard(),

          const SizedBox(height: 20),
          const SectionTitle("Download Reports"),
          DownloadCard(
            selectedState: selectedState,
            selectedDistrict: selectedDistrict,
            selectedWard: selectedWard,
            onStateChanged: (v) => setState(() => selectedState = v),
            onDistrictChanged: (v) => setState(() => selectedDistrict = v),
            onWardChanged: (v) => setState(() => selectedWard = v),
          ),

          const SizedBox(height: 20),
          const SectionTitle("Data Analysis"),
          const ChartPlaceholder(),

          const SizedBox(height: 20),
          const SectionTitle("Manage ASHA Workers"),
          ManageWorkersCard(
            workerNameController: _workerNameController,
            workerLocController: _workerLocController,
            onAddWorker: () {},
          ),
          ...workers.map((w) => WorkerTile(worker: w)),

          const SizedBox(height: 20),
          const SectionTitle("Manage Education Content"),
          ManageEducationCard(
            titleController: _eduTitleController,
            detailsController: _eduDetailsController,
            linkController: _eduLinkController,
            selectedType: selectedType,
            onTypeChanged: (val) => setState(() => selectedType = val),
            onAddContent: () {
              if (_eduTitleController.text.isNotEmpty &&
                  _eduDetailsController.text.isNotEmpty &&
                  _eduLinkController.text.isNotEmpty &&
                  selectedType != null) {
                eduProvider.addContent(
                  EducationContent(
                    title: _eduTitleController.text,
                    details: _eduDetailsController.text,
                    type: selectedType!,
                    link: _eduLinkController.text,
                  ),
                );
                _eduTitleController.clear();
                _eduDetailsController.clear();
                _eduLinkController.clear();
                setState(() => selectedType = null);
              }
            },
          ),

          // show saved education content with remove option
          ...eduProvider.contents.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final e = entry.value;
              return EducationTile(
                title: e.title,
                details: "${e.type} • ${e.details}",
                type: e.type,
                onRemove: () {
                  eduProvider.removeContent(index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
