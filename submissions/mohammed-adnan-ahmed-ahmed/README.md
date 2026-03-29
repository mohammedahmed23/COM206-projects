# Safelink Documentation for midterm

---

## Page 1 – Cover Page

Student name (Mohammed Adnan Ahmed Ahmed)  
Student number (250417811)  
Lesson name and number (COMP_206)  

---

## Page 2 – Introduction

### Project Title:
SafeLink: A mobile platform designed for secure link analysis and verification.

### Research Question / Problem Statement:
With the increasing number of phishing attacks and malicious links, internet users get phished  
by fake links that can copy legit websites and attract them to enter sensitive information like log  
in credentials, or bank account information. I have developed this application to allow users to  
validate Urls.

### Objective of the Project:
The objective of this project is to develop a Flutter based mobile application that allows users to  
input or paste a URL and analyze it for potential security threats.

### Expected Outcome:
A fully functional Flutter mobile application that:

- Accepts user input (URL)  
- Analyzes the link using predefined rules  
- Displays whether the link is safe or suspicious  
- Provides a clean and responsive user interface  

---

## Page 3 – Methodology

### Approach to Problem Solving:
The program works in 3 main structure:

- Home page: this is where users first interactions happen, it is a simple UI where users input  
  their Urls and press a button to check it.  

- Backend: this is behind the scene where a predefined rule based program (Analyzer) works.  
  It analyzes the url based on the rules, it gives a safety rate followed with a recommendation.  

- Result screen: this is the second and last UI that the user can see that gives the result of the  
  analyzer in a clean structured way.  

---

### Application Flow (SafeLink App):


1. Start application
2. Display main screen (input field + analyze button)
3. User enters URL
4. User clicks “Analyze”
5. Application processes the URL
   ○ Validate format
   ○ Check against rules
6. Display result:
   ○ Safe
   ○ Suspicious
7. Allow user to analyze another link