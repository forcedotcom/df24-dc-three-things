# Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits

This repo compliments my Dreamforce 2024 session, Three Things About Extending Data Cloud with Data Kits and aims to provide a hands on example for folks looking to see deployed Data Kits in action or to build their first second generation managed package with Data Kits.

- [Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits](#dreamforce-24---three-things-about-extending-data-cloud-with-data-kits)
  - [Two ways to use this repo](#two-ways-to-use-this-repo)
  - [Installation \& Demo Instructions](#installation--demo-instructions)
  - [Demo Prerequisites](#demo-prerequisites)
    - [Deploy Volunteer Events App](#deploy-volunteer-events-app)
      - [Install Base App](#install-base-app)
      - [Install Data Cloud Package](#install-data-cloud-package)
      - [Install Data Cloud Extension](#install-data-cloud-extension)
      - [Import Data](#import-data)
  - [Create Your own Second Generation Managed Package with Data Cloud](#create-your-own-second-generation-managed-package-with-data-cloud)
    - [2GP Prerequisites](#2gp-prerequisites)
    - [Metadata Deployment Steps](#metadata-deployment-steps)
      - [Clone, Install Dependencies, Set Config](#clone-install-dependencies-set-config)
      - [Renamespace Repo Contents](#renamespace-repo-contents)
      - [Create Scratch Org](#create-scratch-org)
      - [Deploy App](#deploy-app)
      - [Deploy Namespaced Data Kit](#deploy-namespaced-data-kit)
    - [Create Packages](#create-packages)
      - [Base App (force-app)](#base-app-force-app)
      - [Data Cloud App (data-app)](#data-cloud-app-data-app)
      - [Data Cloud App Extension (data-app-ext)](#data-cloud-app-extension-data-app-ext)
    - [Package Deployment](#package-deployment)
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

#### Install Base App

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAndIAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAndIAE)

or

`sf package install -p df24ThreeThings@0.1.0-1 -w 10 -o {ALIAS}`

#### Install Data Cloud Package

Before installing, update the Data Cloud Salesforce Connector permission set. Grant View All at the object level and Read access to all fields.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

Install package

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAniIAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAniIAE)

or

`sf package install -p df24ThreeThingsDC@0.1.0-1 -w 10 -o {ALIAS}`

#### Install Data Cloud Extension

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAo7IAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAo7IAE)

or

`sf package install -p df24ThreeThingsDCExt@0.1.0-1 -w 10 -o {ALIAS}`

#### Import Data



## Create Your own Second Generation Managed Package with Data Cloud

Before getting into packaging, we will first install the app into a scratch org to observe the app. Afterwards, we will step through the packaging process for each of the three packages.

### 2GP Prerequisites

- Data Cloud for Scratch Orgs enabed DevHub

### Metadata Deployment Steps

#### Clone, Install Dependencies, Set Config

`git clone git@github.com:forcedotcom/df24-dc-three-things.git`

`cd df24-dc-three-things`

`npm i`

`sf config set target-dev-hub={YOUR DEV HUB}`

#### Renamespace Repo Contents

To use this locally with your own namespace, you must renamespace the entire project! Running the following command will prompt you for the old namespace `mvpbo3` and you can replace it with one of your choosing. A dry run mode is available if you want to preview the list of files which will have contents or filenames changed. Just remember, you can always revert with git.

`npm run renamespace`

#### Create Scratch Org

Now that we have updated filenames and file content with your namespace, we can create two scratch orgs. The first will be used to install the code while the second will act as a customer org.

Create the scratch org and set it to be the default for this project.

`sf org create scratch -d -a df24ThreeThings -f config/project-scratch-def.json -w 10 -y 30`

Create the customer org.

`sf org create scratch -a df24ThreeThingsCustomer --no-namespace -f config/project-scratch-def.json -w 10 -y 30`


#### Deploy App

Assign Volunteer Event Admin permission set

`sf org assign permset -n Volunteer_Event_Admin`

Update the Data Cloud Salesforce Connector permission set. Grant View All at the object level and Read access to all fields.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

Install Sales Cloud Data Bundle

- Data Cloud Setup > Salesforce CRM > Sales Cloud
- Click Drop Down Arrow, Click Install
- Install for Admins Only

#### Deploy Namespaced Data Kit

`sf project deploy start -w 10 -d data-app`

### Create Packages

#### Base App (force-app)

`sf package create -n df24ThreeThings -t Managed -r force-app`

`sf package version create -f config/project-scratch-def.json --installation-key-bypass -d force-app -w 10 -p df24ThreeThings`

#### Data Cloud App (data-app)

`sf package create -n df24ThreeThingsDC -t Managed -r data-app`

`sf package version create -f config/project-scratch-def.json --installation-key-bypass -w 100 -p df24ThreeThingsDC`

#### Data Cloud App Extension (data-app-ext)

`sf package create -n df24ThreeThingsDCExt -t Managed -r data-app-ext`

`sf package version create -f config/project-scratch-def.json --installation-key-bypass -w 100 -p df24ThreeThingsDCExt`

### Package Deployment

## Resources
