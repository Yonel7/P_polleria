-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: bddeleite
-- ------------------------------------------------------
-- Server version	8.0.38
USE BDDELEITE;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'bddeleite'
--

--
-- Dumping routines for database 'bddeleite'
--
/*!50003 DROP FUNCTION IF EXISTS `hash_string` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `hash_string`(input_text VARCHAR(255)) RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE hashed_text VARCHAR(60);
    
    -- Usamos SHA2 con 256 bits (64 caracteres) y lo truncamos a 60 caracteres
    SET hashed_text = LEFT(SHA2(input_text, 256), 60);

    RETURN hashed_text;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarAdmin`(
    IN p_admin_id INT
)
BEGIN

    -- Manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;
    -- Actualiza el estado del pedido a cancelado = 3
    UPDATE admins set admin_estado = 0 WHERE admin_id = p_admin_id;
    -- Confirmar la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarPedido`(
    IN p_pedido_id INT
)
BEGIN

    -- Manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;
    -- Actualiza el estado del pedido a cancelado = 3
    UPDATE pedidos set estado = 3 WHERE pedido_id = p_pedido_id;
    -- Confirmar la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPedido`(
    IN p_dni_cliente CHAR(8),
    IN p_nombre_cliente VARCHAR(200),
    IN p_celular_cliente VARCHAR(9),
    IN p_direccion_cliente VARCHAR(255),
    IN p_monto_total DECIMAL(10,2),
    IN p_tipo INT,  
    IN p_hora TIME,
    IN p_fecha DATE,
    IN p_estado INT
)
BEGIN
    DECLARE p_pedido_id INT;
    DECLARE p_cliente_id INT;

    -- Manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SET p_pedido_id = -1; -- Indica error
        SELECT p_pedido_id AS pedido_id;
    END;

    -- Iniciar la transacción
    START TRANSACTION;
    
    -- Verificar si el cliente existe
    SELECT cliente_id INTO p_cliente_id FROM clientes WHERE cliente_id = p_dni_cliente;

    -- Si el cliente no existe, lo insertamos
    IF p_cliente_id IS NULL THEN
        INSERT INTO clientes (cliente_id, nombre_cliente, celular_cliente, direccion_cliente) 
        VALUES (p_dni_cliente, p_nombre_cliente, p_celular_cliente, p_direccion_cliente);
    END IF;

    -- Insertar el pedido con el ID del cliente correcto
    INSERT INTO pedidos (cliente_id, monto_total, tipo, hora, fecha, estado)
    VALUES (p_dni_cliente, p_monto_total, p_tipo, p_hora, CURDATE(), p_estado);

    -- Obtener el ID generado del pedido
    SET p_pedido_id = LAST_INSERT_ID();
    
    -- Confirmar la transacción
    COMMIT;

    -- Devolver el ID del pedido insertado
    SELECT p_pedido_id AS pedido_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarProductoPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProductoPedido`(
    IN p_producto_id INT,
    IN p_pedido_id INT,
    IN p_cantidad INT,
    IN p_monto DECIMAL(10,2)
)
BEGIN
    DECLARE new_productoPedido_id INT;
    DECLARE stock_actual INT;

    -- Manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 0 AS exito, NULL AS productoPedido_id; -- Devuelve error
    END;

    -- Iniciar la transacción
    START TRANSACTION;
    
    -- Verificar si el producto existe en stock
    SELECT cantidad INTO stock_actual FROM stock WHERE producto_id = p_producto_id;

    IF stock_actual IS NULL OR stock_actual < p_cantidad THEN
        -- Si el producto no existe en stock o no hay suficiente stock, cancelar la transacción
        ROLLBACK;
        SELECT 0 AS exito, NULL AS productoPedido_id;
    ELSE
        -- Insertar en la tabla productoPedido
        INSERT INTO productoPedido (producto_id, pedido_id, cantidad, monto)
        VALUES (p_producto_id, p_pedido_id, p_cantidad, p_monto);

        -- Obtener el ID insertado
        SET new_productoPedido_id = LAST_INSERT_ID();

        -- Actualiza el stock del producto
        UPDATE stock SET cantidad = cantidad - p_cantidad WHERE producto_id = p_producto_id;

        -- Confirmar la transacción
        COMMIT;
        
        -- Devolver el ID insertado y éxito
        SELECT 1 AS exito, new_productoPedido_id AS productoPedido_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerInformacionRelevanteJSON` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerInformacionRelevanteJSON`()
BEGIN
    DECLARE clientes INT;
    DECLARE admins INT;
    DECLARE totalPedidos INT;
    DECLARE totalMonto DECIMAL(10,2);
    DECLARE fechaActual DATE;

    -- Obtener los valores
    SELECT COUNT(cliente_id) INTO clientes FROM clientes;
    SELECT COUNT(admin_id) INTO admins FROM admins;
    SELECT COUNT(pedido_id), IFNULL(SUM(monto_total), 0), CURDATE() 
    INTO totalPedidos, totalMonto, fechaActual FROM pedidos WHERE DATE(fecha) = CURDATE() AND estado = 2;

    -- Devolver resultado en formato JSON
    SELECT JSON_OBJECT(
        'clientesRegistrados', clientes,
        'adminsRegistrados', admins,
        'totalPedidos', totalPedidos,
        'totalMonto', totalMonto,
        'fechaActual', fechaActual
    ) AS resultado_json;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarPago` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarPago`(
    IN p_pedido_id INT,
    IN p_monto_pagado DECIMAL(10,2),
    IN p_metodo_pago VARCHAR(10),
    IN p_operacion VARCHAR(100)
)
BEGIN
    -- Iniciar una transacción
    START TRANSACTION;
    
    -- Insertar el pago en la tabla 'pagos'
    INSERT INTO pagos (pedido_id, monto_pagado, metodo_pago, operacion)
    VALUES (p_pedido_id, p_monto_pagado, p_metodo_pago, p_operacion);
    
    -- Actualizar el estado del pedido a 'Pagado'
    UPDATE pedidos
    SET estado = 2
    WHERE pedido_id = p_pedido_id;
    
    -- Confirmar la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CrearAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CrearAdmin`(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_usuario VARCHAR(20),
    IN p_contrasena VARCHAR(255),
    IN p_estado INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error, se revierte la transacción
        select 0 as admin_id;
        ROLLBACK;
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Insertar el nuevo administrador
    INSERT INTO admins (admin_nombre, admin_apellido, admin_user, admin_password, admin_estado)
    VALUES (p_nombre, p_apellido, p_usuario, hash_string(p_contrasena), p_estado);

    -- Obtener el último ID insertado y retornarlo
    SELECT LAST_INSERT_ID() AS admin_id;

    -- Confirmar la transacción
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EditarAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EditarAdmin`(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_usuario VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Si ocurre un error, se revierte la transacción
        ROLLBACK;
        SELECT 'error' AS status, 'Error al editar el administrador' AS message;
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Actualizar los datos del administrador
    UPDATE admins 
    SET admin_nombre = p_nombre, 
        admin_apellido = p_apellido, 
        admin_user = p_usuario
    WHERE admin_id = p_id;

    -- Confirmar la transacción
    COMMIT;

    -- Retornar mensaje de éxito
    SELECT 'success' AS status, 'Administrador editado con éxito' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VerificarAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VerificarAdmin`(IN p_usuario VARCHAR(20), IN p_contrasena VARCHAR(255))
BEGIN
    SELECT admin_id, admin_user, admin_password, admin_estado 
    FROM admins 
    WHERE admin_user = p_usuario AND admin_password = hash_string(p_contrasena) AND admin_estado = 1
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-15 15:47:53
