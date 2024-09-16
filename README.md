# Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits

This repo compliments my Dreamforce 2024 session, Three Things About Extending Data Cloud with Data Kits and aims to provide a hands on example for folks looking to see deployed Data Kits in action or to build their first second generation managed package with Data Kits.

## Contents

- [Dreamforce '24 - Three Things About Extending Data Cloud with Data Kits](#dreamforce-24---three-things-about-extending-data-cloud-with-data-kits)
  - [Contents](#contents)
  - [Introduction](#introduction)
    - [Two ways to use this repo](#two-ways-to-use-this-repo)
  - [Demo](#demo)
    - [Demo Prerequisites](#demo-prerequisites)
    - [Clone repo and Install Dependencies](#clone-repo-and-install-dependencies)
    - [Deploy Volunteer Events App](#deploy-volunteer-events-app)
      - [Install Base App](#install-base-app)
      - [Install Data Cloud Package](#install-data-cloud-package)
      - [Install Data Cloud Extension](#install-data-cloud-extension)
    - [Import Data](#import-data)
    - [Deploy Data Kit \& Ingest Data](#deploy-data-kit--ingest-data)
    - [Add Data Cloud LWC to Record Page](#add-data-cloud-lwc-to-record-page)
  - [Create Your own Second Generation Managed Package with Data Cloud](#create-your-own-second-generation-managed-package-with-data-cloud)
    - [2GP Prerequisites](#2gp-prerequisites)
    - [Setup](#setup)
      - [Renamespace Repo Contents](#renamespace-repo-contents)
      - [Create Scratch Org](#create-scratch-org)
    - [Deploy App](#deploy-app)
      - [Deploy Base App](#deploy-base-app)
      - [Update System Admin \& Data Cloud Salesforce Connector Perms](#update-system-admin--data-cloud-salesforce-connector-perms)
      - [Deploy Data Cloud Metadata in the form of a Data Kit](#deploy-data-cloud-metadata-in-the-form-of-a-data-kit)
      - [Deploy Data Cloud Extension Package](#deploy-data-cloud-extension-package)
    - [Create Packages](#create-packages)
      - [Base App (force-app)](#base-app-force-app)
      - [Data Cloud App (data-app)](#data-cloud-app-data-app)
      - [Data Cloud App Extension (data-app-ext)](#data-cloud-app-extension-data-app-ext)
    - [Package Deployment](#package-deployment)
  - [Resources](#resources)
  - [Requesting Data Cloud Scratch Org Access](#requesting-data-cloud-scratch-org-access)
  - [FAQ](#faq)

## Introduction

The repo is comprised of three parts:

1. Base Salesforce Platform app (`force-app`)
2. Data Cloud Data Kit to consume platform app data (`data-app`)
3. Data Cloud Extension package containing LWC's that consume Data Cloud data (`data-app-ext`)

### Two ways to use this repo

1. [Demo](#demo) - Deploy the packages in sequence into a Data Cloud-enabled org and observe functionality.
2. [Create Your own Second Generation Managed Package with Data Cloud](#create-your-own-second-generation-managed-package-with-data-cloud) - Build your first 2GP managed package with Data Cloud using this repo as a starting point

## Demo

### Demo Prerequisites

- Org containing Data Cloud
- Salesforce CLI

### Clone repo and Install Dependencies

`git clone git@github.com:forcedotcom/df24-dc-three-things.git`

`cd df24-dc-three-things`

`npm i`

### Deploy Volunteer Events App

#### Install Base App

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAndIAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAndIAE)

or

`sf package install -p 04tHs000000mAndIAE -w 10 -o {ALIAS}`

#### Install Data Cloud Package

Before installing, update the Data Cloud Salesforce Connector permission set. Grant View All at the object level and Read access to all fields.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

Install package

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAniIAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAniIAE)

or

`sf package install -p 04tHs000000mAniIAE -w 10 -o {ALIAS}`

#### Install Data Cloud Extension

[https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAo7IAE](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tHs000000mAo7IAE)

or

`sf package install -p 04tHs000000mAo7IAE -w 10 -o {ALIAS}`

### Import Data

The next steps use the Salesforce CLI to import data. Set your install org as the default target org in config.

`sf config set target-org={ALIAS}`

Import Contacts and Volunteer Event records into the org.

`sf data import tree -p data/Contact-Volunteer_Event__c-plan.json`

Create many to many association between Contact and Event Volunteer objects.

`npm run addParticipants`

If you ever need to start from scratch with the data, run `npm run deleteVolunteerData`. This will delete all Contact, Volunteer Event, and Volunteer Event Participant records.

### Deploy Data Kit & Ingest Data

The contents of the Data Kit will now be deployed into Data Streams, Data Lake Objects, and Data Model Objects.

- Open your org
- Go to Data Cloud App > Data Stream > New
- Pick Connected Sources, Salesforce CRM, Next
- Pick VolunteerEventBundle, Next
- Keep default values, Next
- Deploy

Once the Data Streams are deployed, trigger a refresh of the data to consume the rows you inserted into CRM in the prior step.

- From Data Streams tab, click `mvpbo3__Volunteer_Event_Participant_Home`
- Click "Refresh Now" button
- Go back to Data Streams tab, click `mvpbo3__Volunteer_Event_Home`
- Click "Refresh Now" button

While the data gets ingested, go to Data Model and see the two new Data Model objects that have been deployed.

### Add Data Cloud LWC to Record Page

The last step is to place the LWC from the `df24ThreeThingsDCExt` package onto the Volunteer Event Participant flexipage.

- Go to App Picker > Volunteer Events
- Click Volunteer Event tab > click on any Volunteer Event record
- Click Setup > Edit Page
- Pick the veNewRegistrants component from the Components tab and drag it onto the flexipage.
- Save, Activate the page and assign as org default for desktop and phone. Click Next then Save
- The component pulls in data from the Volunteer Event Participant DMO and displays it via LWC on your record page.

## Create Your own Second Generation Managed Package with Data Cloud

Before getting into packaging, we will first install the app into a scratch org to observe the app. Afterwards, we will step through the packaging process for each of the three packages.

### 2GP Prerequisites

- Salesforce CLI
- Data Cloud for Scratch Orgs enabed DevHub. Instructions to request this feature are at [Requesting Data Cloud Scratch Org Access](#requesting-data-cloud-scratch-org-access).
- A namespace org associated to your DevHub

### Setup

Clone, install dependencies, and set config

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

### Deploy App

#### Deploy Base App

Deploy the base app into your `df24ThreeThings` scratch org. Data Cloud is actively being provisioned on the org which may delay the install of `force-app` files.

`sf project deploy start -w 10 -d force-app`

#### Update System Admin & Data Cloud Salesforce Connector Perms

Update the System Admin profile and Data Cloud Salesforce Connector permission set. The following script grants View All at the object level and Read access to all fields contained within the base app.

`sf apex run -f scripts/apex/updateDCConnectorPerms.apex`

Grant App Visibility to System Admin profile

- Setup > Profiles > System Admin > Edit
- Check Visibile checkbox for Volunteer Events custom app
- Save

Grant Object Permissions for System Admin profile

- Setup > Profiles > System Admin
- Grant View All/ Modify All to `{NAMESPACE}__Volunteer_Event__c` & `{NAMESPACE}__Volunteer_Event_Participant__c`
- Grant Edit permissions to all fields
- Save

Install Sales Cloud Data Bundle

- Data Cloud Setup > Salesforce CRM > Sales Cloud
- Click Drop Down Arrow, Click Install
- Install for Admins Only

#### Deploy Data Cloud Metadata in the form of a Data Kit

`sf project deploy start -w 10 -d data-app`

#### Deploy Data Cloud Extension Package

`sf project deploy start -w 10 -d data-app-ext`

With the app deployed, you can optionally import and ingest data by following the steps listed in [Import Data](#import-data) and the subsequent [Deploy Data Kit \& Ingest Data](#deploy-data-kit--ingest-data) section. Once complete, continue by creating the packages.

### Create Packages

The repo contains `packageAliases` within `sfdx-project.json` which may interfere with the creation of your packages. Delete all entries in `packageAliases` before creating packages from scratch.

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

Use CLI-based instructions in [Deploy Volunteer Events App](#deploy-volunteer-events-app)

## Resources

- [Workflow for Data Cloud Second-Generation Managed Packages](https://developer.salesforce.com/docs/platform/data-cloud-dev/guide/data-cloud-2gp-workflow.html)
- [Partner Community - Data Cloud for ISVs](https://partners.salesforce.com/_ui/core/chatter/groups/GroupProfilePage?g=0F94V000000g2wj)

## Requesting Data Cloud Scratch Org Access

**Note:** This is a partner-only feature.

To have Scratch orgs enabled with Data Cloud, please submit a case to have the feature enabled in your DevHub org (Typically your Partner Business Org). Please note, Data Cloud licenses will not appear in your PBO, instead, you will be able to create scratch orgs with Data Cloud enabled.

> **Case Details**
>
> _Product_: Partner Programs & Benefits
>
> _Topic_: License Request - Prod Org
>
> _Subject_: “Enable Data Cloud for Scratch orgs in dev hub”
>
> _Body_: “Please enable Data Cloud Scratch Org permissions on my Partner Business Org, OrgId: XXX.”


Once submitted, permissions will be granted to your org within 3-5 business days.

## FAQ

I tried creating a scratch org but I got error code `VR-0003`.

- Your devHub org is already on the release preview and you can remove `"release": "preview"` from `config/project-scratch-def.json`. Reference [forcedotcom/cli/#1022](https://github.com/forcedotcom/cli/issues/1022)

When deploying my renamespaced `data-app` folder, it failed and reported the following error `Error Volunteer_Event_Participant_Home__dlm.rel_1725930000724_end__c Value too long for field: MasterLabel maximum length is:40`

- Open `data-app/objects/Volunteer_Event_Participaant__c/fields/rel_1725930000724_end__c.field-meta.xml`. Shorten the `<label>` and `<relationshipLabel>` to 40 character or less.

```diff
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
     <fullName>rel_1725930000724_end__c</fullName>
     <deleteConstraint>SetNull</deleteConstraint>
-    <label>mvpbo3_Volunteer_Event_Participant_H_rel</label>
+    <label>mvoriginalNS_Vol_Event_Participant_H_rel</label>
     <referenceTo>Volunteer_Event_c_Home__dlm</referenceTo>
-    <relationshipLabel>mvpbo3_Volunteer_Event_Participant_H_rel</relationshipLabel>
+    <relationshipLabel>mvoriginalNS_Vol_Event_Participant_H_rel</relationshipLabel>
     <relationshipName>rel_1725930000724_end</relationshipName>
     <required>false</required>
     <type>Lookup</type>
```