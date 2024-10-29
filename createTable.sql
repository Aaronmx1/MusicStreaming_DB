/* 
    Overview: Creation of Music Streaming Service backend tables
*/

-- Disable commits and foreign key checks to minimize import errors 
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT=0;

-- Drop tables to re-create tables
DROP TABLE IF EXISTS AddedSongs;
DROP TABLE IF EXISTS Collaborations;
DROP TABLE IF EXISTS Artists;
DROP TABLE IF EXISTS Playlists;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS LikedSongs;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Albums;
DROP TABLE IF EXISTS Subscriptions;


-- Handles M:N relationship between Playlists and Songs
CREATE TABLE AddedSongs (
    addedSongsId int(11) NOT NULL AUTO_INCREMENT,
    playlistId int(11) NOT NULL,
    songId int(11) NOT NULL,
    -- PRI: Primary key (unique and not null)
    PRIMARY KEY (addedSongsId),
    -- Below here connects Playlists and Songs tables to AddedSongs table
    -- MUL: The column has a non-unique index, meaning it can contain duplicate values, but it's indexed for faster searches.
    -- KEY: Lists attribute as a key to be used as an index for foreign key matching
    -- Constraints maintain foreign key relationships
    CONSTRAINT FOREIGN KEY (playlistId) REFERENCES Playlists (playlistId)
        -- ON UPDATE CASCADE updated value and updates table
        ON UPDATE CASCADE
        -- ON DELETE RESTRICT will restrict deletions from being reflected on this table
        ON DELETE RESTRICT,    
    CONSTRAINT FOREIGN KEY (songId) REFERENCES Songs (songId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Handles M:N relationship between Artists and Songs
CREATE TABLE Collaborations (
    collaborationId int(11) NOT NULL AUTO_INCREMENT,
    songId int(11) NOT NULL,
    artistId int(11) NOT NULL,
    primary key (collaborationId),
    CONSTRAINT FOREIGN KEY (artistId) REFERENCES Artists(artistId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FOREIGN KEY (songId) REFERENCES Songs(songId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Artists table contains artist details
CREATE TABLE Artists (
    artistId int(11) NOT NULL AUTO_INCREMENT,
    fName varchar(50) NOT NULL,
    lName varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    PRIMARY KEY (artistId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Playlists table contains system and user generated playlists
CREATE TABLE Playlists (
    playlistId int(11) NOT NULL AUTO_INCREMENT,
    playlistName varchar(50) NOT NULL,
    playlistDescription varchar(50) NOT NULL,
    userId int(11) NOT NULL,
    numberOfSongs int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (playlistId),
    CONSTRAINT FOREIGN KEY (userId) REFERENCES Users(userId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Songs table contains artist created songs
CREATE TABLE Songs (
    songId int(11) NOT NULL AUTO_INCREMENT,
    songName varchar(50) NOT NULL,
    albumId int(11) NOT NULL,
    artistId int(11) NOT NULL,
    genre varchar(50) NOT NULL,
    songLength time NOT NULL,
    totalStreams int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (songId),
    CONSTRAINT FOREIGN KEY (albumId) REFERENCES Albums (albumId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FOREIGN KEY (artistId) REFERENCES Artists (artistId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Handles M:N relationship between Users and Songs
CREATE TABLE LikedSongs (
    linkedSongsId int(11) NOT NULL AUTO_INCREMENT,
    songId int(11) NOT NULL,
    userId int(11) NOT NULL,
    PRIMARY KEY (linkedSongsId),
    -- Below here connects Songs and Users tables to LikedSongs table
    -- KEY: Determines foreign key in table
    -- KEY (songId),
    -- CONSTRAINT: identifier
    -- FOREIGN KEY: attribute which is foreign key
    CONSTRAINT FOREIGN KEY (songId) REFERENCES Songs (songId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FOREIGN KEY (userId) REFERENCES Users (userId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Users table which contains company user base
CREATE TABLE Users (
    userId int(11) NOT NULL AUTO_INCREMENT,
    fName varchar(50) NOT NULL,
    lName varchar(50) NOT NULL,
    email varchar(50) NOT NULL UNIQUE,
    dob date NOT NULL,
    subscriptionId int(11) NOT NULL,
    PRIMARY KEY (userId),
    CONSTRAINT FOREIGN KEY (subscriptionId) REFERENCES Subscriptions (subscriptionId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Albums table which contains collections of songs from artists
CREATE TABLE Albums (
    albumId int(11) NOT NULL AUTO_INCREMENT,
    albumName varchar(50) NOT NULL,
    recordStudio varchar(50) NOT NULL,
    yearReleased int(11) NOT NULL,
    artistId int(11) NOT NULL,
    numberOfSongs int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (albumId),
    CONSTRAINT FOREIGN KEY (artistId) REFERENCES Artists (artistId)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Subscriptions table handles types of plans user base is subscribed to
CREATE TABLE Subscriptions (
    subscriptionId int(11) NOT NULL AUTO_INCREMENT,
    subscriptionDescription varchar(50) NOT NULL UNIQUE,
    price decimal(10,2) NOT NULL,
    numberOfSubscriptions int(11) DEFAULT 0,
    PRIMARY KEY (subscriptionId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Enable commit and foreign key checks to catch errors
SET FOREIGN_KEY_CHECKS=1;
COMMIT;