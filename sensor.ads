-- $Id: sensor.ads 8 2009-10-02 09:56:55Z jpuente $
--------------------------------------------------------------------------------
-- Project SCADA
-- Temperature sensor specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Temperatures;   use Temperatures;
package Sensor is  -- passive

   procedure Get (T : out Temperature);

end Sensor;
