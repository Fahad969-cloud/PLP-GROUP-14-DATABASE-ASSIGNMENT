# PLP-GROUP-14-DATABASE-ASSIGNMENT



Detailed Explanation of Railway System


1. International Focus

RAILWAY_TERMINAL includes timezone management
Multiple languages/regions supported
International pricing (in standard currency)
Cross-border journey tracking


2. Enhanced Passenger Management


Loyalty program with points tracking
Passport information for international travel
Membership tiers (GOLD, SILVER, BRONZE)
Frequent traveler status


3. Advanced Journey Planning


Weather condition tracking
Real-time delay monitoring
Platform/track assignment
Distance and duration tracking


4. Locomotive Fleet


Detailed maintenance tracking
WiFi availability status
Manufacture date tracking
Operator assignment


5. Comfort Levels (replacing traditional classes)


PREMIUM (highest comfort)
BUSINESS (mid-tier)
STANDARD (economy)
Each with optional meal service


6. Pricing Structure


Base journey fare
Comfort level supplements
Meal service options
Loyalty point redemption

7. Real-World Application

For example, a journey from Paris to London:

Terminal: Paris Central (PAR) → London St Pancras (LON)
Using: TGV Duplex locomotive with WiFi
Distance: 495 km, Duration: 140 minutes
Premium comfort level with meals included
Real-time weather and delay tracking
Loyalty points earned based on journey



Key points about this ERD:

Primary Relationships

Each RAILWAY_TERMINAL can have multiple JOURNEYs
Each JOURNEY can have multiple TRIP_INSTANCEs
Each LOCOMOTIVE can operate multiple TRIP_INSTANCEs
Each TRIP_INSTANCE can have multiple RESERVATIONs
Each TRAVELER can make multiple RESERVATIONs
Each RESERVATION has exactly one ACCOMMODATION


Key Fields

PK: Primary Keys (marked with PK)
FK: Foreign Keys (marked with FK)



Cardinality

||--o{ : One-to-many relationship
||--|| : One-to-one relationship
