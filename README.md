**🚨 SANKET App**
Real-Time Alerts for Safe Water & Safer Communities

**📌 Overview**

**SANKET** is a smart community health monitoring and early warning mobile application designed to prevent water-borne disease outbreaks in rural and flood-prone regions of India.

The app acts as the human interface layer of the SANKET ecosystem—bridging villagers, ASHA workers, and health authorities with real-time data, alerts, and decision-making tools.

Built in alignment with Viksit Bharat 2047, the SANKET App transforms reactive healthcare into predictive, preventive public health governance.

**🎯 Problem Statement**

Every year, rural India—especially flood-prone regions—faces recurring outbreaks of:

Diarrhea

Cholera

Hepatitis

Dysentery

The root causes are:

Contaminated water sources

Manual, delayed testing

Fragmented health reporting

Absence of early-warning systems

Limited last-mile communication

By the time outbreaks are officially detected, lives are already lost and health systems are overwhelmed.

💡 Solution: The SANKET App

The SANKET App enables real-time community-level health intelligence by combining:

📱 Mobile-based symptom reporting

💧 Water safety alerts

🤖 AI-powered outbreak prediction

📊 Data-driven dashboards for authorities

🌐 Offline-first & multilingual design

It empowers communities to act before an outbreak spreads, not after.

🧩 Role of the App in the SANKET Ecosystem

The SANKET ecosystem consists of:

IoT water quality sensors

Manual water testing kits

AI/ML prediction engine

Web dashboards for officials

SANKET Mobile App (this repository)

The app is the primary data collection and alert delivery channel, especially critical in rural and low-connectivity environments.

✨ Key Features
🔔 Real-Time Alerts

Instant notifications for unsafe water

Early outbreak risk warnings

Preventive advisories (boil water, chlorination, ORS use)

📝 Community Health Reporting

Symptom reporting by villagers

Structured case reporting by ASHA workers

Geo-tagged and time-stamped entries

🌍 Localized Risk Mapping

Village-level and ward-level risk visibility

Hotspot identification

Area-specific advisories

🧑‍⚕️ ASHA Worker–Friendly Interface

Simple, low-learning-curve UI

Incentive-linked reporting support

Field-usable in low-end devices

📡 Offline-First Architecture

Works without continuous internet

Automatic sync when connectivity returns

SMS fallback support (where required)

🌐 Multilingual Ready

Designed for Indian regional languages

Ensures inclusivity and adoption

🛠️ Technology Stack
📱 Mobile Application

Framework: Flutter

Language: Dart

Platforms: Android (Primary), iOS (Extendable)

☁️ Backend & Cloud

Firebase (Auth, Sync, Notifications)

Google Cloud Platform (Compute Engine)

🤖 AI / ML Integration

Python-based prediction models

Health + water data fusion

Risk scoring & hotspot prediction

🗄️ Database

Firebase / Cloud Datastore

Secure, scalable, time-series ready

🔄 App Workflow

Water Data Collection

IoT sensors & manual test kits feed water quality data into the system

Community Symptom Reporting

Villagers & ASHAs report symptoms via the app

Cloud Synchronization

Data stored securely and synced in real time / delayed sync

AI-Based Risk Analysis

Models analyze combined health + water indicators

Alert Generation

Notifications sent to:

Citizens

ASHA workers

Local health authorities

Preventive Action

Rapid response before outbreak escalation

🧪 Use Cases

Flood-prone rural villages

Tea estate communities

Tribal and remote habitations

Areas under Jal Jeevan Mission rollout

PHC and district health monitoring

🧭 Alignment with National Missions

The SANKET App directly supports:

🇮🇳 Viksit Bharat 2047

🚰 Jal Jeevan Mission

🏥 National Health Mission

💻 Digital India

🌍 UN SDGs

SDG 3: Good Health & Well-Being

SDG 6: Clean Water & Sanitation

SDG 11: Sustainable Communities

📊 Impact

⏱️ Faster outbreak detection

❤️ Lives saved through prevention

💰 Reduced healthcare expenditure

👩‍⚕️ Empowered ASHA network

🏡 Healthier rural communities

📈 Data-driven governance

🚀 Installation & Setup (Developer)
# Clone repository
git clone https://github.com/<your-org>/sanket-app.git

# Navigate to project
cd sanket-app

# Install dependencies
flutter pub get

# Run app
flutter run


⚠️ Firebase & GCP credentials must be configured separately.

🔐 Data Privacy & Ethics

No unnecessary personal data collection

Health data protected with secure authentication

Designed for ethical, public-interest use

Supports government data governance frameworks

🧑‍🤝‍🧑 Team

Team Debugging Earth

Harshit Borana – Team Lead

Nitin Purohit – IoT & Hardware

Dr. Mayank Patel – Mentor

🤝 Contributions & Partnerships

We welcome:

Government pilots

NGO collaborations

CSR partnerships

Research institutions

Open-source contributors

📩 For collaboration, reach out via the project repository or official contact channels.

📄 References

National Health Mission (IDSP)

Jal Jeevan Mission

NFHS-5 Survey

ICMR & WHO WASH studies

Regional outbreak case studies in Northeast India

(Project concept and technical details are based on the official SANKET project documentation and Hack for Social Cause submissions.)

🌱 Final Note

SANKET is not just an app.
It is a signal of a smarter, healthier, and more prepared Bharat.

Prevent. Predict. Protect.
Towards Viksit Bharat 2047. 🇮🇳
