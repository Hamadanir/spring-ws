DROP TABLE FREQUENT_FLYER IF EXISTS;
DROP TABLE PASSENGER_TICKET IF EXISTS;
DROP TABLE PASSENGER IF EXISTS;
DROP TABLE TICKET IF EXISTS;
DROP TABLE FLIGHT IF EXISTS;
DROP TABLE AIRPORT IF EXISTS;

CREATE TABLE AIRPORT (
    CODE char(3) NOT NULL,
    NAME varchar(20) NOT NULL,
    CITY varchar(255) NOT NULL,
    PRIMARY KEY (CODE)
);

CREATE TABLE FLIGHT (
    ID BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1),
    NUMBER VARCHAR(20) NOT NULL,
    DEPARTURE_TIME TIMESTAMP NOT NULL,
    FROM_AIRPORT_CODE CHAR(3) NOT NULL,
    ARRIVAL_TIME TIMESTAMP NOT NULL,
    TO_AIRPORT_CODE CHAR(3) NOT NULL,
    SEATS_AVAILABLE INT NOT NULL,
    SERVICE_CLASS VARCHAR(10) NOT NULL,
    MILES INT NOT NULL,
    PRIMARY KEY (ID),
    UNIQUE (NUMBER, DEPARTURE_TIME),
    CONSTRAINT FK_FLIGHT_AIRPORT_FROM FOREIGN KEY (FROM_AIRPORT_CODE) REFERENCES AIRPORT,
    CONSTRAINT FK_FLIGHT_AIRPORT_TO FOREIGN KEY (TO_AIRPORT_CODE) REFERENCES AIRPORT
);

CREATE TABLE TICKET (
    ID BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1),
    ISSUE_DATE DATE NOT NULL,
    FLIGHT_ID BIGINT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_TICKET_FLIGHT FOREIGN KEY (FLIGHT_ID) REFERENCES FLIGHT
);

CREATE TABLE PASSENGER (
    ID BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1),
    FIRST_NAME VARCHAR(30),
    LAST_NAME VARCHAR(30),
    PRIMARY KEY (ID)
);

CREATE TABLE PASSENGER_TICKET (
    TICKET_ID BIGINT NOT NULL,
    PASSENGER_ID BIGINT NOT NULL,
    PRIMARY KEY (TICKET_ID, PASSENGER_ID),
    CONSTRAINT PASSENGER_TICKET_TICKET FOREIGN KEY (TICKET_ID) REFERENCES TICKET,
    CONSTRAINT PASSENGER_TICKET_PASSENGER FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGER
);

CREATE TABLE FREQUENT_FLYER (
    PASSENGER_ID BIGINT NOT NULL,
    MILES INTEGER,
    PASSWORD VARCHAR(255),
    USERNAME VARCHAR(255),
    PRIMARY KEY (PASSENGER_ID),
    CONSTRAINT FREQUENT_FLYER_PASSENGER FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGER
)