rem SUPPRESSED prompt *I: ScriptBOF hmx_report_object_error.sql
-- Conditionally calls one of these scripts:
-- - hmx_report_1object_errors_all.sql  = reporting all errors for the object, or
-- - hmx_report_1object_errors_err.sql  = reporting the object was not found in all_source, or
-- - hmx_report_1object_errors_none.sql = reporting no errors where found for the object
set serveroutput on size unlimited
set linesize 32767
set pagesize 0
set trimout on
set trimspool on
set echo off
set verify off
set feedback off
-- Using SQLcl
argument 1 prompt "#1. Object owner (*)...: "
argument 2 prompt "#2. Object name .......: "
argument 3 prompt "#3. Object type (3)....: "
var v_obj_owner     varchar2(128)
var v_obj_name      varchar2(128)
var v_obj_type      varchar2(128)
var v_rpt_script    varchar2(128)
var v_err_cnt       varchar2(10)

declare
    l_max_src_line number := 0;
begin
    :v_obj_owner    := coalesce(upper(substr(trim(nullif('&1.','*')),1,128)),sys_context('userenv','current_schema'));
    :v_obj_name     := upper(substr(trim('&2.'),1,128));
    :v_obj_type     := case upper(trim('&3.'))
                            when 'PKS' then 'PACKAGE'
                            when 'PKB' then 'PACKAGE BODY'
                            when 'TRG' then 'TRIGGER'
                            when 'PRC' then 'PROCEDURE'
                            when 'FCN' then 'FUNCTION'
                            else upper(trim('&3.'))
                            end;
    :v_err_cnt := null;

    select count(err.line)
        ,max(src.line)
    into :v_err_cnt
        ,l_max_src_line
    from all_source src
    left join all_errors err
        on (    err.owner = src.owner
            and err.name  = src.name
            and err.type  = src.type
            and err.line  = src.line
            and   err.text not in ( 'PL/SQL: Statement ignored', 'PL/SQL: SQL Statement ignored')
            )
    where src.owner = :v_obj_owner
    and   src.type  = :v_obj_type
    and   src.name  = :v_obj_name
    ;

    if l_max_src_line is null
    then
        :v_rpt_script := 'hmx_report_1object_errors_err.sql';
    elsif :v_err_cnt > 0
    then
        :v_rpt_script := 'hmx_report_1object_errors_all.sql';
    else
        :v_rpt_script := 'hmx_report_1object_errors_none.sql';
    end if;
end;
/
tosub v_obj_owner=:v_obj_owner
tosub v_obj_name=:v_obj_name
tosub v_obj_type=:v_obj_type
tosub v_err_cnt=:v_err_cnt
tosub v_rpt_script=:v_rpt_script

@&v_rpt_script.

undefine 1
undefine 2
undefine 3
undefine line_nr
undefine error_msg
undefine v_obj_type
undefine v_obj_name
undefine v_obj_owner
undefine v_err_cnt
undefine v_rpt_script
rem SUPPRESSED prompt *I: ScriptEOF hmx_report_object_error.sql
