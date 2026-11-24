-- Conditionally called from script hmx_report_1object_errors.sql
prompt *A: &v_err_cnt error(s) for &v_obj_type. &v_obj_owner..&v_obj_name.
set head on
set pagesize 50000
set feedback off

select err.line as "Line"   -- line_nr
    ,substr(err.text,1,160)   as "Error" -- error_msg
    ,substr(src.text,1,160)   as "Source" -- src_text
from all_errors err
left join all_source src
    on (    src.owner = err.owner
        and src.name  = err.name
        and src.type  = err.type
        and src.line  = err.line
        )
where err.owner = '&v_obj_owner.'
and err.type    = '&v_obj_type.'
and err.name    = '&v_obj_name.'
and err.text not in ( 'PL/SQL: Statement ignored', 'PL/SQL: SQL Statement ignored')
order by err.line
    ,err.sequence;

set head off
set pagesize 0
set feedback on
prompt (End of error report for &v_obj_type. &v_obj_owner..&v_obj_name.)
