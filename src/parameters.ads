--------------------------------------------------------------------------------
-- $Id$
-- Project OBDH
-- OBDH parameters specification
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
-------------------------------------------------------------------------------
with Ada.Real_Time; use Ada.Real_Time;
package Parameters is

   -- Start time for all tasks. Allow for some delay in order to
   -- mas sure that all the components are properly initialized
   Start_Time : Time := Clock + Milliseconds(1000);

end Parameters;
