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
![Screenshot_20240911_132415](https://github.com/user-attachments/assets/38eacfea-b7d4-4ab3-9df7-9c47a2e044ef)


### Glucose
View blood glucose sampling history, with the possibility of adding more.
![Screenshot_20240911_132437](https://github.com/user-attachments/assets/a81ba017-1048-40c3-a329-1c9a11b61c3b)


### Bread units
View meal history, with the ability to add more.
![Screenshot_20240911_132454](https://github.com/user-attachments/assets/9f5d2d46-9d0e-4893-b681-a0da3282c4ba)


### Insulin
View insulin injection history, with the option to add more.
![Screenshot_20240911_132509](https://github.com/user-attachments/assets/830d0527-4c4e-4c5d-b40f-36713fe700f3)


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
![image](https://github.com/user-attachments/assets/3b8f39eb-1825-44dc-8685-ec1b2ffa8e25)


