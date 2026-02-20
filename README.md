# snowdown_2026

# ❄️ The Great Data SnowDown
## Dataset Documentation – Winter Season 2024–2025

---

## 1. Overview

This dataset contains operational, transactional, and customer activity data from a ski resort during the **2024–2025 winter season**.

The objective of this dataset is to analyze:

- Customer behavior
- Membership value and profitability
- Discount campaign impact
- Lift utilization patterns
- Revenue performance across rentals, lift tickets, and cafés

The dataset includes both **financial transaction tables** and a **non-financial lift usage log**.

The resort operates seasonally from:

> **October 1st through March 31st**

All data in this competition falls within that operating window for the 2024–2025 winter season.

---

## 2. Membership Program

Customers may purchase a **Season Membership (Season Pass)**.

### Membership Details

- **Cost:** $2,000 per season
- **Benefits:**
  - Unlimited lift access (no per-ride charge)
  - 15% discount on:
    - Equipment rentals
    - Café purchases

### Important Rule

- A member's `member_id` is the same as their `customer_id`.
- Customer IDs that begin with `M` are members.
- Customer IDs that begin with `C` are non-members.
- Only customers who purchased a season pass appear in the `members` table.

---

## 3. Discount Campaigns

The resort offers limited-time promotional discounts on lift tickets:

| Promotion Code | Description                       | Discount |
| --- | --- | --- |
| `WELCOME50` | First week the resort is open      | 50% off |
| `MLK30` | Martin Luther King Jr. Day         | 30% off |
| `NYE20` | New Year’s Eve                      | 20% off |
| `PRESIDENT25` | Presidents Day                  | 25% off |

**Important:** All discounts are already reflected in `net_price` (i.e., the stored value represents the final amount paid after the discount is applied).

---

## 4. Data Tables

### 4.1 Table: `members`

Contains customers who purchased a season pass.

| Column Name | Description |
| --- | --- |
| `member_id` | Unique member identifier (same as customer_id) |
| `customer_id` | Unique customer identifier |
| `first_name` | Customer first name |
| `last_name` | Customer last name |
| `member_since` | Date membership became active |

---

### 4.2 Table: `rental_transactions`

Contains ski equipment rental transactions.

| Column Name | Description |
| --- | --- |
| `transaction_id` | Unique transaction identifier |
| `item_id` | Rental item identifier |
| `customer_id` | Customer renting equipment |
| `rental_item` | Type of item rented (e.g., skis, snowboard, helmet) |
| `net_price` | Final price paid after discount |
| `date_time_out` | Date and time rental began |
| `date_time_in` | Date and time rental ended |

#### Business Rules

- Members receive **15% off rentals**.
- Non-members pay full price.
- `net_price` reflects the final amount paid after discounts.
- Rentals occur only during the seasonal window (Oct 1 – Mar 31).

---

### 4.3 Table: `lift_ticket_transactions`

Contains lift ticket purchase transactions.

| Column Name | Description |
| --- | --- |
| `date` | Date of transaction |
| `customer_id` | Customer purchasing lift access |
| `ticket_price` | Price of ticket before day pass lift ticket discounts are applied |
| `discount_code` | Promotional code |
| `discount_pct` | Percent of discount |
| `net_price` | Final price paid after discount (if stored) |

#### Business Rules

- Members pay **$0 per lift ride** (included in membership).
- Non-members pay per lift ticket.
- Promotional discount codes may apply.
- `net_price` reflects the final discounted price.
- Resort operates October 1st – March 31st.

---

### 4.4 Table: `cafe_transactions`

Contains food and beverage purchase transactions.

| Column Name | Description |
| --- | --- |
| `cafe_location` | Café location |
| `transaction_id` | Unique café transaction ID |
| `date_time` | Transaction timestamp |
| `customer_id` | Customer making purchase |
| `item` | Product purchased |
| `item_quantity` | Quantity purchased |
| `net_price` | Final price after discount |

#### Café Locations

- Icee
- Slushie
- Slurpie

#### Business Rules

- Members receive **15% off café purchases**.
- Non-members pay full price.
- `net_price` reflects final payment after discount.

---

### 4.5 Table: `lift_usage`

**⚠️ This is NOT a transaction table.**

It records actual lift usage events (operational activity).

| Column Name | Description |
| --- | --- |
| `lift_usage_id` | Unique lift usage identifier |
| `customer_id` | Customer using lift |
| `ticket_type` | Type of lift access (e.g., day pass, member) |
| `usage_datetime` | Date and time of lift scan |
| `lift_zone` | Lift or zone accessed |

#### Important Distinction

- This table does **not** represent revenue.
- It tracks operational activity (how often lifts are used).
- Members may have high lift usage but generate no per-ride revenue.

---

## 5. Table Relationships

`members.customer_id` joins with:

- `rental_transactions.customer_id`
- `lift_ticket_transactions.customer_id`
- `cafe_transactions.customer_id`
- `lift_usage.customer_id`

A customer is considered a **member** if they exist in the `members` table.

---

## 6. Revenue Model Summary

### Members

**Revenue Sources:**

- $2,000 fixed membership fee
- Discounted rental spending (15% off retail price)
- Discounted café spending (15% off retail price)
- No lift ticket revenue

### Non-Members

**Revenue Sources:**

- Full-price lift tickets (less promotional discounts)
- Full-price rentals
- Full-price café purchases
- No membership fee

---

## 7. Key Considerations

- Lift usage does **not** equal lift revenue.
- Discounts are already reflected in `net_price`.
- Membership creates upfront revenue but reduces per-transaction revenue.
- Promotional campaigns may significantly impact short-term lift revenue.
- All analysis must fall within the October 1 – March 31 operating season.

---

**End of Documentation**

The Great Data SnowDown – Winter Season 2024–2025
