DROP DATABASE IF EXISTS ParkEZz;
CREATE DATABASE ParkEZz;
USE ParkEZz;

-- users table
CREATE TABLE IF NOT EXISTS users (
    user_id    INT          PRIMARY KEY AUTO_INCREMENT,
    full_name  VARCHAR(100) NOT NULL,
    id         VARCHAR(50)  NOT NULL UNIQUE,
    phone      VARCHAR(20)  NOT NULL UNIQUE,
    user_type  ENUM('Student', 'Staff') NOT NULL DEFAULT 'Student'
);

-- lot table i guess
CREATE TABLE IF NOT EXISTS lot (
    lot_id        INT          PRIMARY KEY AUTO_INCREMENT,
    lot_name      VARCHAR(100) NOT NULL,
    total_slots   INT          NOT NULL DEFAULT 0,
    vehicle_type  ENUM('Car', 'Motorcycle') NOT NULL
);

-- vehicle. has fk to users
CREATE TABLE IF NOT EXISTS vehicle (
    vehicle_no    VARCHAR(20)  PRIMARY KEY,
    user_id       INT          NOT NULL,
    model         VARCHAR(100) NOT NULL,
    color         VARCHAR(50)  NOT NULL,
    vehicle_type  ENUM('Car', 'Motorcycle') NOT NULL,
    CONSTRAINT fk_vehicle_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- slot table fk to lot
CREATE TABLE IF NOT EXISTS slot (
    slot_no     INT  PRIMARY KEY AUTO_INCREMENT,
    lot_id      INT  NOT NULL,
    slot_label  ENUM('Available', 'Occupied', 'Reserved') NOT NULL DEFAULT 'Available',
    CONSTRAINT fk_slot_lot
        FOREIGN KEY (lot_id) REFERENCES lot(lot_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- record table. 3 fks dont ask me why
CREATE TABLE IF NOT EXISTS record (
    record_id    INT         PRIMARY KEY AUTO_INCREMENT,
    slot_no      INT         NOT NULL,
    vehicle_no   VARCHAR(20) NOT NULL,
    user_id      INT         NOT NULL,
    action_type  ENUM('Enter', 'Exit') NOT NULL,
    action_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_record_slot
        FOREIGN KEY (slot_no) REFERENCES slot(slot_no)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_record_vehicle
        FOREIGN KEY (vehicle_no) REFERENCES vehicle(vehicle_no)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_record_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- indexes for performance or whatever
CREATE INDEX idx_vehicle_user   ON vehicle(user_id);
CREATE INDEX idx_slot_lot       ON slot(lot_id);
CREATE INDEX idx_slot_label     ON slot(slot_label);
CREATE INDEX idx_record_slot    ON record(slot_no);
CREATE INDEX idx_record_vehicle ON record(vehicle_no);
CREATE INDEX idx_record_user    ON record(user_id);
CREATE INDEX idx_record_time    ON record(action_time);

-- lots
INSERT INTO lot (lot_name, total_slots, vehicle_type) VALUES
('Skill - Motorcycle', 365, 'Motorcycle'),
('Skill - Car', 96, 'Car'),
('Kumari - Motorcycle', 355, 'Motorcycle'),
('Kumari - Car', 41, 'Car'),
('Himal - Motorcycle', 72, 'Motorcycle');

-- slots for skill - motorcycle (365): 7 lanes [54,54,54,54,54,65,30]
INSERT INTO slot (lot_id, slot_label) VALUES
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 2 (54)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 3 (54)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 4 (54)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 5 (54)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 6 (65)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- lane 7 (30)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available');

-- skill - car (96): groups [15,15],[15,15],[8],[8],[6,6],[8]
INSERT INTO slot (lot_id, slot_label) VALUES
-- pair 1 lane A (15)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- pair 1 lane B (15)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- pair 2 lane A (15)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- pair 2 lane B (15)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- single lane (8)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),
-- single lane (8)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),
-- pair 3 lane A (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),
-- pair 3 lane B (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),
-- single lane (8)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available');

-- kumari - motorcycle (355): groups [50,50],[50,50],[50,50],[40],[15]
INSERT INTO slot (lot_id, slot_label) VALUES
-- pair 1 lane A (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 1 lane B (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 2 lane A (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 2 lane B (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 3 lane A (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 3 lane B (50)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- single lane (40)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- single lane (15)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available');

-- kumari - car (41): singles [6],[4],[1],[2],[4],[12],[12]
INSERT INTO slot (lot_id, slot_label) VALUES
-- lane 1 (6)
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),
-- lane 2 (4)
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
-- lane 3 beside tree (1)
(4,'Available'),
-- lane 4 (2)
(4,'Available'),(4,'Available'),
-- lane 5 (4)
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
-- lane 6 (12)
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),
-- lane 7 (12)
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available');

-- himal - motorcycle (72): [15],[18,18],[18],[3]
INSERT INTO slot (lot_id, slot_label) VALUES
-- single lane (15)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- pair lane A (18)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),
-- pair lane B (18)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),
-- single lane (18)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),
-- single lane (3)
(5,'Available'),(5,'Available'),(5,'Available');

-- test data
INSERT INTO users (full_name, id, phone, user_type)
VALUES ('Mishek Sambiu Limbu', 'NP01CP4A240016', '9800000000', 'Student');

INSERT INTO vehicle (vehicle_no, user_id, model, color, vehicle_type)
VALUES ('BA1PA1234', 1, 'Honda Dio', 'Red', 'Motorcycle');
