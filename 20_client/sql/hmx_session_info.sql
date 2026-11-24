/* <hmx-annotations>

.HMX_OBJECT_USAGE: This script lists interesting settings of the current Oracle DB session.

.HMX_OBJECT_NOTES:
    - Assumed SQLcl settings:
      set serveroutput on size unlimited
      set linesize  32767
      set pagesize  0
      set trimout on
      set trimspool on
      set echo off
      set verify off
      set feedback off
      set termout off
      set newpage none
      set heading off

.HMX_DEVELOPER_NOTES: See HMX General Developer Notes
.HMX_OBJECT_VERSION: 2026-10-28 14:03:04 +01:00
.HMX_SQLCL_VERSION: 26.3.0.0 build: 26.3.0.260.1620
.HMX_DB_VERSION: Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
.HMX_OBJECT_REPO: git@github.com:HermanMol/FJ12a_HMX-dev.git

** </hmx-annotations> */

select '*I: Current session settings  (' || to_char(systimestamp,'yyyy-mm-dd hh24:mi:ss TZH:TZM') || ')'
    || chr(10) || '    - Local timestamp........: ' || to_char(current_timestamp,'yyyy-mm-dd hh24:mi:ss TZH:TZM')
    || chr(10) || '    - OS_USER................: ' || sys_context('USERENV', 'OS_USER')
    || chr(10) || '    - HOST...................: ' || sys_context('USERENV', 'HOST')
    || chr(10) || '    - DB_NAME................: ' || sys_context('USERENV', 'DB_NAME')
    || chr(10) || '    - DBTIMEZONE.............: ' || dbtimezone
                                                    || ' / ' || tz_offset(dbtimezone)
    || chr(10) || '    - SESSIONTIMEZONE........: ' || sessiontimezone
                                                    || ' / ' || tz_offset(sessiontimezone)
                                                    || ' / ' || extract(timezone_abbr from current_timestamp)
    || chr(10) || '    - SESSION_USER...........: ' || sys_context('USERENV', 'SESSION_USER')
    || chr(10) || '    - CURRENT_USER...........: ' || sys_context('USERENV', 'CURRENT_USER')
    || chr(10) || '    - CURRENT_SCHEMA.........: ' || sys_context('USERENV', 'CURRENT_SCHEMA')
    || chr(10) || '    - LANG...................: ' || sys_context('USERENV', 'LANG')
    || chr(10) || '    - LANGUAGE...............: ' || sys_context('USERENV', 'LANGUAGE')
    || chr(10) || '    - NLS_DATE_FORMAT........: ' || sys_context('USERENV', 'NLS_DATE_FORMAT')
--    || chr(10) || '    - NLS_TIMESTAMP_FORMAT...: ' || sys_context('USERENV', 'NLS_TIMESTAMP_FORMAT')    not in USERENV
--    || chr(10) || '    - NLS_TIMESTAMP_TZ_FORMAT: ' || sys_context('USERENV', 'NLS_TIMESTAMP_TZ_FORMAT') not in USERENV
    || chr(10) || '    - NLS_DATE_LANGUAGE......: ' || sys_context('USERENV', 'NLS_DATE_LANGUAGE')
    || chr(10) || '    - NLS_CALENDAR...........: ' || sys_context('USERENV', 'NLS_CALENDAR')
    || chr(10) || '    - NLS_TERRITORY..........: ' || sys_context('USERENV', 'NLS_TERRITORY')
    || chr(10) || '    - NLS_SORT...............: ' || sys_context('USERENV', 'NLS_SORT')
    || chr(10) || '    - NLS_CURRENCY...........: ' || sys_context('USERENV', 'NLS_CURRENCY')
    || chr(10) || '    - PLATFORM_SLASH.........: ' || sys_context('USERENV', 'PLATFORM_SLASH')
    || chr(10) || '    - Monday day-of-week.....: ' || to_char(to_date('20210913','yyyymmdd'),'d "("dd-mm-yyyy")"')
    || chr(10) || '    - Numeric characters.....: ' || trim(to_char(123456789 / 1000,'999g999g990d9999') )
    as cmd
from dual
/
