import 'package:fir_analysis/ocr.dart';
import 'package:flutter/material.dart';

class FIRForm extends StatefulWidget {
  final String ipcSections;
  final String description;

  const FIRForm(
      {Key? key, required this.ipcSections, required this.description})
      : super(key: key);

  @override
  State<FIRForm> createState() => _FIRFormState();
}

class _FIRFormState extends State<FIRForm> {
  final TextEditingController sectionsController = TextEditingController();
  final TextEditingController occurrenceDayController = TextEditingController();
  final TextEditingController occurrenceDateController =
      TextEditingController();
  final TextEditingController occurrenceTimeController =
      TextEditingController();
  final TextEditingController infoReceivedDateController =
      TextEditingController();
  final TextEditingController infoReceivedTimeController =
      TextEditingController();
  final TextEditingController diaryReferenceEntryController =
      TextEditingController();
  final TextEditingController diaryReferenceTimeController =
      TextEditingController();
  final TextEditingController placeDirectionController =
      TextEditingController();
  final TextEditingController placeBeatNoController = TextEditingController();
  final TextEditingController placeAddressController = TextEditingController();
  final TextEditingController placeOutsideStationController =
      TextEditingController();
  final TextEditingController placeOutsideDistrictController =
      TextEditingController();
  final TextEditingController complainantNameController =
      TextEditingController();
  final TextEditingController complainantFatherNameController =
      TextEditingController();
  final TextEditingController complainantDOBController =
      TextEditingController();
  final TextEditingController complainantNationalityController =
      TextEditingController();
  final TextEditingController complainantOccupationController =
      TextEditingController();
  final TextEditingController complainantAddressController =
      TextEditingController();
  final TextEditingController detailsOfAccusedController =
      TextEditingController();
  final TextEditingController reasonsForDelayController =
      TextEditingController();
  final TextEditingController propertiesStolenController =
      TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController policeStationController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController firNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Generate FIR number automatically (you may customize this logic)
    firNumberController.text = 'FIR-${DateTime.now().millisecondsSinceEpoch}';
    sectionsController.text = widget.ipcSections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Form'),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle("1. Basic Information"),
              _buildFIRInformation(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _buildTitle("2. Act and Sections"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: const Icon(Icons.camera))
                ],
              ),
              _buildSections(sectionsController),
              _buildTitle("3. (a) Occurrence of Offence:"),
              _buildOccurrenceOfOffence(),
              _buildTitle("3. (b) Information received at P.S."),
              _buildInformationReceivedAtPS(),
              // _buildTitle("3. (c) General Diary Reference: Entry No(s)… Time…"),
              // _buildGeneralDiaryReference(),
              // _buildTitle("4. Type of information: *Written / Oral"),
              _buildTitle("4. Place of occurrence:"),
              _buildPlaceOfOccurrence(),
              _buildTitle("5. Complainant / information:"),
              _buildComplainantInformation(),
              _buildTitle(
                  "6. Details of known / suspected / unknown / accused with full particulars:"),
              _buildDetailsOfAccused(),
              _buildTitle("7. Description of Crime in detail"),
              _buildDescriptionofCrime(),
              // _buildTitle("8. Particulars of properties stolen / involved:"),
              // _buildPropertiesStolen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFIRInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoField("District:", districtController),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildInfoField("P.S.:", policeStationController),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: _buildInfoField("Year:", yearController),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildInfoField("F.I.R. No:", firNumberController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildSections(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: 2,
        decoration: const InputDecoration(
          labelText: "(i) *Acts & Sections",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildOccurrenceOfOffence() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text("Date:"),
          const SizedBox(width: 5.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null &&
                    pickedDate != occurrenceDateController.text) {
                  setState(() {
                    occurrenceDateController.text = pickedDate.toString();
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: occurrenceDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: Icon(Icons.date_range),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          const Text("Time:"),
          const SizedBox(width: 8.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null &&
                    pickedTime !=
                        TimeOfDay.fromDateTime(
                            DateTime.parse(occurrenceTimeController.text))) {
                  setState(() {
                    occurrenceTimeController.text = pickedTime.format(context);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: occurrenceTimeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: Icon(Icons.access_time), // Time picker icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationReceivedAtPS() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text("Date:"),
          const SizedBox(width: 8.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null &&
                    pickedDate != infoReceivedDateController.text) {
                  setState(() {
                    infoReceivedDateController.text = pickedDate.toString();
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: infoReceivedDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: Icon(Icons.date_range), // Date picker icon
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("Time:"),
          const SizedBox(width: 8.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null &&
                    pickedTime !=
                        TimeOfDay.fromDateTime(
                            DateTime.parse(infoReceivedTimeController.text))) {
                  setState(() {
                    infoReceivedTimeController.text =
                        pickedTime.format(context);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: infoReceivedTimeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: Icon(Icons.access_time), // Time picker icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralDiaryReference() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text("(c) General Diary Reference: Entry No (s):"),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: diaryReferenceEntryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          const Text("Time:"),
          const SizedBox(width: 8.0),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null &&
                    pickedTime !=
                        TimeOfDay.fromDateTime(DateTime.parse(
                            diaryReferenceTimeController.text))) {
                  setState(() {
                    diaryReferenceTimeController.text =
                        pickedTime.format(context);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: diaryReferenceTimeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: Icon(Icons.access_time), // Time picker icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOfOccurrence() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("(a) Direction and Distance from P.S.:"),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: placeDirectionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text("Beat No.:"),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: placeBeatNoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text("(b) Address:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: placeAddressController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
              "(c) In case outside limit of this Police Station, then the name of P.S.:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: placeOutsideStationController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("District:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: placeOutsideDistrictController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplainantInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("(a) Name:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("(b) Father’s / Husband’s Name:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantFatherNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("(c) Date / Year of Birth:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantDOBController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("(d) Nationality:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantNationalityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("(f) Occupation:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantOccupationController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text("(g) Address:"),
          const SizedBox(height: 4.0),
          TextField(
            controller: complainantAddressController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsOfAccused() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: detailsOfAccusedController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText:
              "Details of known / suspected / unknown / accused with full particulars",
        ),
      ),
    );
  }

  Widget _buildDescriptionofCrime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: reasonsForDelayController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Description of Crime in detail",
        ),
      ),
    );
  }

  Widget _buildPropertiesStolen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: propertiesStolenController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Particulars of properties stolen / involved",
        ),
      ),
    );
  }

  @override
  void dispose() {
    sectionsController.dispose();
    occurrenceDayController.dispose();
    occurrenceDateController.dispose();
    occurrenceTimeController.dispose();
    infoReceivedDateController.dispose();
    infoReceivedTimeController.dispose();
    diaryReferenceEntryController.dispose();
    diaryReferenceTimeController.dispose();
    placeDirectionController.dispose();
    placeBeatNoController.dispose();
    placeAddressController.dispose();
    placeOutsideStationController.dispose();
    placeOutsideDistrictController.dispose();
    complainantNameController.dispose();
    complainantFatherNameController.dispose();
    complainantDOBController.dispose();
    complainantNationalityController.dispose();

    complainantOccupationController.dispose();
    complainantAddressController.dispose();
    detailsOfAccusedController.dispose();
    reasonsForDelayController.dispose();
    propertiesStolenController.dispose();
    super.dispose();
  }
}
