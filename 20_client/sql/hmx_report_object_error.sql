prompt *I: ScriptBOF hmx_report_object_error.sql
set linesize 32767
set pagesize 0
set trimout on
set trimspool on
set echo off
set verify off
set feedback off
column line_nr   format 9999
column error_msg format a80 word_wrapped

set feedback on;
set head on;
select err.name     as obj_name
    ,err.type       as obj_type
    ,err.line       as line_nr
    ,err.text       as error_msg
    ,src.text
from all_errors err
left join all_source src
    on (    src.owner = err.owner
        and src.name  = err.name
        and src.type  = err.type
        and src.line  = err.line
        )
where err.owner = sys_context('userenv','current_schema')
and err.text not in ( 'PL/SQL: Statement ignored', 'PL/SQL: SQL Statement ignored')
order by err.name
    ,err.type
    ,err.line
    ,err.sequence;

prompt *I: ScriptEOF hmx_report_object_error.sql
