# Odoo IT All Tools

A collection of tools for Odoo ERP system administration, installation, and module management.

## Overview

This repository contains scripts to automate common Odoo administration tasks:

- **Fresh Installation**: Automates the process of setting up a new Odoo instance with specified modules
- **Module Download**: Downloads external Odoo modules from Google Drive

## Requirements

- Bash shell environment
- PostgreSQL client tools
- Odoo installation
- Python virtual environment
- curl and unzip utilities

## Setup

1. Clone this repository
2. Copy the `.env.example` file to `.env`:
   ```bash
   cp .env.example .env
   ```
3. Edit the `.env` file with your specific configuration

## Configuration

The `.env` file contains all necessary configuration parameters:

| Parameter | Description |
|-----------|-------------|
| `ODOO_PATH` | Path to your Odoo installation directory |
| `ODOO_DB` | Name of the Odoo database to create/use |
| `ODOO_MODULE_NAMES` | Comma-separated list of modules to install |
| `ODOO_WITHOUT_DEMO_MODULES` | Modules for which demo data should be disabled |
| `CUSTOM_ADDONS_PATH` | Path to custom addons directory (optional) |
| `DB_HOST` | PostgreSQL database host |
| `DB_PORT` | PostgreSQL database port |
| `DB_USER` | PostgreSQL database user |
| `DB_PASSWORD` | PostgreSQL database password |
| `MODULE_FILE_DETAILS` | External modules to download (Google Drive file IDs and filenames) |

## Usage

### Fresh Installation

The `fresh_install.sh` script performs a complete fresh installation of Odoo with specified modules:

```bash
./fresh_install.sh
```

This script will:

1. Drop the existing database if it exists
2. Create a new database
3. Install specified modules without demo data
4. Configure logging
5. Generate detailed logs of the installation process

### Download External Modules

The `download_modules.sh` script downloads and extracts external modules from Google Drive:

```bash
./download_modules.sh
```

This script will:

1. Parse module file details from the `.env` file
2. Download each module from Google Drive using the provided file ID
3. Extract the downloaded zip files
4. Remove the zip files after extraction

## Logs

The installation process generates two log files:

- `fresh_install.log`: Contains detailed logs of the installation script
- `odoo.log`: Contains Odoo server logs during installation

## License

See the [LICENSE](LICENSE) file for details.