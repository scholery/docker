-- Clean unused data.
USE lfcp_jsnd_web

-- DELETE ACT
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM ACT_GE_BYTEARRAY WHERE NAME_ = 'source' OR NAME_ = 'source-extra';
