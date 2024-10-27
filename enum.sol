// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BookingSystem {
    // Enum for Booking Type
    enum BookingType { Bus, Cinema, Airline, Railway, Cricket }

    // Structs for user and different types of bookings
    struct UserStruct {
        uint256 userID;
        string name;
        uint8 age;
        string contactDetails;
    }

    struct BusBookingStruct {
        string busNumber;
        string origin;
        string destination;
        uint256 dateOfJourney;
        uint8 seatNumber;
    }

    struct CinemaBookingStruct {
        string movieName;
        string cinemaHall;
        uint256 showTime;
        uint8 seatNumber;
    }

    struct AirlineBookingStruct {
        string flightNumber;
        string origin;
        string destination;
        uint256 dateOfJourney;
        string seatClass;
    }

    struct RailwayBookingStruct {
        string trainNumber;
        string origin;
        string destination;
        uint256 dateOfJourney;
        uint8 seatNumber;
    }

    struct CricketBookingStruct {
        string matchDetails;
        string stadium;
        uint256 matchDate;
        uint8 seatNumber;
    }

    struct BookingStruct {
        uint256 bookingID;
        BookingType bookingType;
        UserStruct user;
        BusBookingStruct busBooking;
        CinemaBookingStruct cinemaBooking;
        AirlineBookingStruct airlineBooking;
        RailwayBookingStruct railwayBooking;
        CricketBookingStruct cricketBooking;
    }

    // State variables
    uint256 private bookingCounter;
    mapping(uint256 => BookingStruct) public bookings;

    // Events
    event NewBooking(uint256 bookingID, BookingType bookingType, string userName);

    // Function to book a bus ticket
    function bookBusTicket(
        string memory _name,
        uint8 _age,
        string memory _contactDetails,
        string memory _busNumber,
        string memory _origin,
        string memory _destination,
        uint256 _dateOfJourney,
        uint8 _seatNumber
    ) public {
        bookingCounter++;
        bookings[bookingCounter] = BookingStruct({
            bookingID: bookingCounter,
            bookingType: BookingType.Bus,
            user: UserStruct(bookingCounter, _name, _age, _contactDetails),
            busBooking: BusBookingStruct(_busNumber, _origin, _destination, _dateOfJourney, _seatNumber),
            cinemaBooking: CinemaBookingStruct("", "", 0, 0),
            airlineBooking: AirlineBookingStruct("", "", "", 0, ""),
            railwayBooking: RailwayBookingStruct("", "", "", 0, 0),
            cricketBooking: CricketBookingStruct("", "", 0, 0)
        });
        emit NewBooking(bookingCounter, BookingType.Bus, _name);
    }

    // Function to book a cinema ticket
    function bookCinemaTicket(
        string memory _name,
        uint8 _age,
        string memory _contactDetails,
        string memory _movieName,
        string memory _cinemaHall,
        uint256 _showTime,
        uint8 _seatNumber
    ) public {
        bookingCounter++;
        bookings[bookingCounter] = BookingStruct({
            bookingID: bookingCounter,
            bookingType: BookingType.Cinema,
            user: UserStruct(bookingCounter, _name, _age, _contactDetails),
            busBooking: BusBookingStruct("", "", "", 0, 0),
            cinemaBooking: CinemaBookingStruct(_movieName, _cinemaHall, _showTime, _seatNumber),
            airlineBooking: AirlineBookingStruct("", "", "", 0, ""),
            railwayBooking: RailwayBookingStruct("", "", "", 0, 0),
            cricketBooking: CricketBookingStruct("", "", 0, 0)
        });
        emit NewBooking(bookingCounter, BookingType.Cinema, _name);
    }

    // Function to book an airline ticket
    function bookAirlineTicket(
        string memory _name,
        uint8 _age,
        string memory _contactDetails,
        string memory _flightNumber,
        string memory _origin,
        string memory _destination,
        uint256 _dateOfJourney,
        string memory _seatClass
    ) public {
        bookingCounter++;
        bookings[bookingCounter] = BookingStruct({
            bookingID: bookingCounter,
            bookingType: BookingType.Airline,
            user: UserStruct(bookingCounter, _name, _age, _contactDetails),
            busBooking: BusBookingStruct("", "", "", 0, 0),
            cinemaBooking: CinemaBookingStruct("", "", 0, 0),
            airlineBooking: AirlineBookingStruct(_flightNumber, _origin, _destination, _dateOfJourney, _seatClass),
            railwayBooking: RailwayBookingStruct("", "", "", 0, 0),
            cricketBooking: CricketBookingStruct("", "", 0, 0)
        });
        emit NewBooking(bookingCounter, BookingType.Airline, _name);
    }

    // Function to book a railway ticket
    function bookRailwayTicket(
        string memory _name,
        uint8 _age,
        string memory _contactDetails,
        string memory _trainNumber,
        string memory _origin,
        string memory _destination,
        uint256 _dateOfJourney,
        uint8 _seatNumber
    ) public {
        bookingCounter++;
        bookings[bookingCounter] = BookingStruct({
            bookingID: bookingCounter,
            bookingType: BookingType.Railway,
            user: UserStruct(bookingCounter, _name, _age, _contactDetails),
            busBooking: BusBookingStruct("", "", "", 0, 0),
            cinemaBooking: CinemaBookingStruct("", "", 0, 0),
            airlineBooking: AirlineBookingStruct("", "", "", 0, ""),
            railwayBooking: RailwayBookingStruct(_trainNumber, _origin, _destination, _dateOfJourney, _seatNumber),
            cricketBooking: CricketBookingStruct("", "", 0, 0)
        });
        emit NewBooking(bookingCounter, BookingType.Railway, _name);
    }

    // Function to book a cricket ticket
    function bookCricketTicket(
        string memory _name,
        uint8 _age,
        string memory _contactDetails,
        string memory _matchDetails,
        string memory _stadium,
        uint256 _matchDate,
        uint8 _seatNumber
    ) public {
        bookingCounter++;
        bookings[bookingCounter] = BookingStruct({
            bookingID: bookingCounter,
            bookingType: BookingType.Cricket,
            user: UserStruct(bookingCounter, _name, _age, _contactDetails),
            busBooking: BusBookingStruct("", "", "", 0, 0),
            cinemaBooking: CinemaBookingStruct("", "", 0, 0),
            airlineBooking: AirlineBookingStruct("", "", "", 0, ""),
            railwayBooking: RailwayBookingStruct("", "", "", 0, 0),
            cricketBooking: CricketBookingStruct(_matchDetails, _stadium, _matchDate, _seatNumber)
        });
        emit NewBooking(bookingCounter, BookingType.Cricket, _name);
    }

    // Function to get booking details by bookingID
    function getBooking(uint256 _bookingID) public view returns (BookingStruct memory) {
        return bookings[_bookingID];
    }

    // Function to get total number of bookings
    function getTotalBookings() public view returns (uint256) {
        return bookingCounter;
    }
}