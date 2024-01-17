import 'package:flutter/material.dart';

class FIRForm extends StatefulWidget {
  const FIRForm({Key? key}) : super(key: key);

  @override
  State<FIRForm> createState() => _FIRFormState();
}

class _FIRFormState extends State<FIRForm> {
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
              _buildTitle("1. Dist. … P.S… Year… F.I.R. No… Date…"),
              _buildTitle("2. Act and Sections"),
              _buildActAndSections(1),
              _buildActAndSections(2),
              _buildActAndSections(3),
              _buildOtherActsAndSections(),
              _buildTitle("3. (a) Occurrence of Offence: Day… Date… Time…"),
              _buildOccurrenceOfOffence(),
              _buildTitle("3. (b) Information received at P.S. Date… Time…"),
              _buildInformationReceivedAtPS(),
              _buildTitle("3. (c) General Diary Reference: Entry No(s)… Time…"),
              _buildGeneralDiaryReference(),
              _buildTitle("4. Type of information: *Written / Oral"),
              _buildTitle("5. Place of occurrence:"),
              _buildPlaceOfOccurrence(),
              _buildTitle("6. Complainant / information:"),
              _buildComplainantInformation(),
              _buildTitle(
                  "7. Details of known / suspected / unknown / accused with full particulars:"),
              _buildDetailsOfAccused(),
              _buildTitle(
                  "8. Reasons for delay in reporting by the complainant / Informant"),
              _buildReasonsForDelay(),
              _buildTitle("9. Particulars of properties stolen / involved:"),
              _buildPropertiesStolen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _buildActAndSections(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("(${index}) *Act:"),
          const SizedBox(width: 8.0),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          const Text("*Sections:"),
          const SizedBox(width: 8.0),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherActsAndSections() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          labelText: "(iv) *Other Acts & Sections",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildOccurrenceOfOffence() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("(a) Day:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text("Date:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text("Time:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationReceivedAtPS() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("(b) Information received at P.S. Date:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text("Time:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralDiaryReference() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("(c) General Diary Reference: Entry No(s):"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text("Time:"),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOfOccurrence() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("(a) Direction and Distance from P.S.:"),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text("Beat No.:"),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text("(b) Address:"),
          SizedBox(height: 4.0),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
              "(c) In case outside limit of this Police Station, then the name of P.S.:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("District:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplainantInformation() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("(a) Name:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("(b) Father’s / Husband’s Name:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("(c) Date / Year of Birth:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("(d) Nationality:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("(e) Passport No: Date of Issue: Place of Issue:"),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text("(f) Occupation:"),
          SizedBox(height: 4.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8.0),
          Text("(g) Address:"),
          SizedBox(height: 4.0),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsOfAccused() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText:
              "Details of known / suspected / unknown / accused with full particulars",
        ),
      ),
    );
  }

  Widget _buildReasonsForDelay() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText:
              "Reasons for delay in reporting by the complainant / Informant",
        ),
      ),
    );
  }

  Widget _buildPropertiesStolen() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Particulars of properties stolen / involved",
        ),
      ),
    );
  }
}
