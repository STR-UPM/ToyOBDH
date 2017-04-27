-- $Id$
--------------------------------------------------------------------------------
-- Project OBDH
-- Temperature sensor specification
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements;
package Sensor is  -- passive
   use Measurements;

   procedure Get (T : out Temperature);

end Sensor;