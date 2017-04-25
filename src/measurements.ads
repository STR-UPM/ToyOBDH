-- $Id$
--------------------------------------------------------
-- Project OBDH
-- Measurement types definition
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Ada.Real_Time;
package Measurements is
   use Ada.Real_Time;

   -- Temperature range and resolution (Celsius) as provided by 18B20 sensor
   type Temperature is delta 0.00625 range -55.0 .. +125.0;

   -- A measurement is a time-stamped temperature value
   type Measurement is tagged
      record
         Value     : Temperature;
         Timestamp : Time;
      end record;

   -- Length of housekeeping history log to be sent to ground
   HK_Length : constant Positive := 5;

   -- Data for HK TM messages
   type HK_Data is array (1..HK_Length) of Measurement;

end Measurements;
