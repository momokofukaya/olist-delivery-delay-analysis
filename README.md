# Olist E-Commerce | Delivery Delay Analysis

An exploratory analysis of delivery delays in Olist's Brazilian e-commerce dataset, using SQL (DuckDB) and Tableau.

The project examines how frequently deliveries were late, how long delays lasted, and how delivery performance varied across months and Brazilian states.

## Interactive Dashboards

The analysis is presented in two Tableau dashboards:

- **[1. Delivery Performance Overview](https://public.tableau.com/app/profile/momoko.fukaya/viz/Book2_17935203435780/Dashboard1DeliveryPerformanceOverview)** — Overall late-delivery rate, delay duration distribution, and monthly trends.
- **[2. Regional Delivery Investigation](https://public.tableau.com/app/profile/momoko.fukaya/viz/Book2_17935203435780/Dashboard2RegionalDeliveryInvestigation)** — Geographic distribution of late orders and comparison of states by late-delivery rate and count.

## Data and Methods

**Dataset:** Brazilian E-Commerce Public Dataset by Olist, available on [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

**Tools:** DuckDB (SQL), Tableau Public.

The main analysis includes 96,470 delivered orders with non-missing actual and estimated delivery dates.

An order was classified as late when its actual delivery date was later than its estimated delivery date, comparing dates rather than timestamps.

SQL was used to check data quality, calculate delivery metrics, and aggregate results by order month and customer state. The aggregated outputs were then visualized in Tableau.

## Main Findings

- **Overall performance:** 6,534 of 96,470 eligible orders were delivered late (6.77%).
- **Delay duration:** Among late orders, the median delay was 7 days, while the 90th percentile was 22 days.
- **Monthly variation:** Late-delivery rates varied over time, with notable increases in late 2017 and early 2018.
- **Regional differences:** São Paulo (SP) had the largest number of late orders (1,820), while Rio de Janeiro (RJ) combined a relatively high late-delivery rate (12.11%) with a substantial number of late orders (1,495). Alagoas (AL) had a high late-delivery rate (21.41%), but a smaller number of affected orders (85).

These findings suggest that states may warrant different levels of attention depending on whether the priority is reducing the number of late orders or investigating high late-delivery rates.

## Limitations

This is a descriptive analysis. It identifies differences in delivery performance but does not establish their causes.

The dataset used here does not provide sufficient information about actual shipping routes, carrier performance, or how estimated delivery dates were determined.

Further operational data would be needed to investigate the reasons behind the observed patterns and evaluate potential improvements.

## SQL Files

| File | Purpose |
|---|---|
| `00_load_data.sql` | Load the source CSV files into DuckDB views |
| `01_data_quality.sql` | Check order counts, statuses, identifiers, and missing delivery dates |
| `02_delivery_overview.sql` | Calculate overall delay metrics and delay-duration distribution |
| `03_regional_analysis.sql` | Compare delivery performance across customer states |
| `05_monthly_analysis.sql` | Examine monthly delivery volume and late-delivery rates |

## Data Source and Reproduction

The original dataset is available on Kaggle: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

Raw data files are not included in this repository.

To reproduce the SQL analysis:

1. Download the dataset from Kaggle.
2. Create a `data/` folder in the project directory.
3. Place the required CSV files in that folder:
   - `olist_orders_dataset.csv`
   - `olist_customers_dataset.csv`
   - `olist_order_items_dataset.csv`
   - `olist_sellers_dataset.csv`
4. Run `00_load_data.sql` in DuckDB to create the source views.
5. Execute the remaining SQL scripts for the corresponding analyses.

The Tableau dashboards were created using exported aggregate results.
