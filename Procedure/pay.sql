DELIMITER //

CREATE PROCEDURE get_station_section_detail(
  IN p_departure_station_id VARCHAR(255),
  IN p_destination_station_id VARCHAR(255)
)
BEGIN
  DECLARE found_count INT;

  SELECT COUNT(*) INTO found_count
  FROM station_detail sd1
  JOIN station s1 ON sd1.station_seq = s1.seq
  JOIN station_detail sd2 ON sd1.schedules_seq = sd2.schedules_seq
  JOIN station s2 ON sd2.station_seq = s2.seq
  WHERE s1.station_id = p_departure_station_id
    AND s2.station_id = p_destination_station_id
    AND sd1.station_order < sd2.station_order;

  IF found_count = 0 THEN
    SELECT '운행정보가 존재하지 않습니다' AS message;
  ELSE
    SELECT 
      sd1.schedules_seq,
      s1.station_id AS 출발역,
      s2.station_id AS 도착역,
      sd1.station_order AS 출발역순서,
      sd2.station_order AS 도착역순서,
      sd1.track AS 출발탑승구
    FROM station_detail sd1
    JOIN station s1 ON sd1.station_seq = s1.seq
    JOIN station_detail sd2 ON sd1.schedules_seq = sd2.schedules_seq
    JOIN station s2 ON sd2.station_seq = s2.seq
    WHERE s1.station_id = p_departure_station_id
      AND s2.station_id = p_destination_station_id
      AND sd1.station_order < sd2.station_order;
  END IF;
END //

DELIMITER ;
