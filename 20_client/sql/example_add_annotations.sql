-- Version 2026-10-18 15:25:37
-- Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
-- Date 2026-10-18 16:29:02 CET
--
-- H:\90_refs\oracle_refs\scripts\annotations\add annotations.sql
alter view hmx_sys_context_userenv 
    annotations 
        (replace hmx_object_repo    'git@github.com:HermanMol/FJ12a_HMX-dev.git'
        ,replace hmx_object_version '2026-10-20 09:33:58 +02:00'
        ,replace hmx_object_usage   'This view is used to show values of the USERENV context and avoid an exception to occur when an unknown context attribute is requested.'
        )
/
alter view hmx_all_object_versions 
    annotations 
        (add hmx_object_repo    'git@github.com:HermanMol/FJ12a_HMX-dev.git'
        ,add hmx_object_version '2026-10-21 09:35:50 +02:00'
        ,add hmx_object_usage   'This view lists all HMX annotations: Oracle Annotatons and HMX object annotations.'
        )
/
