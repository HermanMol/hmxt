/* <hmx-annotations>

.HMX_OBJECT_USAGE: Generate the default HMX-annotation block in DBMS_OUTPUT.
.HMX_OBJECT_NOTES: These HMX-annotations are HMX-domain specific and apply to
    annotations for all objects types that cannot have Oracle Annotations. 
    At this moment (2026-10-21) The Oracle Annotations only apply to the 
    object types : table, view, materialized view and index.
.HMX_DEVELOPER_NOTES: See HMX General Developer Notes
.HMX_OBJECT_VERSION: 2026-10-22 09:36:13 +02:00
.HMX_DB_VERSION: Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production Version 19.33.0.1.0
.HMX_OBJECT_REPO: git@github.com:HermanMol/FJ12a_HMX-dev.git

** </hmx-annotations> */

declare

    -- Procedure to generate an HMX-annotation block
    procedure hmx_generate_annotation_block
        (pi_repo in varchar2 := null)
    as
        l_db_version_banner varchar2(4000);
    begin

        prt;
        prt('....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0');
        prt;
        prt('/* <hmx-annotations>');
        prt;
        prt('  *TIP: Generate this block with tool HMX_GENERATE_ANNOTATION_BLOCK.SQL');
        prt('  *TIP: Generate HMX_DB_VERSION line with tool HMX_GENERATE_ANNOTATION_VERSION_LINE.SQL');
        prt;
        prt('.HMX_OBJECT_USAGE: This package/script...');
        prt();
        prt('.HMX_OBJECT_NOTES:');
        prt('    ?Package must be invoker rights (AUTHID CURRENT_USER)');
        prt('    ...');
        prt;
        prt('.HMX_DEVELOPER_NOTES: See HMX General Developer Notes');
        prt('.HMX_OBJECT_VERSION:'
            || ' ' || to_char(current_timestamp,'yyyy-mm-dd hh24:mi:ss TZH:TZM')
            );
        select replace (banner_full,chr(10),' ') as db_banner_full
        into l_db_version_banner
        from v$version;
        prt('.HMX_DB_VERSION: ' || l_db_version_banner);
        if pi_repo is not null
        then
            prt('.HMX_OBJECT_REPO: ' || pi_repo);
        end if;
        prt;
        prt('** </hmx-annotations> */');
        prt;
        prt('....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0');
        prt;

    end hmx_generate_annotation_block;

begin
    hmx_generate_annotation_block('git@github.com:HermanMol/FJ12a_HMX-dev.git');
exception
    when others
    then
        prt('*E: ' || sqlerrm);
end;
/
prompt .HMX_OBJECT_VERSION:
version
