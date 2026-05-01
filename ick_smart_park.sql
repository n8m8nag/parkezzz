CREATE DATABASE IF NOT EXISTS ick_smart_park;
USE ick_smart_park;

-- user table
CREATE TABLE IF NOT EXISTS user (
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

-- vehicle. has fk to user
CREATE TABLE IF NOT EXISTS vehicle (
    vehicle_no    INT          PRIMARY KEY AUTO_INCREMENT,
    user_id       INT          NOT NULL,
    model         VARCHAR(100) NOT NULL,
    color         VARCHAR(50)  NOT NULL,
    vehicle_type  ENUM('Car', 'Motorcycle') NOT NULL,
    CONSTRAINT fk_vehicle_user
        FOREIGN KEY (user_id) REFERENCES user(user_id)
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
    record_id    INT       PRIMARY KEY AUTO_INCREMENT,
    slot_no      INT       NOT NULL,
    vehicle_no   INT       NOT NULL,
    user_id      INT       NOT NULL,
    action_type  ENUM('Enter', 'Exit') NOT NULL,
    action_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_record_slot
        FOREIGN KEY (slot_no) REFERENCES slot(slot_no)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_record_vehicle
        FOREIGN KEY (vehicle_no) REFERENCES vehicle(vehicle_no)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_record_user
        FOREIGN KEY (user_id) REFERENCES user(user_id)
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
('Skill - A',  36, 'Motorcycle'),
('Skill - B',  36, 'Motorcycle'),
('Kumari - B', 24, 'Car'),
('Kumari - C', 24, 'Car'),
('Himal',      20, 'Car');

-- slots for skill a (36)
INSERT INTO slot (lot_id, slot_label) VALUES
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available');

-- skill b same thing
INSERT INTO slot (lot_id, slot_label) VALUES
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available');

-- kumari b 24 slots
INSERT INTO slot (lot_id, slot_label) VALUES
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available');

-- kumari c same as b
INSERT INTO slot (lot_id, slot_label) VALUES
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available'),
(4,'Available'),(4,'Available'),(4,'Available'),(4,'Available');

-- himal 20
INSERT INTO slot (lot_id, slot_label) VALUES
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available');

-- test data
INSERT INTO user (full_name, id, phone, user_type)
VALUES ('Mishek Sambiu Limbu', 'NP01CP4A240016', '9800000000', 'Student');

INSERT INTO vehicle (user_id, model, color, vehicle_type)
VALUES (1, 'Honda Dio', 'Red', 'Motorcycle');