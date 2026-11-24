/* <hmx-annotations>

.HMX_OBJECT_USAGE: Script to generate a HMX_OBJECT_VERSION annotation line.
.HMX_OBJECT_NOTES: Output as query result.
    The For_HMX_objects version refers to HMX-annotations
    The For_Oracle_Annotation version refers to the Oracle Annotation, currently
    (2026-10-21) only for the Oracle types: table, view, materialized view and index.
.HMX_DEVELOPER_NOTES: See HMX General Developer Notes
.HMX_OBJECT_VERSION: 2026-10-22 09:50:35 +02:00
.HMX_DB_VERSION: Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
.HMX_OBJECT_REPO: git@github.com:HermanMol/FJ12a_HMX-dev.git

** </hmx-annotations> */

select '.HMX_OBJECT_VERSION'  || ':'
    || ' ' || to_char(current_timestamp,'yyyy-mm-dd hh24:mi:ss TZH:TZM')
    as for_hmx_objects
    ,'add hmx_object_version'     
        || ' ''' || to_char(current_timestamp,'yyyy-mm-dd hh24:mi:ss TZH:TZM')
        || ''''
        as for_oracle_annotation
from dual
/
