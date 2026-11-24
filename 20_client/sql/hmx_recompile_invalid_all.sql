prompt *I: ScriptBOF hmx_recompile_invalid_all.sql
/* <hmx-annotations>

.HMX_OBJECT_USAGE: Recompile all invalid objects

.HMX_OBJECT_NOTES:
    Only the objects that are within schemas we are responsible for.
    Types: Function, Procedure, Package, Package Body, View, Trigger, Type, Type Body
    Ignore what is maintained by Oracle and some schemas by name.
    If invalid objects remain you may have to run this script several times.

.HMX_DEVELOPER_NOTES: See HMX General Developer Notes
.HMX_OBJECT_VERSION: 2026-10-27 10:01:23 +01:00
.HMX_DB_VERSION: Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
.HMX_OBJECT_REPO: git@github.com:HermanMol/FJ12a_HMX-dev.git

** </hmx-annotations> */
declare
	l_cnt_recs	number := 0;
	l_cnt_pass	number := 0;
	l_cnt_fail	number := 0;
begin
	<<all_our_objects>>
	for r_schema in
	(
		select usr.username	as our_schema
			,count(*) 		as cnt_not_valid
		from all_users      usr
		join all_objects    obj
			on  (   obj.owner = usr.username
				and obj.oracle_maintained <> 'Y'
				and obj.status <> 'VALID'
				and obj.object_type in ('FUNCTION', 'PROCEDURE','PACKAGE','PACKAGE BODY','VIEW','TRIGGER','TYPE', 'TYPE BODY')
				)
		where usr.oracle_maintained <> 'Y'
        and usr.username not in ('CRQ','MDSYS','ORACLE','OAQMANAGER')
		group by username
		order by username
	)
	loop
		dbms_output.put_line('*I: Recompiling'
			|| ' ' || r_schema.cnt_not_valid || ' non-valid object(s)'
			|| ' in schema ' || r_schema.our_schema
			);
		dbms_utility.compile_schema(r_schema.our_schema,FALSE,FALSE);
	end loop all_our_objects;

	<<all_our_synonyms>>
	for r_synonym in
	(
		select obj.owner		as synonym_owner
			,obj.object_name	as synonym_name
		from all_users      usr
		join all_objects    obj
			on  (   obj.owner = usr.username
				and obj.oracle_maintained <> 'Y'
				and obj.status <> 'VALID'
				and obj.object_type = 'SYNONYM' 
				)
		where usr.oracle_maintained <> 'Y'
        and usr.username not in ('CRQ','MDSYS','ORACLE','OAQMANAGER')
		order by obj.owner
			,obj.object_name
	)
	loop
		l_cnt_recs := l_cnt_recs + 1;
		dbms_output.put_line('*I: Recompiling synonym'
			|| ' ' || r_synonym.synonym_owner 
			|| '.' || r_synonym.synonym_name
			);
		if r_synonym.synonym_owner = 'PUBLIC'
		then
			begin
				execute immediate('alter public synonym ' || r_synonym.synonym_name || ' compile');
				l_cnt_pass := l_cnt_pass + 1;
			exception
				when others
				then
					dbms_output.put_line('*W: alter public synonym ' || r_synonym.synonym_name || ' FAILED');
					l_cnt_fail := l_cnt_fail + 1;
			end;
		else
			begin
				execute immediate('alter synonym ' || r_synonym.synonym_owner || '.' || r_synonym.synonym_name || ' compile');
				l_cnt_pass := l_cnt_pass + 1;
			exception
				when others
				then
					dbms_output.put_line('*W: alter synonym ' || r_synonym.synonym_owner || '.' || r_synonym.synonym_name ||'  FAILED');
					l_cnt_fail := l_cnt_fail + 1;
			end;
		end if;
	end loop all_our_synonyms;
	
	dbms_output.put_line ('*I: Recompiled synonyms: ' || l_cnt_recs);
	dbms_output.put_line ('*I:     of which failed: ' || l_cnt_fail);
	dbms_output.put_line ('*I:     of which passed: ' || l_cnt_pass);

end;
/
prompt *I: ScriptEOF hmx_recompile_invalid_all.sql
