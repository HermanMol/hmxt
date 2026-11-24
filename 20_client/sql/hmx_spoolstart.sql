-- Utility: hmx_spoolstart.sql
-- Generate a unique spoolfile name from the 1st argument added with the database session, user, db-name and datetime.
-- Version 2026-10-15 16:54:11
--
-- Family of HMX spooling commands:
--	o hmx_spoolstart.sql
--	o hmx_spoolpause.sql
--	o hmx_spoolresume.sql
--	o hmx_spoolfinish.sql
--	o hmx_spoolrun.sql = spoolstart + run + spoolfinish
--
-- Repository: git@github.com:HermanMol/FJ12a_HMX-dev.git
--
-- Propper timestamp format
alter session set nls_date_format = 'yyyy-mm-dd"T"hh24:mi:ss';
-- register max 48 bytes of the script being run in v$session.module
set appinfo on
set serveroutput on size unlimited
set linesize  32767
set pagesize  50000
set trimout on
set trimspool on
set echo off
set verify off
set feedback off
set termout off
set newpage none
define arg1 = "&1."

column v_spoolfile new_value v_spoolfile noprint

-- ignore file extension in arg1, if present
-- remove less-handy characters from the spoolfile name, like spaces etc. with an underscore
select regexp_replace(lower(regexp_substr('&arg1.','[^\\/]*? ([^\\/]*) (\.[^.]+)?$',1,1,'imx',1)
                           || '_' || sys_context('userenv','current_user')
                           || '_' || sys_context('userenv','db_name')
                           || '_' || to_char(sysdate, 'yyyymmdd"T"hh24miss')
                           )
                      ,'[^[:alnum:]>_#()]'
                      ,'_'
                      ,1,0,'im'
                     )
       || '.lst' as v_spoolfile
from dual;
set termout on
spool &v_spoolfile.
