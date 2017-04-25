-- $Id$
--------------------------------------------------------------------------------
-- Project OBDH
-- Reader task specification
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package Reader_Task is -- cyclic
   pragma Elaborate_Body;

   Period   : Natural := 1000; -- ms
   Deadline : Natural :=  100; -- ms
   WCET     : Natural; -- TBC

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

end Reader_Task;
