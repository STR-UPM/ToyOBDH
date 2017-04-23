--------------------------------------------------------------------------------
-- $Id$
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
