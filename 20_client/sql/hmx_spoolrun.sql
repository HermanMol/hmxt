-- Utility: hmx_spoolrun.sql
-- Run the scriptfile in argument1 with spooling to a unique spoolfile
--
-- Family of HMX spooling commands:
--	o hmx_spoolstart.sql
--	o hmx_spoolpause.sql
--	o hmx_spoolresume.sql
--	o hmx_spoolfinish.sql
--	o hmx_spoolrun.sql = hmx_spoolstart + run + hmx_spoolfinish
--
-- Repository: git@github.com:HermanMol/FJ12a_HMX-dev.git
@hmx_spoolstart.sql &1.
@&1.
@hmx_spoolfinish.sql
