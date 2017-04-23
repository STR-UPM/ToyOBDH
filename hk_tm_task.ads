--------------------------------------------------------------------------------
-- $Id$
-- Project OBSW
-- HK TM task specification
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with System;
package HK_TM_Task is -- sporadic

   Separation : Natural :=  1000; -- ms
   Deadline   : Natural :=    30; -- ms
   WCET       : Natural;

   Thread_Priority : System.Priority := System.Default_Priority;
   -- replace with DMS priority

   OBCS_Ceiling    : System.Priority := System.Priority'Last;
   -- replace with IPCP priority

   procedure Start;

end HK_TM_Task;
