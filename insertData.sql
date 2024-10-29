INSERT INTO Artists(
    fName,
    lName,
    email
) VALUES (
    'John',
    'Mayer',
    'jmayer@gmail.com'
),
(
    'Ben',
    'Rector',
    'brector@gmail.com'
),
(
    'Jeff',
    'Buckley',
    'jbuckley@gmail.com'
),
(
    'Childish',
    'Gambino',
    'cgambino@gmail.com'
),
(
    'Taylor',
    'Swift',
    'tswift@gmail.com'
),
(
    'Post',
    'Malone',
    'pmalone@gmail.com'
);

INSERT INTO Albums(
    albumName, 
    recordStudio,
    yearReleased,
    artistId,
    numberOfSongs
) VALUES (
    'Continuum',
    'Aware Records LLC',
    2006,
    ( SELECT artistId from Artists WHERE fName = 'John' and lName = 'Mayer' ),
    12
),
(
    'Magic',
    'OK Kid Recordings LLC',
    2018,
    ( SELECT artistId from Artists WHERE fName = 'Ben' and lName = 'Rector' ),
    13
),
(
    'Grace',
    'Colombia Records',
    1994,
    ( SELECT artistId from Artists WHERE fName = 'Jeff' and lName = 'Buckley' ),
    11
),
(
    'Awaken, My Love!',
    'McDJ Entertainment',
    2016,
    ( SELECT artistId from Artists WHERE fName = 'Childish' and lName = 'Gambino' ),
    11
),
(
    'Tortured Poets Department',
    'Taylor Swift',
    2024,
    ( SELECT artistId from Artists WHERE fName = 'Taylor' and lName = 'Swift' ),
    16
);

INSERT INTO Songs(
    songName,
    albumId,
    artistId,
    genre,
    songLength,
    totalStreams
) VALUES (
    'Gravity',
    ( SELECT albumId from Albums WHERE albumName = 'Continuum' ),
    ( SELECT artistId from Artists WHERE fName = 'John' and lName = 'Mayer' ),
    'Blues',
    '4:05:0',
    0
),
(
    'Drive',
    ( SELECT albumId from Albums WHERE albumName = 'Magic' ),
    ( SELECT artistId from Artists WHERE fName = 'Ben' and lName = 'Rector' ),
    'Pop',
    '3:17:0',
    0
),
(
    "Lover You Should've Come Over",
    ( SELECT albumId from Albums WHERE albumName = 'Grace' ),
    ( SELECT artistId from Artists WHERE fName = 'Jeff' and lName = 'Buckley' ),
    'Alternative Rock',
    '6:44:0',
    0
),
(
    'Redbone',
    ( SELECT albumId from Albums WHERE albumName = 'Awaken, My Love!' ),
    ( SELECT artistId from Artists WHERE fName = 'Childish' and lName = 'Gambino' ),
    'R&B',
    '5:26:0',
    0
),
(
    'Fortnight',
    ( SELECT albumId from Albums WHERE albumName = 'Tortured Poets Department' ),
    ( SELECT artistId from Artists WHERE fName = 'Taylor' and lName = 'Swift' ),
    'Pop',
    '3:48:0',
    0
);

INSERT INTO Subscriptions (
    subscriptionDescription,
    price,
    numberOfSubscriptions
) VALUES (
    'Premium Individual',
    15,
    0
),
(
    'Premium Family',
    30,
    0
),
(
    'Free',
    0,
    0
);

INSERT INTO Users (
    fName,
    lName,
    email,
    dob,
    subscriptionId
) VALUES (
    'Aaron',
    'Martinez',
    'amartinez@gmail.com',
    '2023-05-06',
    ( SELECT subscriptionId from Subscriptions WHERE subscriptionDescription = 'Premium Individual' )
),
(
    'Elizabeth',
    'Hoved',
    'ehoved@gmail.com',
    '2023-05-06',
    ( SELECT subscriptionId from Subscriptions WHERE subscriptionDescription = 'Premium Family' )
),
(
    'Elon',
    'Musk',
    'emusk@gmail.com',
    '2024-02-02',
    ( SELECT subscriptionId from Subscriptions WHERE subscriptionDescription = 'Free' )
);

INSERT INTO Playlists (
    playlistName,
    playlistDescription,
    userId,
    numberOfSongs
) VALUES (
    'Good Songs',
    'Some good songs that I like',
    ( SELECT userId from Users WHERE email = 'amartinez@gmail.com' ),
    4
),
(
    'Bad Songs',
    "Songs that I don't like",
    ( SELECT userId from Users WHERE email = 'emusk@gmail.com' ),
    2
),
(
    'Other songs',
    'Various Songs',
    ( SELECT userId from Users WHERE email = 'ehoved@gmail.com' ),
    3
);

INSERT INTO AddedSongs (
    playlistId,
    songId
) VALUES (
    ( SELECT playlistId from Playlists WHERE playlistName = 'Good Songs' ),
    ( SELECT songId from Songs WHERE songName = 'Gravity' )
),
(
    ( SELECT playlistId from Playlists WHERE playlistName = 'Good Songs' ),
    ( SELECT songId from Songs WHERE songName = 'Redbone' )    
),
(
    ( SELECT playlistId from Playlists WHERE playlistName = 'Good Songs' ),
    ( SELECT songId from Songs WHERE songName = 'Drive' )
),
(
    ( SELECT playlistId from Playlists WHERE playlistName = 'Good Songs' ),
    ( SELECT songId from Songs WHERE songName = "Lover You Should've Come Over" )
),
(
    ( SELECT playlistId from Playlists where playlistName = 'Bad Songs' ),
    ( SELECT songId from Songs WHERE songName = "Lover You Should've Come Over" )
),
(
    ( SELECT playlistId from Playlists where playlistName = 'Bad Songs' ),
    ( SELECT songId from Songs WHERE songName = 'Fortnight' )
);

INSERT INTO Collaborations (
    songId,
    artistId
) VALUES (
    ( SELECT songId from Songs WHERE songName = 'Fortnight' ),
    ( SELECT artistId from Artists WHERE fName = 'Post' and lName = 'Malone' )
),
(
    ( SELECT songId from Songs WHERE songName = 'Gravity' ),
    ( SELECT artistId from Artists WHERE fName = 'Ben' and lName = 'Rector' )
),
(
    ( SELECT songId from Songs WHERE songName = 'Redbone' ),
    ( SELECT artistId from Artists WHERE fName = 'John' and lName = 'Mayer' )
);
