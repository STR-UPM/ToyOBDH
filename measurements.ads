--------------------------------------------------------------------------------
-- $Id$
-- Project SCADA
-- Measurement type definition
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Temperatures;
with Ada.Real_Time;
package Measurements is
   use Temperatures, Ada.Real_Time;

   -- A measurement ia a pair (Temperature, Time)
   type Measurement is tagged
      record
         Value     : Temperature;
         Timestamp : Time;
      end record;

end Measurements;
