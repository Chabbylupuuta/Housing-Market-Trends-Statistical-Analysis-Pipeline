# 🏘️ Housing Market Trends & Statistical Analysis Pipeline

[![R Version](https://img.shields.io/badge/R-%E2%89%A54.0-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)]()

> A complete, reproducible R pipeline that loads real housing market data, performs statistical analysis, and generates professional‑grade visualisations – including time series, scatter plots, donut charts, histograms, and regional area charts.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Dataset](#-dataset)
- [Pipeline Steps](#-pipeline-steps)
- [Outputs](#-outputs)
---

## 🎯 Overview

This project demonstrates a **production‑ready analytical pipeline** in R for the housing market. It:

- Loads real (or synthetic) housing transaction data from a CSV file.
- Computes descriptive statistics, volatility, and interest‑rate correlations.
- Creates **five high‑resolution visualisations** saved to a `pictures/` folder.
- Is fully reproducible and can be adapted to any similar real‑estate dataset.

---

## ✨ Features

- ✅ **Automated statistical profiling** – mean, standard deviation, volatility, correlation.
- ✅ **Time series line chart** – median price trends over the full date range.
- ✅ **Scatter plot with regression** – price vs. sales volume with confidence band.
- ✅ **Donut chart** – market share by region.
- ✅ **Histogram** – distribution of sales volumes.
- ✅ **Stacked area chart** – regional sales volume over time.
- ✅ **High‑resolution exports** – all plots saved as PNG files.

---

## 📊 Dataset

The input file `real_housing_data.csv` contains monthly housing market data with the following columns:

| Column | Description |
|--------|-------------|
| `Date` | Transaction month (YYYY‑MM‑DD) |
| `MedianPrice` | Median sale price ($) |
| `SalesVolume` | Number of transactions |
| `InterestRate` | Average mortgage interest rate (%) |
| `NumberOfListings` | Active listings |
| `MedianDaysOnMarket` | Days from listing to sale |
| `MedianSquareFeet` | Median property size (sq ft) |
| `Region` | North / South / East / West |
| `MedianPricePerSqFt` | Price per square foot ($) |

> A **sample CSV file** (`real_housing_data.csv`) is included in this repository – it contains realistic data from 2010 to 2020, including the COVID‑19 market dip and recovery.

---

## 🔧 Pipeline Steps

The R script `housing_analysis_real.R` executes the following steps:

### 1. Load Libraries
```r
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
