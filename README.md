# Diabetes Diary App

## Description of the specifications
The app is to become a diabetes diary for patients. Patients should be able to enter various relevant
data, which is then available to the patient as a diary in a suitable manner. It should be possible to
enter the following data:

- Blood glucose values in mmol/dl
- Insulin units of various medications
- Bread units

The app is developed from the patient's perspective. The app support one user (patient)

## App result presentation (Screenshots)
### Dashboard
on the dashboard we have the blood sugar graph.

### Glucose
View blood glucose sampling history, with the possibility of adding more.

### Bread units
View meal history, with the ability to add more.

### Insulin
View insulin injection history, with the option to add more.

# Getting Started for Dev

This project is a starting point for a Flutter application.
This is my first Flutter project (even using the dart language).
The approaches used in this project are not very professional (firstly because I am not yet comfortable with the dart language, but also because it is in this project that I am taking my first steps with Flutter)

## App Foundation
The project sources are structured like this.
* lib/helper : in this folder we have the sources of the person component (assembly of the basic Flutter components to make another one)
* lib/model : in this folder we have the file including:
  * bean.dart : Contains the implementation of the data structure that will be stored in the BDD
  * dao.dart : DAO (Data Access Object). This is the data access layer.
* lib/pages : contains the different screens of the application

## Class diagram of data structure

