--------------------------------------------------------------------------------
-- $Id$
-- Project SCADA
-- Check task specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package Check_Task is -- sporadic

   Separation : Natural := 1_000; -- ms
   Deadline   : Natural :=    30; -- ms
   WCET       : Natural;

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

   OBCS_Ceiling    : System.Priority := System.Priority'Last;
   -- replace with IPCP priority

   procedure Start;

end Check_Task;
