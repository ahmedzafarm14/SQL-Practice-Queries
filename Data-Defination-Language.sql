CREATE Database 'hostel-hub';
USE hostel-hub;

CREATE TABLE address (
  id INT PRIMARY KEY AUTO_INCREMENT,
  city VARCHAR(100),
  district VARCHAR(100),
  postalCode VARCHAR(20),
  addressDetails TEXT,
  location_type ENUM('Point'),
  location_coordinates POINT
);
CREATE TABLE amenity (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

CREATE TABLE booking (
  id INT PRIMARY KEY AUTO_INCREMENT,
  seekerId INT NOT NULL,
  hostelId INT NOT NULL,
  roomType ENUM('1-seater','2-seater','3-seater','4-seater') NOT NULL,
  checkInDate DATE NOT NULL,
  checkOutDate DATE NOT NULL,
  status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
  FOREIGN KEY (seekerId) REFERENCES person(id),
  FOREIGN KEY (hostelId) REFERENCES hostel(id)
);

CREATE TABLE chat (
  id INT PRIMARY KEY AUTO_INCREMENT,
  senderId INT NOT NULL,
  receiverId INT NOT NULL,
  message TEXT NOT NULL,
  isRead TINYINT(1) DEFAULT 0,
  FOREIGN KEY (senderId) REFERENCES person(id),
  FOREIGN KEY (receiverId) REFERENCES person(id)
);

CREATE TABLE foodmenu (
  id INT PRIMARY KEY AUTO_INCREMENT,
  hostelId INT NOT NULL,
  fileUrl TEXT NOT NULL,
  FOREIGN KEY (hostelId) REFERENCES hostel(id)
);

CREATE TABLE hostel (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ownerId INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  addressId INT NOT NULL,
  FOREIGN KEY (ownerId) REFERENCES person(id),
  FOREIGN KEY (addressId) REFERENCES address(id)
);

CREATE TABLE hostelamenity (
  hostelId INT NOT NULL,
  amenityId INT NOT NULL,
  PRIMARY KEY (hostelId, amenityId),
  FOREIGN KEY (hostelId) REFERENCES hostel(id),
  FOREIGN KEY (amenityId) REFERENCES amenity(id)
);

CREATE TABLE hostelroomtype (
  id INT PRIMARY KEY AUTO_INCREMENT,
  hostelId INT NOT NULL,
  type ENUM('1-seater','2-seater','3-seater','4-seater') NOT NULL,
  pricePerMonth DECIMAL(10,2) NOT NULL,
  totalAvailability INT NOT NULL,
  FOREIGN KEY (hostelId) REFERENCES hostel(id)
);

CREATE TABLE image (
  id INT PRIMARY KEY AUTO_INCREMENT,
  url TEXT NOT NULL,
  type ENUM('profile','hostel') NOT NULL,
  personId INT,
  hostelId INT,
  FOREIGN KEY (personId) REFERENCES person(id),
  FOREIGN KEY (hostelId) REFERENCES hostel(id)
);

CREATE TABLE person (
  id INT PRIMARY KEY AUTO_INCREMENT,
  userName VARCHAR(100) UNIQUE,
  role ENUM('resident','owner','admin') NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  firstName VARCHAR(100),
  lastName VARCHAR(100),
  cnic VARCHAR(20) UNIQUE,
  password VARCHAR(255) NOT NULL,
  gender ENUM('male','female'),
  addressId INT,
  contact VARCHAR(20) UNIQUE,
  status TINYINT(1) DEFAULT 0,
  FOREIGN KEY (addressId) REFERENCES address(id)
);

CREATE TABLE review (
  id INT PRIMARY KEY AUTO_INCREMENT,
  seekerId INT NOT NULL,
  hostelId INT NOT NULL,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  FOREIGN KEY (seekerId) REFERENCES person(id),
  FOREIGN KEY (hostelId) REFERENCES hostel(id)
);


