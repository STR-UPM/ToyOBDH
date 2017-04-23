-- $Id$
-- Project SCADA
-- Buffer for measurement data
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use  Measurements;
package Buffer is -- protected

   procedure Insert  (M: in  Measurement);
   procedure Extract (M: out Measurement);
   function  Empty return Boolean;
   function  Full  return Boolean;

   Buffer_Capacity : constant Positive := 100;

end Buffer;
