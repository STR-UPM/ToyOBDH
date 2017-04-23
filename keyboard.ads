--------------------------------------------------------------------------------
-- $Id: keyboard.ads 8 2009-10-02 09:56:55Z jpuente $
-- Project SCADA
-- Keyboard specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package Keyboard is -- sporadic
   pragma Elaborate_Body;

   -- This a special compononent which emulates a keyboard
   -- interrupt

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

end Keyboard;
