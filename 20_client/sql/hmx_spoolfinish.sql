-- Utility: hmx_spoolfinish.sql
-- Finish the spooling to the spoolfile started with hmx_spoolstart. Reset v_spoolfile
--
-- Family of HMX spooling commands:
--	o hmx_spoolstart.sql
--	o hmx_spoolpause.sql
--	o hmx_spoolresume.sql
--	o hmx_spoolfinish.sql
--	o hmx_spoolrun.sql = spoolstart + run + spoolfinish
--
-- Repository: git@github.com:HermanMol/FJ12a_HMX-dev.git
--
@hmx_spoolpause.sql
undefine v_spoolfile
