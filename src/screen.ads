-- $Id$
-- Project SCADA
-- Screen specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use Measurements;
with Ada.Calendar; use Ada.Calendar;
package Screen is -- protected

   -- Write operations
   procedure Put(T: Temperature);
   procedure Put(M : Measurement);
   procedure Put(T : Time);
   procedure Put(S : String);
   procedure New_Line;

end Screen;
