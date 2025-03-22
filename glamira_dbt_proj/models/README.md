Glamira Data Model Documentation
Overview
The Glamira database is designed using a star schema, optimizing for analytical queries and efficient reporting. It consists of:

Fact Tables → Store transactional data (e.g., sales, revenue).

Dimension Tables → Provide descriptive details for analysis (e.g., product, location, date).

Fact Table: fact_sales
This table captures sales transactions and is the central fact table for revenue and product performance analysis.

Column Name	Data Type	Description
sales_id	VARCHAR	Unique ID for each sale (hashed composite key).
order_id	INT	Identifier for each order.
product_id	VARCHAR	Foreign key referencing dim_product.
location_id	VARCHAR	Foreign key referencing dim_location.
option_id	VARCHAR	Foreign key referencing dim_option.
store_id	INT	Foreign key referencing dim_store.
date_id	DATE	Foreign key referencing dim_date.
device_id	VARCHAR	Foreign key referencing dim_device.
price	FLOAT	Product price at the time of sale.
total_orders	INT	Total number of orders per sale.
total_revenue	FLOAT	Revenue generated from the sale.
Dimension Tables
1️⃣ dim_date
Stores date and time details for time-based trend analysis.

Column Name	Data Type	Description
date_id	DATE	Primary key (unique date).
year	INT	Year of transaction.
month	INT	Month of transaction.
day	INT	Day of transaction.
hour	INT	Hour of transaction.
timestamp	VARCHAR	Exact timestamp of transaction.
2️⃣ dim_location
Contains geographical details of user locations.

Column Name	Data Type	Description
location_id	VARCHAR	Primary key (hashed from IP).
ip	VARCHAR	IP address of the user.
country_short	VARCHAR	2-letter country code.
country_long	VARCHAR	Full country name.
region	VARCHAR	Region or state.
city	VARCHAR	City of the user.
latitude	VARCHAR	Latitude coordinate.
longitude	VARCHAR	Longitude coordinate.

3️⃣ dim_product
Contains product-related information.

Column Name	Data Type	Description
product_id	VARCHAR	Primary key (Unique identifier for product).
product_name	VARCHAR	Name of the product.
4️⃣ dim_device
Stores device details of users for performance analysis.

Column Name	Data Type	Description
device_id	VARCHAR	Primary key (hashed from device details).
user_agent	VARCHAR	Browser and OS information.
resolution	VARCHAR	Screen resolution of the device.
api_version	VARCHAR	API version used.
email_address	VARCHAR	User's email address.
5️⃣ dim_option
Contains product customization details like materials, gemstones, etc.

Column Name	Data Type	Description
option_id	VARCHAR	Primary key (Unique identifier for option).
option_label	VARCHAR	Name of the option (e.g., "Alloy").
value_label	VARCHAR	Selected value (e.g., "Gold 585").
6️⃣ dim_store
Contains details of different stores.

Column Name	Data Type	Description
store_id	INT	Primary key (Unique store ID).
store_name	VARCHAR	Name of the store.
 Use Cases for This Data Model
✅ Revenue Analysis → fact_sales + dim_date + dim_product
✅ Geographic Distribution → fact_sales + dim_location
✅ Product Performance → fact_sales + dim_product + dim_option
✅ Time-Based Trends → fact_sales + dim_date