-- $Id: temperatures.ads 8 2009-10-02 09:56:55Z jpuente $
--------------------------------------------------------------------------------
-- Project SCADA
-- Temperature type definition
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
package Temperatures is

   -- A fixed-point type is used for temperature values in order to keep
   -- the sensor's absolute precision
   type Temperature is delta 0.01 range 00.0 .. 99.0;

end Temperatures;
