--------------------------------------------------------------------------------
-- $Id$
-- Project OBSW
-- TC_Task body -- simulatin version
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with HK_TM_Task;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
package body TC_Task is -- sporadi

   task Thread is
      pragma Priority(Thread_Priority);
   end Thread;

   task body Thread is
      C : Character := ' ';
   begin
      loop
         Get_Immediate(C);
         if To_Upper(C) = 'C' then
            HK_TM_Task.Start;
         end if;
      end loop;
   end Thread;

end TC_Task;
