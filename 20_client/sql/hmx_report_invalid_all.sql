prompt *I: ScriptBOF hmx_report_invalid_all.sql
/* <hmx-annotations>

.HMX_OBJECT_USAGE: Report all invalid objects

.HMX_OBJECT_NOTES:
    Only the objects that are within schemas we are responsible for.
    Ignore what is maintained by Oracle and some schemas by name.

.HMX_DEVELOPER_NOTES: See HMX General Developer Notes
.HMX_OBJECT_VERSION: 2026-10-27 10:01:23 +01:00
.HMX_DB_VERSION: Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
.HMX_OBJECT_REPO: git@github.com:HermanMol/FJ12a_HMX-dev.git

** </hmx-annotations> */
-- -----------------------------------------------------------------------------
set heading on
set linesize 32767
set pagesize 50000

column obj_owner     format A5  heading OWNER
column obj_type      format A30 heading TYPE
column obj_name      format A30 heading NAME
column obj_status    format A10 heading STATUS
column obj_timestamp format A19 heading TIMESTAMP

select obj.owner        as obj_owner
    ,obj.object_type    as obj_type
    ,obj.object_name    as obj_name
    ,obj.status         as obj_status
    ,greatest(to_char(obj.last_ddl_time,'yyyy-mm-dd hh24:mi:ss'),obj.timestamp)      as obj_timestamp
from all_users      usr
join all_objects    obj
	on  (   obj.owner = usr.username
		and obj.oracle_maintained <> 'Y'
		and obj.status <> 'VALID'
		)
where usr.username not in ('CRQ','MDSYS','ORACLE','OAQMANAGER')
and usr.oracle_maintained <> 'Y'
order by obj.owner
    ,obj.object_type
    ,obj.object_name;

set heading off
set pagesize 0

prompt *I: ScriptEOF hmx_report_invalid_all.sql
