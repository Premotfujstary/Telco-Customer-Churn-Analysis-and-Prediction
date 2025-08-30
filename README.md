# Telco Customer Churn Analysis and Prediction

## Overview
This project analyzes customer churn using the **Telco Customer Churn Dataset**.  
It demonstrates the **end-to-end data lifecycle**:

1. **SQL Server (SSMS)** → Data Cleaning & Preparation  
2. **Python** → Exploratory Data Analysis (EDA) & Machine Learning  
3. **Power BI** → Business Dashboard for actionable insights  

The aim is to understand drivers of churn, build predictive models, and visualize business insights in a professional dashboard.  

---

## Dataset
- Total Records: **7043 customers**  
- Columns: **23 features** including demographics, subscription details, billing, and churn status  

**Key columns include:**  
- `gender`, `SeniorCitizen`, `Partner`, `Dependents`  
- `tenure`, `TenureBucket`, `Contract`, `InternetService`, `PaymentMethod`  
- `MonthlyCharges`, `TotalCharges`  
- `Churn`, `ChurnFlag`  

---

## Project Workflow

### 1. Data Cleaning (SQL Server)
Performed in **Microsoft SQL Server Management Studio (SSMS)**  

- Removed **duplicates** and handled **11 null values in TotalCharges**  
- Replaced `"No internet service"` / `"No phone service"` → `"No"`  
- Added **calculated columns**:  
  - `TenureBucket` → Groups tenure into bins (0–12, 12–24, 25–48, 49–60, 60+)  
  - `ChurnFlag` → Binary (1 = Churn, 0 = Not Churn)  
- Created **clean view**:  
  - `vw_CustomerChurn_Clean` for BI and ML pipelines  

---

### 2. Exploratory Data Analysis (Python)
Tools: **Pandas, Matplotlib, Seaborn**  

- **Churn Distribution** → 26.54% customers churned  
- **Churn by categories**:  
  - Month-to-month contracts → Highest churn  
  - Senior citizens → Higher churn than non-seniors  
  - Fiber optic users → More prone to churn  
  - Electronic check → Strong churn indicator  

**Sample Visuals (Python EDA):**  
- Bar plots for churn distribution  
- Churn % by contract, tenure, payment method  

---

### 3. Machine Learning (Python)
Models trained with **Scikit-learn**  

**Logistic Regression**  
- Accuracy: **77%**  
- ROC-AUC: **0.799**  
- Struggles with recall for churned customers  

**Random Forest Classifier**  
- Accuracy: **79%**  
- ROC-AUC: **0.816**  
- Better recall & feature importance ranking  

**Top Features Driving Churn:**  
1. TotalCharges  
2. MonthlyCharges  
3. Tenure  
4. Contract Type  
5. Payment Method  

---

### 4. Power BI Dashboard – Customer Churn Overview
Interactive dashboard using **`vw_CustomerChurn_Clean`**  

**KPIs**  
- **Total Customers:** 7043  
- **Churned Customers:** 1869  
- **Churn Rate:** 26.54%  
- **Average Monthly Charges:** $64.76  
- **Total Revenue:** $16.06M  

**Sections**  

1. **Demographics by Gender**  
   - Churned customers split by Male/Female  
   - Senior citizens %, Partners %, Dependents %  
   - Subscription time (Tenure Buckets)  

2. **Subscribed Services**  
   - Tech Support, Streaming TV, Streaming Movies  
   - Device Protection, Online Backup, Online Security  
   - Phone Service & Multiple Lines  
   - Internet Service (Fiber Optic, DSL, No Service)  

3. **Customer Account Information**  
   - Payment Methods (Electronic check, Mailed, Bank Transfer, Credit Card)  
   - Paperless Billing (Yes/No)  
   - Avg Monthly & Total Charges  
   - Contract Types (Month-to-Month, One Year, Two Year)  

---

## Tools and Technologies
- **SQL Server (SSMS)** → Data Cleaning, Transformation, Views  
- **Python (Jupyter Notebook)** → Pandas, Matplotlib, Seaborn, Scikit-learn  
- **Power BI** → Dashboarding & Data Visualization  

---

## Key Insights
- Customers with **month-to-month contracts** churn more than yearly contracts  
- **Electronic check** users are at high churn risk  
- **Fiber optic customers** churn more compared to DSL users  
- **Short tenure** customers are most likely to churn  
- Retention can be improved by:  
  - Encouraging long-term contracts  
  - Incentives for secure payment methods  
  - Focused offers for fiber optic customers  


