--------------------------------------------------------------------------------
-- $Id$
-- Project OBSW
-- TC_Task specification
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package TC_Task is -- sporadic
   pragma Elaborate_Body;

   -- Receive telecommands

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

end TC_Task;
