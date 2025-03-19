1. Summary Transactions (stg_summary)
This table stores detailed transactional and user session data, capturing key user interactions on the platform.

Schema
order_id (STRING): Unique identifier for an order.
time_stamp (STRING): The time when the action occurred.
ip (STRING): The IP address of the user.
user_agent (STRING): Browser and device information.
resolution (STRING): Screen resolution of the device.
user_id_db (STRING): Unique identifier for the user.
device_id (STRING): Device identifier.
api_version (STRING): The API version used in the transaction.
store_id (STRING): Identifier for the store.
local_time (STRING): Local time of the transaction.
show_recommendation (BOOLEAN): Indicates if product recommendations were displayed.
recommendation (BOOLEAN): Indicates if a recommendation was clicked.
is_paypal (BOOLEAN): Indicates if the payment was made using PayPal.
current_url (STRING): The current webpage URL.
referrer_url (STRING): The URL that referred the user.
email_address (STRING): User’s email address.
utm_source (STRING): UTM source for tracking marketing campaigns.
utm_medium (STRING): UTM medium for marketing classification.
collection (STRING): Collection ID related to the product.
product_id (STRING, PRIMARY KEY): Unique identifier for the product.
viewing_product_id (STRING): Product currently being viewed.
cat_id (STRING): Product category identifier.
collect_id (STRING): Collection identifier.
recommendation_product_id (STRING): Identifier of the recommended product.
recommendation_clicked_position (STRING): Position of the clicked recommendation.
key_search (STRING): Search term used by the user.
price (FLOAT): Product price.
currency (STRING): Currency type.
recommendation_product_position (INT): Position of the recommended product.
Purpose
Provides insights into user sessions and transactions.
Tracks product recommendations and their effectiveness.
Helps analyze checkout behavior and revenue impact.
2. Add to Cart Actions (stg_add_to_cart_action)
Captures user actions related to adding products to the shopping cart.

Schema
source_collection (STRING): Source of the data.
ip (STRING, NOT NULL): User’s IP address.
country_short (STRING): Country abbreviation (e.g., US, DE).
country_long (STRING, NOT NULL): Full country name.
city (STRING, NOT NULL): City of the user.
region (STRING, NOT NULL): Region or state of the user.
latitude (FLOAT): User’s geographic latitude.
longitude (FLOAT): User’s geographic longitude.
Purpose
Helps analyze geographical distribution of cart additions.
Tracks user intent and pre-purchase behavior.
3. Checkout Actions (stg_checkout)
Captures data when users initiate the checkout process.

Schema
source_collection (STRING): Source of the data.
ip (STRING, PRIMARY KEY): User’s IP address.
country_short (STRING): Country abbreviation.
country_long (STRING, NOT NULL): Full country name.
city (STRING, NOT NULL): User’s city.
region (STRING, NOT NULL): User’s region/state.
latitude (FLOAT): Geographic latitude.
longitude (FLOAT): Geographic longitude.
Purpose
Tracks users who start the checkout process.
Helps identify trends in abandoned checkouts.
4. Successful Checkouts (stg_checkout_success)
Captures data when users successfully complete a checkout.

Schema
source_collection (STRING): Source of the data.
ip (STRING, PRIMARY KEY): User’s IP address.
country_short (STRING): Country abbreviation.
country_long (STRING, NOT NULL): Full country name.
city (STRING, NOT NULL): User’s city.
region (STRING, NOT NULL): User’s region/state.
latitude (FLOAT): Geographic latitude.
longitude (FLOAT): Geographic longitude.
Purpose
Measures successful transactions per location.
Helps assess overall purchase conversion rates.
5. Back to Product Actions (stg_back_to_product_action)
Tracks when users return to a product page after navigating away.

Schema
source_collection (STRING): Source of the data.
ip (STRING, PRIMARY KEY): User’s IP address.
country_short (STRING): Country abbreviation.
country_long (STRING, NOT NULL): Full country name.
city (STRING, NOT NULL): User’s city.
region (STRING, NOT NULL): User’s region/state.
latitude (FLOAT): Geographic latitude.
longitude (FLOAT): Geographic longitude.
Purpose
Identifies hesitation in purchasing decisions.
Helps optimize product pages and recommendation strategies.
6. User Journey Tracking (stg_user_journey)
Tracks the sequence of user actions on the platform.

Schema
source_collection (STRING): Source of the data.
ip (STRING, NOT NULL): User’s IP address.
country_short (STRING): Country abbreviation.
country_long (STRING, NOT NULL): Full country name.
city (STRING, NOT NULL): User’s city.
region (STRING, NOT NULL): User’s region/state.
latitude (FLOAT): Geographic latitude.
longitude (FLOAT): Geographic longitude.
action_type (STRING): Type of user action (e.g., add_to_cart, checkout).
Purpose
Helps visualize user navigation and behavior.
Supports funnel analysis to optimize conversion rates.

Conclusion
These staging tables provide raw session, transaction, and user interaction data essential for further analysis. By using these tables, businesses can gain insights into user behavior, conversion trends, and geographic distribution to enhance marketing, sales, and user experience strategies.

2. Dimension Tables Documentation
Overview
Dimension tables (dim_*) store descriptive attributes used for categorizing and analyzing transactional data. These tables provide context to fact data and help in organizing structured analytics.

1. Product Dimension (dim_product)
This table stores information about products, their attributes, and pricing.

Schema
order_id (STRING): Unique identifier for the order associated with the product.
product_id (STRING, PRIMARY KEY): Unique identifier for the product.
price (STRING): Price of the product.
currency (STRING): Currency type in which the product is sold.
amount (INTEGER): Quantity of the product purchased.
option_id (STRING): Unique identifier for product customization options.
option_label (STRING): Label describing the product option.
value_id (STRING): Unique identifier for the selected option value.
value_label (STRING): Label describing the selected option value.
Purpose
Standardizes product information across orders.
Enables analysis of product sales, pricing trends, and customer preferences.
Helps in filtering and grouping products based on attributes.
2. IP Location Dimension (dim_ip_location)
Stores location-related attributes based on user IP addresses.

Schema
ip (STRING, PRIMARY KEY): Unique identifier for the user's IP address.
country_short (STRING): Abbreviated country name (e.g., US, DE).
country_long (STRING): Full name of the country.
city (STRING): City where the user is located.
region (STRING): Region or state where the user is located.
latitude (FLOAT): Geographic latitude of the user’s location.
longitude (FLOAT): Geographic longitude of the user’s location.
action_type (STRING): Type of user action (e.g., checkout, add_to_cart).
Purpose
Enables geographic-based analysis of user activity.
Helps in personalizing recommendations and regional marketing campaigns.
Supports fraud detection and security analysis based on IP tracking.
3. Time Dimension (dim_time)
Stores date and time attributes for tracking events over time.

Schema
time_stamp (STRING, PRIMARY KEY): Raw timestamp from source data.
timestamp (TIMESTAMP): Standardized timestamp format.
year (INT): Extracted year from the timestamp.
month (INT): Extracted month from the timestamp.
day (INT): Extracted day from the timestamp.
hour (INT): Extracted hour from the timestamp.
Purpose
Enables time-based trend analysis.
Supports time series reporting and forecasting.
Facilitates aggregation of data at different time granularities (hourly, daily, monthly, yearly).
Conclusion
Dimension tables provide structured attributes that enhance analytical capabilities. They are essential for descriptive analysis, improving data consistency, and enabling efficient reporting in business intelligence systems.

Fact Tables Documentation
Overview
Fact tables (fact_*) store measurable business data. These tables contain numerical values used for analytics and reporting. They often reference dimension tables to provide descriptive context.

1. Product Performance Fact Table (fact_product_performance)
This table tracks sales performance for products.

Schema
product_id (STRING, PRIMARY KEY): Unique identifier for the product.
option_label (STRING): Label for product customization options.
total_orders (INTEGER): Total number of times the product was ordered.
total_revenue (FLOAT): Total revenue generated from the product.
avg_price (FLOAT): Average selling price of the product.
Purpose
Enables analysis of product sales performance.
Helps in identifying top-selling and underperforming products.
Supports pricing strategy optimization.
2. Geographic Distribution Fact Table (fact_geographic_distribution)
This table tracks sales and user activity based on geographic locations.

Schema
ip (STRING, NOT NULL): Unique user IP address.
country_short (STRING): Abbreviated country name (e.g., US, DE).
country_long (STRING): Full country name.
city (STRING): Name of the city.
region (STRING): Name of the region or state.
unique_users (INTEGER): Number of unique users from this location.
total_orders (INTEGER): Total number of orders from this location.
Purpose
Supports geographic analysis of customer activity.
Helps in regional marketing and sales strategies.
Enables user engagement tracking across different locations.
3. Revenue per Region Fact Table (fact_revenue_per_region)
This table aggregates revenue data by region.

Schema
country_long (STRING, NOT NULL): Full name of the country.
region (STRING): Name of the region or state.
total_revenue (FLOAT): Total revenue generated from this region.
Purpose
Helps in regional revenue tracking.
Supports decision-making for targeted promotions and localized pricing strategies.
Provides insights into revenue trends by geographic location.
4. Revenue Fact Table (fact_revenue)
This table stores order-level revenue data, including product and geographic attributes.

Schema
order_id (STRING, NOT NULL): Unique identifier for the order.
product_id (STRING): Unique identifier for the product.
option_id (STRING): Identifier for product options.
option_label (STRING): Label for product customization options.
value_id (STRING): Identifier for selected option values.
value_label (STRING): Label for selected option values.
country_long (STRING): Full country name.
region (STRING): Name of the region or state.
city (STRING): Name of the city.
latitude (FLOAT): Geographic latitude of the transaction location.
longitude (FLOAT): Geographic longitude of the transaction location.
total_revenue (FLOAT): Total revenue for the order.
Purpose
Provides a detailed breakdown of revenue data.
Helps in revenue attribution by location, product, and customization options.
Supports business intelligence reporting and revenue forecasting.
5. Time-Based Trend Fact Table (fact_time_based_trend)
This table tracks revenue and user activity trends over time.

Schema
timestamp (TIMESTAMP): Exact timestamp of the transaction or event.
transaction_date (DATE): Date of the transaction.
transaction_hour (INT): Hour of the transaction.
transaction_week (INT): Week number of the transaction.
unique_users (INT): Number of unique users for the given time period.
total_revenue (FLOAT): Total revenue generated in the given time period.
Purpose
Supports time-series analysis of revenue and user activity.
Enables identification of peak sales periods.
Helps in predicting future trends based on historical data.
Conclusion
Fact tables provide critical business insights by capturing measurable data points. They enable performance tracking, geographic analysis, revenue forecasting, and trend identification. These tables form the backbone of business intelligence and analytics.

User Journey Actions Table (user_journey_actions)
Overview
The user_journey_actions table tracks user actions along with their order of occurrence and location. It helps analyze user behavior by assigning a sequential order to each action and generating a unique session identifier.

Schema
ip (STRING): Unique user IP address.
action_type (STRING): Type of action performed by the user (e.g., add_to_cart, checkout).
action_order (INTEGER): Sequential order of the action for a given IP.
country_long (STRING): Full country name associated with the IP.
city (STRING): City name associated with the IP.
session_id (STRING): Unique identifier assigned to each row, representing a user session.
Purpose
Tracks user interactions in sequential order.
Helps in analyzing customer journeys.
Supports session-based analytics and user behavior tracking.
User Journey Funnel Table (user_journey_funnel)
Overview
The user_journey_funnel table aggregates user actions into a funnel structure, providing insights into conversion rates at different stages of the customer journey.

Schema
ip (STRING): Unique user IP address.
add_to_cart_count (INTEGER): Number of times the user added a product to the cart.
back_to_product_count (INTEGER): Number of times the user returned to a product page.
checkout_count (INTEGER): Number of times the user initiated checkout.
checkout_success_count (INTEGER): Number of times the user successfully completed a checkout.
cart_to_checkout_rate (FLOAT): Conversion rate from add_to_cart to checkout.
checkout_to_success_rate (FLOAT): Conversion rate from checkout to successful order completion.
overall_conversion_rate (FLOAT): Overall conversion rate from add_to_cart to checkout_success.
Purpose
Provides insights into the effectiveness of the sales funnel.
Helps identify drop-off points in the customer journey.
Supports optimization of e-commerce conversion rates.