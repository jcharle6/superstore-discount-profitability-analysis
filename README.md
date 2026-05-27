# superstore-discount-profitability-analysis
Business intelligence and retail analytics project analyzing how over-discounting affects profitability using Excel, SQL, and Tableau.
# Superstore Discount Profitability Analysis

## Overview

This project is an end-to-end retail data analysis focused on identifying how excessive discounting impacts profitability across different product categories and regions within a global superstore dataset.

Using Excel, SQL, and Tableau, the analysis explores sales trends, discount behavior, regional performance, and profit outcomes to uncover business risks and opportunities related to pricing strategy.

link to tableau interactive dashboard is [here](https://public.tableau.com/app/profile/justin.hilaire/viz/SuperStoreDiscountanalysis/Dashboard1#1)

---

## Business Problem

Retail companies often use discounts to increase sales volume and remain competitive. However, excessive discounting can negatively affect profit margins and overall business performance.

This project investigates:

* Whether high discounts lead to stronger sales performance
* Which regions and product categories are most affected by discounting
* How discount strategies influence profitability

---

## Tools & Technologies

* **Excel** — Data cleaning and preprocessing
* **SQL** — Exploratory data analysis and querying
* **Tableau** — Data visualization and dashboard creation

---

## Data Cleaning & Preparation

The dataset was cleaned and standardized before analysis:

* Converted sales and profit columns from currency format to numeric values
* Adjusted `order_id` length to prevent loading issues
* Removed duplicate rows
* Checked for missing values
* Standardized formatting for dates, regions, and numerical fields

---

## Exploratory Data Analysis

### Discount Patterns

* Furniture products had the highest average discounts
* Tables reached discounts as high as **29%**
* Other categories averaged around **14–16%**

### Key Observation

Heavy discounting was concentrated within furniture products, particularly tables, suggesting aggressive promotional pricing that may reduce profitability.

---

## Product-Level Insights

* Higher discounts occasionally increased sales volume
* However, profit margins frequently declined as discounts increased
* Discount strategies varied even within the same category, indicating inconsistent pricing approaches

---

## Regional Performance Analysis

### Strong Performing Regions

| Region            | Observation                                  |
| ----------------- | -------------------------------------------- |
| Southeastern Asia | Strong sales with balanced discount strategy |
| Eastern Africa    | High sales and positive overall contribution |

### Underperforming Regions

| Region         | Observation                |
| -------------- | -------------------------- |
| Western Asia   | Significant negative sales |
| Western Africa | high sales, negative profit|

## Tableau Dashboard
<img width="1838" height="768" alt="Dashboard 1 (4)" src="https://github.com/user-attachments/assets/ea99896a-c93c-42e5-bca8-adc82d4cf67d" />

