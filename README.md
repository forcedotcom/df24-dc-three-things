# Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits

This repo compliments my Dreamforce 2024 session, Three Things About Extending Data Cloud with Data Kits and aims to provide a hands on example for folks looking to see deployed Data Kits in action or to build their first second generation managed package with Data Kits.

- [Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits](#dreamforce-24---three-things-about-extending-data-cloud-with-data-kits)
  - [Two ways to use this repo](#two-ways-to-use-this-repo)
  - [Installation \& Demo Instructions](#installation--demo-instructions)
  - [Demo Prerequisites](#demo-prerequisites)
    - [Deploy Volunteer Events App](#deploy-volunteer-events-app)
  - [Create Your own Second Generation Managed Package with Data Cloud](#create-your-own-second-generation-managed-package-with-data-cloud)
    - [2GP Prerequisites](#2gp-prerequisites)
    - [Clone and Install Dependencies](#clone-and-install-dependencies)
    - [Renamespace Repo Contents](#renamespace-repo-contents)
    - [Deploy App](#deploy-app)
    - [Deploy Namespaced Data Kit](#deploy-namespaced-data-kit)
  - [Resources](#resources)

The repo is comprised of three parts:

1. Base Salesforce Platform app (`force-app`)
2. Data Cloud Data Kit to consume platform app data (`data-app`)
3. Data Cloud Extension package containing LWC's that consume Data Cloud Metadata (`data-app-ext`)

## Two ways to use this repo

1. Install and Demo - Deploy the packages in sequence into a Data Cloud-enabled org and observe functionality.
2. Renamespace and Create Package - Build your first 2GP managed package with Data Cloud

## Installation & Demo Instructions

## Demo Prerequisites

- Org containing Data Cloud

### Deploy Volunteer Events App

Assign Volunteer Event Admin permission set

`sf org assign permset -n Volunteer_Event_Admin`

Update the Data Cloud Salesforce Connector permission set. Grant View All at the object level and Read access to all fields.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

## Create Your own Second Generation Managed Package with Data Cloud

### 2GP Prerequisites

### Clone and Install Dependencies

`git clone XXX`

`npm i`

### Renamespace Repo Contents

`npm run renamespace`

The following files should be marked as changed in git.

### Deploy App

Assign Volunteer Event Admin permission set

`sf org assign permset -n Volunteer_Event_Admin`

Update the Data Cloud Salesforce Connector permission set. Grant View All at the object level and Read access to all fields.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

Install Sales Cloud Data Bundle

- Data Cloud Setup > Salesforce CRM > Sales Cloud
- Click Drop Down Arrow, Click Install
- Install for Admins Only

### Deploy Namespaced Data Kit

## Resources
