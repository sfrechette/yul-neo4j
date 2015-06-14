// Create indexes for faster lookup
CREATE INDEX ON :Category(categoryName);
CREATE INDEX ON :GateZone(gateZoneName);
CREATE INDEX ON :Area(areaName);
CREATE INDEX ON :Level(levelName);

// Create constraints
CREATE CONSTRAINT ON (a:Area) ASSERT a.areaId IS UNIQUE;
CREATE CONSTRAINT ON (c:Category) ASSERT c.categoryId IS UNIQUE;
CREATE CONSTRAINT ON (g:GateZone) ASSERT g.gateZoneId IS UNIQUE;
CREATE CONSTRAINT ON (l:Level) ASSERT l.levelId IS UNIQUE;
CREATE CONSTRAINT ON (p:Place) ASSERT p.placeId IS UNIQUE;


// Create places
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/places.csv" as row
CREATE (:Place {placeName: row.PlaceName, placeId: row.PlaceID});

// Create categories
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/categories.csv" as row
CREATE (:Category {categoryName: row.CategoryName, categoryId: row.CategoryID});

// Create gatezones
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/gatezones.csv" as row
CREATE (:GateZone {gateZoneName: row.GateZoneName, gateZoneId: row.GateZoneID});

// Create levels
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/levels.csv" as row
CREATE (:Level {levelName: row.LevelName, levelId: row.LevelID});

// Create areas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/areas.csv" as row
CREATE (:Area {areaName: row.AreaName, areaId: row.AreaID});


// Create relationships: Place to Category
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/placecategorygatezone.csv" AS row
MATCH (place:Place {placeId: row.PlaceID})
MATCH (category:Category {categoryId: row.CategoryID})
MERGE (place)-[:IN_CATEGORY]->(category);

// Create relationships: Place to GateZone
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/placecategorygatezone.csv" AS row
MATCH (place:Place {placeId: row.PlaceID})
MATCH (gatezone:GateZone {gateZoneId: row.GateZoneID})
MERGE (place)-[:AT_GATEZONE]->(gatezone);

// Create relationships: GateZone to Area
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/gatezones.csv" AS row
MATCH (gatezone:GateZone {gateZoneId: row.GateZoneID})
MATCH (area:Area {areaId: row.AreaID})
MERGE (gatezone)-[:IN_AREA]->(area);

// Create relationships: Area to Level
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:data/areas.csv" AS row
MATCH (area:Area {areaId: row.AreaID})
MATCH (level:Level {levelId: row.LevelID})
MERGE (area)-[:AT_LEVEL]->(level);
