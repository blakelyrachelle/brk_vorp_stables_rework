-- BRK Vorp Stables Rework 

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- Main stables table
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `stables` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `charidentifier` INT(11) NOT NULL,
  `name` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `modelname` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` VARCHAR(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `xp` INT(11) NULL DEFAULT 0,
  `injured` INT(11) NULL DEFAULT 0,
  `gear` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `isDefault` INT(11) NOT NULL DEFAULT 0,
  `inventory` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

ALTER TABLE `stables`
  ADD COLUMN IF NOT EXISTS `identifier` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  ADD COLUMN IF NOT EXISTS `charidentifier` INT(11) NOT NULL,
  ADD COLUMN IF NOT EXISTS `name` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ADD COLUMN IF NOT EXISTS `modelname` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ADD COLUMN IF NOT EXISTS `type` VARCHAR(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ADD COLUMN IF NOT EXISTS `status` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  ADD COLUMN IF NOT EXISTS `xp` INT(11) NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `injured` INT(11) NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `gear` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  ADD COLUMN IF NOT EXISTS `isDefault` INT(11) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS `inventory` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL;

ALTER TABLE `stables`
  ADD INDEX IF NOT EXISTS `idx_stables_charidentifier` (`charidentifier`),
  ADD INDEX IF NOT EXISTS `idx_stables_type` (`type`),
  ADD INDEX IF NOT EXISTS `idx_stables_modelname` (`modelname`);

-- --------------------------------------------------------
-- Old VORP horse complements table
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `charidentifier` INT(11) NOT NULL,
  `complements` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`),
  INDEX `idx_horse_complements_charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

ALTER TABLE `horse_complements`
  ADD COLUMN IF NOT EXISTS `identifier` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  ADD COLUMN IF NOT EXISTS `charidentifier` INT(11) NOT NULL,
  ADD COLUMN IF NOT EXISTS `complements` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL;

ALTER TABLE `horse_complements`
  ADD INDEX IF NOT EXISTS `idx_horse_complements_charidentifier` (`charidentifier`);

-- --------------------------------------------------------
-- Tack loadout table: one row per horse, currently equipped tack only
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `horse_tack_loadout` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `charidentifier` INT NOT NULL,
  `horse_id` INT NOT NULL,
  `saddles` VARCHAR(32) DEFAULT NULL,
  `blankets` VARCHAR(32) DEFAULT NULL,
  `saddle_horns` VARCHAR(32) DEFAULT NULL,
  `saddlebags` VARCHAR(32) DEFAULT NULL,
  `stirrups` VARCHAR(32) DEFAULT NULL,
  `bedrolls` VARCHAR(32) DEFAULT NULL,
  `lanterns` VARCHAR(32) DEFAULT NULL,
  `masks` VARCHAR(32) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_horse_id` (`horse_id`),
  INDEX `idx_horse_tack_loadout_charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

ALTER TABLE `horse_tack_loadout`
  ADD COLUMN IF NOT EXISTS `charidentifier` INT NOT NULL,
  ADD COLUMN IF NOT EXISTS `horse_id` INT NOT NULL,
  ADD COLUMN IF NOT EXISTS `saddles` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `blankets` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `saddle_horns` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `saddlebags` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `stirrups` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `bedrolls` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `lanterns` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `masks` VARCHAR(32) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN IF NOT EXISTS `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `horse_tack_loadout`
  MODIFY COLUMN `saddles` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `blankets` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `saddle_horns` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `saddlebags` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `stirrups` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `bedrolls` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `lanterns` VARCHAR(32) DEFAULT NULL,
  MODIFY COLUMN `masks` VARCHAR(32) DEFAULT NULL;

-- Remove orphan or duplicate loadout rows before adding/keeping the unique horse index.
DELETE `l`
FROM `horse_tack_loadout` `l`
LEFT JOIN `stables` `s` ON `s`.`id` = `l`.`horse_id`
WHERE `s`.`id` IS NULL;

UPDATE `horse_tack_loadout` `l`
JOIN `stables` `s` ON `s`.`id` = `l`.`horse_id`
SET `l`.`charidentifier` = `s`.`charidentifier`
WHERE `l`.`charidentifier` <> `s`.`charidentifier`;

DELETE `l1`
FROM `horse_tack_loadout` `l1`
JOIN `horse_tack_loadout` `l2`
  ON `l1`.`horse_id` = `l2`.`horse_id`
 AND `l1`.`id` > `l2`.`id`;

ALTER TABLE `horse_tack_loadout`
  ADD UNIQUE KEY IF NOT EXISTS `unique_horse_id` (`horse_id`),
  ADD INDEX IF NOT EXISTS `idx_horse_tack_loadout_charidentifier` (`charidentifier`);

-- --------------------------------------------------------
-- Tack storage table migration
-- Current design: one row per character, JSON arrays per tack category.
-- If an older row-per-item `horse_tack_storage` table exists, this backs it up
-- and migrates unassigned stored tack into the new table.
-- --------------------------------------------------------
DROP PROCEDURE IF EXISTS `brk_prepare_horse_tack_storage`;

DELIMITER //
CREATE PROCEDURE `brk_prepare_horse_tack_storage`()
BEGIN
  DECLARE table_exists INT DEFAULT 0;
  DECLARE has_saddles_column INT DEFAULT 0;
  DECLARE has_comp_type_column INT DEFAULT 0;
  DECLARE backup_table VARCHAR(128);

  SELECT COUNT(*) INTO table_exists
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'horse_tack_storage';

  IF table_exists = 0 THEN
    CREATE TABLE `horse_tack_storage` (
      `charidentifier` INT NOT NULL,
      `saddles` LONGTEXT DEFAULT NULL,
      `blankets` LONGTEXT DEFAULT NULL,
      `saddle_horns` LONGTEXT DEFAULT NULL,
      `saddlebags` LONGTEXT DEFAULT NULL,
      `stirrups` LONGTEXT DEFAULT NULL,
      `bedrolls` LONGTEXT DEFAULT NULL,
      `lanterns` LONGTEXT DEFAULT NULL,
      `masks` LONGTEXT DEFAULT NULL,
      `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`charidentifier`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
  ELSE
    SELECT COUNT(*) INTO has_saddles_column
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'horse_tack_storage'
      AND COLUMN_NAME = 'saddles';

    SELECT COUNT(*) INTO has_comp_type_column
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'horse_tack_storage'
      AND COLUMN_NAME = 'comp_type';

    IF has_saddles_column = 0 THEN
      SET backup_table = CONCAT('horse_tack_storage_legacy_backup_', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
      SET @sql = CONCAT('RENAME TABLE `horse_tack_storage` TO `', backup_table, '`');
      PREPARE stmt FROM @sql;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;

      CREATE TABLE `horse_tack_storage` (
        `charidentifier` INT NOT NULL,
        `saddles` LONGTEXT DEFAULT NULL,
        `blankets` LONGTEXT DEFAULT NULL,
        `saddle_horns` LONGTEXT DEFAULT NULL,
        `saddlebags` LONGTEXT DEFAULT NULL,
        `stirrups` LONGTEXT DEFAULT NULL,
        `bedrolls` LONGTEXT DEFAULT NULL,
        `lanterns` LONGTEXT DEFAULT NULL,
        `masks` LONGTEXT DEFAULT NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`charidentifier`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

      IF has_comp_type_column > 0 THEN
        SET @sql = CONCAT(
          'INSERT INTO `horse_tack_storage` (`charidentifier`, `saddles`, `blankets`, `saddle_horns`, `saddlebags`, `stirrups`, `bedrolls`, `lanterns`, `masks`) ',
          'SELECT c.`charidentifier`, ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Saddles'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Blankets'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Saddle Horns'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Saddlebags'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Stirrups'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Bedrolls'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Lanterns'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]''), ',
          'COALESCE((SELECT JSON_ARRAYAGG(CAST(s.`comp_hash` AS CHAR)) FROM `', backup_table, '` s WHERE s.`charidentifier` = c.`charidentifier` AND s.`comp_type` = ''Masks'' AND (s.`assigned_horse_id` IS NULL OR s.`assigned_horse_id` = 0)), ''[]'') ',
          'FROM (SELECT DISTINCT `charidentifier` FROM `', backup_table, '`) c'
        );
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
      END IF;
    ELSE
      ALTER TABLE `horse_tack_storage`
        ADD COLUMN IF NOT EXISTS `saddles` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `blankets` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `saddle_horns` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `saddlebags` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `stirrups` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `bedrolls` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `lanterns` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `masks` LONGTEXT DEFAULT NULL,
        ADD COLUMN IF NOT EXISTS `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        ADD COLUMN IF NOT EXISTS `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
    END IF;
  END IF;
END//
DELIMITER ;

CALL `brk_prepare_horse_tack_storage`();
DROP PROCEDURE IF EXISTS `brk_prepare_horse_tack_storage`;

ALTER TABLE `horse_tack_storage`
  ADD UNIQUE KEY IF NOT EXISTS `unique_horse_tack_storage_charidentifier` (`charidentifier`),
  ADD INDEX IF NOT EXISTS `idx_horse_tack_storage_charidentifier` (`charidentifier`);

-- Normalize empty/null storage values for easier visual inspection. The script also safely handles NULL.
UPDATE `horse_tack_storage`
SET
  `saddles` = COALESCE(`saddles`, '[]'),
  `blankets` = COALESCE(`blankets`, '[]'),
  `saddle_horns` = COALESCE(`saddle_horns`, '[]'),
  `saddlebags` = COALESCE(`saddlebags`, '[]'),
  `stirrups` = COALESCE(`stirrups`, '[]'),
  `bedrolls` = COALESCE(`bedrolls`, '[]'),
  `lanterns` = COALESCE(`lanterns`, '[]'),
  `masks` = COALESCE(`masks`, '[]');

SET FOREIGN_KEY_CHECKS = 1;
