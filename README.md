# Transcript Generator
The Transcript Generator is a Python-based Streamlit application that allows college students to connect to a MySQL database and generate transcripts for all semesters. The students can authenticate using their credentials and retrieve their academic details such as grades and SPI/CPI.

## Features
* Connect to a MySQL database with user credentials.
* Retrieve student transcripts based on roll number, semester, or year.
* View academic data like grades, SPI (Semester Performance Index), and CPI (Cumulative Performance Index).

## Tech Stack
* **Python** for the backend logic.
* **MySQL** for the database storage of student and course information.
* **Streamlit** for creating the user interface.

## Prerequisites
Ensure you have the following installed:

* Python 3.x
* MySQL Server and Workbench
* pip (Python package manager)

## Instructions for Local Setup
Follow these steps to set up the project locally:

1. Clone the Repository
   
   ```bash
   git clone https://github.com/TechBot505/Automatic-Transcript-Generator
   ```
   
2. Create a Virtual Environment
   
   ```bash
   python -m venv venv
   ```

3. Activate the Virtual Environment
   
   * On Windows
     
     ```bash
     venv\Scripts\activate
     ```
     
   * On Linux/macOs
     
     ```bash
     source venv/bin/activate
     ```
     
4. Install the Required Dependencies
   
   ```bash
   pip install -r requirements.txt
   ```
   
5. Run the Application
   
   ```bash
   streamlit run main.py
   ```

## Setting Up MySQL Database
1. Open the MySQL Command Line Client (or MySQL Workbench).
2. Ensure your MySQL server is running.
3. Login to the database:
   
   ```bash
   mysql -u <your-username> -p
   ```
   
4. Use the database where student data is stored:
   
   ```bash
   USE <database_name>;
   ```
