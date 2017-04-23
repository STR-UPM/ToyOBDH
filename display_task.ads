--------------------------------------------------------------------------------
-- $Id$
-- Project SCADA
-- Display task specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package Display_Task is -- cyclic
   pragma Elaborate_Body;

   Period   : Natural := 5_000; -- ms
   Deadline : Natural :=    50; -- ms
   WCET     : Natural;

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

end Display_Task;
