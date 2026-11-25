PRAGMA foreign_keys = ON;

CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    location TEXT NOT NULL,
    year_completed INTEGER NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE activities (
    activity_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT NOT NULL,
    title TEXT NOT NULL,
    creator_or_artist TEXT NOT NULL,
    platform_or_genre TEXT NOT NULL,
    rank_order INTEGER
);

CREATE TABLE messages (
    message_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sender_name TEXT NOT NULL,
    sender_email TEXT NOT NULL,
    subject TEXT NOT NULL,
    message_body TEXT NOT NULL,
    date_sent TEXT NOT NULL,
    project_id INTEGER,
    activity_id INTEGER,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE SET NULL,
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id) ON DELETE SET NULL
);

INSERT INTO projects (title, category, location, year_completed, description) VALUES
('Thika Quarry Reconnaissance', 'Field Expedition', 'Thika, Kiambu', 2026, 'Field reconnaissance survey examining environmental impact, terrain structure, and geological conditions.'),
('Avian Field Research', 'Ecological Study', 'JKUAT Juja Campus', 2026, 'Systematic observation study on local bird species, behavior, and habitat distribution.'),
('Experimental Lab Reports', 'Laboratory Analysis', 'Department of Zoology, JKUAT', 2026, 'Multi-source scientific reports built on primary biological species data.'),
('Personal HTML/CSS Portfolio', 'Applied Computing (ICS 2216)', 'Kitengela / GitHub Pages', 2026, 'Responsive 5-page portfolio built on mobile using Acode and GitHub.');

INSERT INTO activities (category, title, creator_or_artist, platform_or_genre, rank_order) VALUES
('Movie', 'Insidious', 'James Wan / Leigh Whannell', 'Supernatural / Exorcism', 1),
('Movie', 'The Conjuring', 'James Wan', 'Paranormal Casebook', 2),
('Movie', 'The Pope''s Exorcist', 'Julius Avery', 'Vatican Exorcism Thriller', 3),
('Movie', 'The Conjuring: The Devil Made Me Do It', 'Michael Chaves', 'Supernatural Horror', 4),
('Movie', 'The Bride (2010)', 'Supernatural Cinema', 'Folklore Horror', 5),
('Music', 'Losing My Mind', 'Baby Smoove', 'Detroit Rap', 1),
('Music', 'New Drank', 'Lucki', 'Underground Rap', 2),
('Music', 'New Detroit', 'Lelo', 'Detroit Rap', 3),
('Music', 'Outside Today', 'NBA YoungBoy', 'Mainstream Rap', 4),
('Music', 'Super Gremlin', 'Kodak Black', 'Mainstream Rap', 5),
('Research', 'Ancient Philosophy & Historical Archives', 'Collins Lyanda', 'Esoteric Inquiry', NULL);

INSERT INTO messages (sender_name, sender_email, subject, message_body, date_sent, project_id, activity_id) VALUES
('Vincent Odhiambo', 'vincent.odhiambo@students.jkuat.ac.ke', 'GIS Field Data Collaboration', 'Hey Collins, let us compare our Thika Quarry terrain notes before Friday lab.', '2026-11-20', 1, NULL),
('Dr. Kamau', 'kamau.zoology@jkuat.ac.ke', 'Avian Survey Methodology', 'Well-structured species observation table in your SZL 2204 submission.', '2026-11-22', 2, NULL),
('Brian Otieno', 'brian.otieno@gmail.com', 'Detroit Playlist & Horror Picks', 'That moneygar bst playlist and Insidious ranking are solid.', '2026-11-24', NULL, 1);

-- ==========================================================
-- 5 REQUIRED SQL QUERIES
-- ==========================================================

-- Query 1: All Academic & Computing Projects
SELECT project_id, title, category, location, year_completed
FROM projects
ORDER BY project_id ASC;

-- Query 2: Top 5 Horror & Exorcism Movies Ordered by Rank
SELECT rank_order, title, creator_or_artist, platform_or_genre
FROM activities
WHERE category = 'Movie'
ORDER BY rank_order ASC;

-- Query 3: Count of Activities Grouped by Category
SELECT category, COUNT(*) AS total_items
FROM activities
GROUP BY category;

-- Query 4: JOIN Messages with Referenced Academic Projects
SELECT m.message_id, m.sender_name, m.subject, p.title AS referenced_project, m.date_sent
FROM messages m
LEFT JOIN projects p ON m.project_id = p.project_id;

-- Query 5: Filter Rap Tracks in 'Detroit Rap' Subgenre
SELECT title AS track_title, creator_or_artist AS artist, platform_or_genre
FROM activities
WHERE category = 'Music' AND platform_or_genre = 'Detroit Rap';

