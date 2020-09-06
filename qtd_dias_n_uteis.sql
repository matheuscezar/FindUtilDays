DELIMITER //
CREATE FUNCTION qtd_dias_n_uteis (data_inicial DATE, data_final DATE, empresaID INT) RETURNS INT
BEGIN
DECLARE qtd_feriado INT DEFAULT 0;
DECLARE data_range DATE;
SET data_range = data_inicial;
WHILE data_range<=data_final DO
	IF(data_range IN (SELECT feriado.`data` FROM feriado WHERE empresa_id=empresaID AND feriado.`data`=data_range)) THEN
		IF(WEEKDAY(data_range) NOT IN (5,6)) THEN #verifica se o feriado é no fds
			SET qtd_feriado = qtd_feriado + 1; 
		END IF;	
	END IF;
	SELECT DATE_ADD(data_range, INTERVAL 1 DAY) INTO data_range;
END WHILE;
RETURN qtd_feriado;
END;//
DELIMITER ;
