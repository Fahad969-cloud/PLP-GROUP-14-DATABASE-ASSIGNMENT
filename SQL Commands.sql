-- Create database
CREATE DATABASE railway_reservation_system;
USE railway_reservation_system;

-- Create tables
CREATE TABLE RAILWAY_TERMINAL (
    terminal_id INT PRIMARY KEY AUTO_INCREMENT,
    terminal_code VARCHAR(5) NOT NULL UNIQUE,
    terminal_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    region VARCHAR(100) NOT NULL,
    platform_count INT NOT NULL,
    handicap_access BOOLEAN DEFAULT TRUE,
    timezone VARCHAR(50) NOT NULL
);

CREATE TABLE LOCOMOTIVE (
    locomotive_id INT PRIMARY KEY AUTO_INCREMENT,
    serial_number VARCHAR(20) UNIQUE NOT NULL,
    model_name VARCHAR(50) NOT NULL,
    carriage_capacity INT NOT NULL,
    manufacture_date DATE NOT NULL,
    operator VARCHAR(100) NOT NULL,
    wifi_enabled BOOLEAN DEFAULT FALSE,
    maintenance_status VARCHAR(20) NOT NULL
);

CREATE TABLE JOURNEY (
    journey_id INT PRIMARY KEY AUTO_INCREMENT,
    departure_terminal_id INT NOT NULL,
    arrival_terminal_id INT NOT NULL,
    distance_km INT NOT NULL,
    duration_minutes INT NOT NULL,
    standard_fare DECIMAL(10,2) NOT NULL,
    meals_included BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (departure_terminal_id) REFERENCES RAILWAY_TERMINAL(terminal_id),
    FOREIGN KEY (arrival_terminal_id) REFERENCES RAILWAY_TERMINAL(terminal_id)
);

CREATE TABLE TRIP_INSTANCE (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    journey_id INT NOT NULL,
    locomotive_id INT NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    weather_condition VARCHAR(50),
    track_number VARCHAR(10) NOT NULL,
    delay_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (journey_id) REFERENCES JOURNEY(journey_id),
    FOREIGN KEY (locomotive_id) REFERENCES LOCOMOTIVE(locomotive_id)
);

CREATE TABLE TRAVELER (
    traveler_id INT PRIMARY KEY AUTO_INCREMENT,
    membership_id VARCHAR(20) UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    passport_number VARCHAR(20),
    frequent_traveler BOOLEAN DEFAULT FALSE,
    loyalty_points INT DEFAULT 0
);

CREATE TABLE RESERVATION (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    traveler_id INT NOT NULL,
    trip_id INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    paid_amount DECIMAL(10,2) NOT NULL,
    reservation_status VARCHAR(20) NOT NULL,
    checkin_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (traveler_id) REFERENCES TRAVELER(traveler_id),
    FOREIGN KEY (trip_id) REFERENCES TRIP_INSTANCE(trip_id)
);

CREATE TABLE ACCOMMODATION (
    accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    carriage_number VARCHAR(10) NOT NULL,
    berth_number VARCHAR(10) NOT NULL,
    comfort_level VARCHAR(20) NOT NULL,
    supplement_fee DECIMAL(10,2) DEFAULT 0.00,
    meals_opted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (reservation_id) REFERENCES RESERVATION(reservation_id)
);

-- Insert sample data
INSERT INTO RAILWAY_TERMINAL (terminal_code, terminal_name, address, region, platform_count, timezone) VALUES
('PAR', 'Paris Central', '1 Place Napoleon, Paris', 'Ile-de-France', 12, 'Europe/Paris'),
('LON', 'London St Pancras', 'Euston Road, London', 'Greater London', 15, 'Europe/London'),
('AMS', 'Amsterdam Centraal', 'Stationsplein, Amsterdam', 'North Holland', 8, 'Europe/Amsterdam'),
('BRU', 'Brussels Midi', 'Place Victor Horta, Brussels', 'Brussels Capital', 10, 'Europe/Brussels');

INSERT INTO LOCOMOTIVE (serial_number, model_name, carriage_capacity, manufacture_date, operator, wifi_enabled, maintenance_status) VALUES
('TGV-001', 'TGV Duplex', 450, '2020-01-15', 'SNCF', true, 'ACTIVE'),
('EUR-002', 'Eurostar e320', 400, '2021-03-20', 'Eurostar', true, 'ACTIVE'),
('THA-003', 'Thalys PBA', 350, '2019-11-30', 'Thalys', true, 'MAINTENANCE'),
('ICE-004', 'ICE 3', 380, '2022-06-10', 'Deutsche Bahn', true, 'ACTIVE');

INSERT INTO JOURNEY (departure_terminal_id, arrival_terminal_id, distance_km, duration_minutes, standard_fare, meals_included) VALUES
(1, 2, 495, 140, 180.00, true),  -- Paris to London
(2, 3, 420, 210, 150.00, true),  -- London to Amsterdam
(3, 4, 205, 110, 90.00, false),  -- Amsterdam to Brussels
(4, 1, 310, 85, 120.00, true);   -- Brussels to Paris

INSERT INTO TRIP_INSTANCE (journey_id, locomotive_id, departure_time, arrival_time, weather_condition, track_number) VALUES
(1, 1, '2025-01-10 08:00:00', '2025-01-10 10:20:00', 'Clear', 'TRACK-A1'),
(2, 2, '2025-01-10 11:00:00', '2025-01-10 14:30:00', 'Cloudy', 'TRACK-B2'),
(3, 3, '2025-01-10 09:30:00', '2025-01-10 11:20:00', 'Rain', 'TRACK-C3'),
(4, 4, '2025-01-10 13:00:00', '2025-01-10 14:25:00', 'Clear', 'TRACK-D4');

INSERT INTO TRAVELER (membership_id, full_name, nationality, passport_number, frequent_traveler, loyalty_points) VALUES
('GOLD001', 'Sophie Martin', 'French', 'FR123456', true, 5000),
('SILV002', 'James Wilson', 'British', 'GB789012', true, 3000),
('BRZ003', 'Eva Muller', 'German', 'DE345678', false, 1000),
('MEM004', 'Lucas Janssen', 'Dutch', 'NL901234', true, 4000);

INSERT INTO RESERVATION (traveler_id, trip_id, payment_method, paid_amount, reservation_status, checkin_status) VALUES
(1, 1, 'CREDIT_CARD', 220.00, 'CONFIRMED', false),
(2, 2, 'PAYPAL', 180.00, 'CONFIRMED', false),
(3, 3, 'DEBIT_CARD', 110.00, 'CONFIRMED', false),
(4, 4, 'CREDIT_CARD', 150.00, 'CONFIRMED', false);

INSERT INTO ACCOMMODATION (reservation_id, carriage_number, berth_number, comfort_level, supplement_fee, meals_opted) VALUES
(1, 'C1', 'S12', 'PREMIUM', 40.00, true),
(2, 'C2', 'S24', 'BUSINESS', 30.00, true),
(3, 'C3', 'S45', 'STANDARD', 20.00, false),
(4, 'C1', 'S08', 'PREMIUM', 40.00, true);