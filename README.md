# 🎵 Music Store SQL Data Analysis

## 📌 Project Overview
This project analyzes a music retail store's relational database (Chinook-style schema) 
to answer real business questions around revenue, customer behavior, and music trends. 
The goal was to practice writing production-style SQL — from simple aggregations to 
advanced window functions and CTEs

## 🎯 Business Problem
The music store's wants to:
- Identify top-performing markets and customers to guide a promotional campaign
- Understand which genres and artists drive the most engagement
- Segment customer spending patterns by country and genre

- 
## 🗂️ Dataset
- **Source:** Chinook Database (sample music store database)
- **Tables used:** `employee`, `customer`, `invoice`, `invoice_line`, `track`, 
  `album`, `artist`, `genre`
- **Size:** ~11 tables, covering employees, customers, invoices, tracks, and genres

- ## 🛠️ Tools & Skills Used
- SQL (MySQL)
- Joins (INNER, LEFT), Subqueries, CTEs, Window Functions (RANK, DENSE_RANK)
- Aggregations (SUM, COUNT, AVG) and GROUP BY with tie-handling logic

- ## 📁 Repository Structure
''' 
Music-Store-SQL-Analysis/
├── MusicStore_Dataset.zip
├── README.md
├── insights.md
├── Schema.png
└── queries/
├── 01_easy_questions.sql
├── 02_moderate_questions.sql
└── 03_advanced_questions.sql
'''

## 🔍 Business Questions Solved
**Easy:** Senior-most employee, top invoice countries, top invoice values,
best city, best customer

**Moderate:** Rock music listener segmentation, top rock artists, 
above-average track lengths

**Advanced:** Customer spend by artist, top genre per country, 
top customer per country (with tie handling)

## 💡 Key Insights
See [`insights.md`](./insights.md) for detailed findings and business recommendations.



