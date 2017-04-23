--------------------------------------------------------------------------------
-- $Id: parameters.ads 59 2017-04-21 12:10:34Z jpuente $
-- Project SCADA
-- SCADA parameters specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
-------------------------------------------------------------------------------
with Ada.Real_Time; use Ada.Real_Time;
package Parameters is

   Start_Time : Time := Clock + To_Time_Span(5.0);

end Parameters;
