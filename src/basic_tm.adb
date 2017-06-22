-- $Id: basic_tm_task.adb 80 2017-04-27 13:05:18Z jpuente $
-- Project OBDH
-- Basic TM task body
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements;       use Measurements;
with TM;                 use TM;
with Buffer;
with Ada.Real_Time;      use Ada.Real_Time;

package body Basic_TM is -- cyclic

   -------------------------
   -- Internal operations --
   -------------------------

   procedure Send_Temperature;
   -- Send a TM message with the last temperature value.

   ------------------------
   -- Basic TM task body --
   ------------------------

   task body Basic_TM_Task is
      Next_Time : Time :=  Clock + Milliseconds(Start_Delay);
   begin
      loop
         delay until Next_Time;
         Send_Temperature;
         Next_Time := Next_Time + Milliseconds(Period);
      end loop;
   end Basic_TM_Task;

   ----------------------
   -- Send temperature --
   ----------------------

   procedure Send_Temperature is
      Message : TM_Message(Basic);
   begin
      Message.Timestamp := Clock;
      Message.Data      := Buffer.Last;
      Send(Message);
   end Send_Temperature;

end Basic_TM;
