-- =================================================================================================
-- Utility: hmx_spoolddlstart.sql
-- Setting for SQLcl/SQL*Plus so the output is a proper DDL source file
-- Arguments:
--  #1 = the spoolfilename, full path
--
-- Family of spooling commands:
--	o hmx_spoolddlstart.sql
--	o hmx_spoolpause.sql
--	o hmx_spoolresume.sql
--	o hmx_spoolfinish.sql
--
-- Date     Engineer Notes
-- 20261112 hmol     Creation, based on hmx_spoolstart.sql
-- =================================================================================================
-- Make shure date is printed properly
alter session set nls_date_format = 'yyyy-mm-dd"T"hh24:mi:ss';
set serveroutput on size unlimited
set linesize  32767
set pagesize  0
set trimout   on
set trimspool on
set echo      off
set verify    off
set feedback  off
set termout   off
set newpage   none
set heading   off
column v_spoolfile new_value v_spoolfile noprint
select lower('&1.')	as v_spoolfile from dual;
set termout on
set long 2000000
column src format a32767
-- *** End set needed variables
spool &v_spoolfile.
