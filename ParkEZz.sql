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
    action_type  ENUM('Enter', 'Exit', 'Reserve') NOT NULL,
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
('Skill - Motorcycle', 105, 'Motorcycle'),
('Skill - Car', 120, 'Car'),
('Kumari - Motorcycle', 158, 'Motorcycle'),
('Kumari - Car', 41, 'Car'),
('Himal - Motorcycle', 160, 'Motorcycle');

-- slots for skill - motorcycle (105): 6 cols x 15 rows + 15 bottom
INSERT INTO slot (lot_id, slot_label) VALUES
-- col 1 left single (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- col 2 left pair lane A (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- col 3 left pair lane B (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- col 4 right pair lane A (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- col 5 right pair lane B (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- col 6 right single (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
-- bottom row (15)
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),
(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available'),(1,'Available');

-- skill - car (120): 4 big cols x22 rows + 3 right boxes (6,6,4) x2 lanes
INSERT INTO slot (lot_id, slot_label) VALUES
-- left pair lane A (22)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),
-- left pair lane B (22)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),
-- middle pair lane A (22)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),
-- middle pair lane B (22)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
(2,'Available'),(2,'Available'),
-- right box 1 lane A (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- right box 1 lane B (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- right box 2 lane A (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- right box 2 lane B (6)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- right box 3 lane A (4)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available'),
-- right box 3 lane B (4)
(2,'Available'),(2,'Available'),(2,'Available'),(2,'Available');

-- kumari - motorcycle (158): 3 pairs x 20x2 + single x 20 + bottom row x 18
INSERT INTO slot (lot_id, slot_label) VALUES
-- pair 1 lane A (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 1 lane B (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 2 lane A (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 2 lane B (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 3 lane A (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- pair 3 lane B (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- single column (20)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
-- bottom row (18)
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),(3,'Available'),
(3,'Available'),(3,'Available'),(3,'Available');

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

-- himal - motorcycle (160): 4 double-rows x 20 cols x 2 lanes
INSERT INTO slot (lot_id, slot_label) VALUES
-- row 0 lane A (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 0 lane B (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 1 lane A (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 1 lane B (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 2 lane A (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 2 lane B (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 3 lane A (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
-- row 3 lane B (20)
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),
(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available'),(5,'Available');

-- test data
INSERT INTO users (full_name, id, phone, user_type)
VALUES ('Mishek Sambiu Limbu', 'NP01CP4A240016', '9800000000', 'Student');

INSERT INTO vehicle (vehicle_no, user_id, model, color, vehicle_type)
VALUES ('BA1PA1234', 1, 'Honda Dio', 'Red', 'Motorcycle');
