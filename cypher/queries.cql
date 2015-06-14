
// Find all places and their categories located at Gate 57 (with Area and Level)
MATCH (c:Category)<--(p:Place)-->(g:GateZone)-->(a:Area)-->(l:Level)
WHERE g.gateZoneName = 'Gate 57'
RETURN c, p, g, a, l;

// Find Boutiques in Restricted area - International on First Floor/Departures 
MATCH (p:Place)-[:IN_CATEGORY]->(c:Category),
      (p)-[:AT_GATEZONE]->(g:GateZone),
      (g)-[:IN_AREA]->(a:Area),
      (a)-[:AT_LEVEL]->(l:Level)
WHERE c.categoryName = 'Boutiques' AND a.areaName = 'Restricted area - International' AND l.levelName = 'First Floor/Departures'
RETURN p.placeName AS Name, c.categoryName AS Category, g.gateZoneName AS Gate, a.areaName AS Area, l.levelName AS Level

// Return count of places in each category
MATCH (p:Place)-[:IN_CATEGORY]-(c:Category)
RETURN c.categoryName AS Category, collect(distinct p.placeName) as Place, count(p) AS Count
ORDER BY Count DESC

// Count number of places that are in Cafés category 
MATCH (p:Place)-[:IN_CATEGORY]->(c:Category)
WHERE c.categoryName = 'Cafés' s
RETURN distinct (count(p.placeName)) AS Count, c.categoryName AS Category


// Other sample queries
MATCH (g:GateZone)-[:IN_AREA]->(a:Area)-[:AT_LEVEL]->(l:Level)
RETURN distinct (count(g.gateZoneName)) AS Count, a.areaName AS GateZone, l.levelName as Level

MATCH (c:Category)<--(p:Place)-->(g:GateZone)-->(a:Area) 
WHERE a.areaName = 'Restricted area - Canada' 
RETURN c, p, g, a;

MATCH (c:Category)<--(p:Place)-->(g:GateZone)-->(a:Area) 
WHERE c.categoryName = 'Boutiques' 
RETURN c, p, g, a;