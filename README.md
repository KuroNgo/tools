# 🛠️ Ultimate Developer Toolbox & Cloud Automation

> **"The best tools are the ones that disappear into your workflow."**

This is a curated **Personal Toolbox** designed for high-performance developers. It focuses on DevOps scripts, cloud automation, and technical documentation to ensure a seamless, synchronized work environment across any machine.

---

## 🚀 Key Features

### ☁️ Cloud Operations (Powered by RClone)

* **Storage Sync:** Production-ready configurations for seamless cross-cloud data migration.
* **Automated Backup:** Smart scripts to safeguard external projects (e.g., *AgriMarket*, *Go-Templates*) to encrypted remotes.
* **Smart Mount:** One-click utilities to map Google Drive/OneDrive as local virtual drives with optimized caching.

### 📜 Technical Knowledge Base

* **Cheat Sheets:** Quick-reference guides for RClone, Git, and Backend Architecture.
* **Environment Setup:** Standardized instructions to replicate a Go/Nuxt/Flutter dev environment in minutes.

### 🤖 System Automation

* **Startup Flows:** Batch & PowerShell scripts to automate routine tasks upon Windows logon.
* **Project Maintenance:** Cleaners for `node_modules`, `vendor`, and temporary build files.

---

## 📂 Repository Map

```text
.
├── rclone/             # Cloud sync configs & Multi-language guides
├── automation/         # Windows .bat and .ps1 startup scripts
├── docs/               # Architecture notes & CLI cheat sheets
├── backups/            # Logic & lists for external project backups
└── README.md           # The entry point

```

---

## 🛠️ Usage

### Quick Setup

1. **Clone the tools:**
```bash
git clone https://github.com/your-username/your-repo-name.git

```


2. **Sync to your own Cloud:**
Replace `<your-remote>` with your RClone remote name:
```bash
rclone sync . <your-remote>:work-tools -P --exclude ".git/**"

```



---

## 🔒 Security & Privacy

* **Zero Credentials:** This repository **DOES NOT** store `.env`, `rclone.conf`, or private keys.
* **Security First:** Only logic and templates are public. All sensitive data remains in your private, encrypted storage.

---

## ✍️ About the Author

* **Name:** Phong
* **Role:** Backend Developer / Freelancer
* **Expertise:** Golang, Nuxt.js, Flutter
* **Mission:** Automating the boring stuff to build better products.
