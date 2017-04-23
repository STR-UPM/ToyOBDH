-- $Id: display_task.adb 8 2009-10-02 09:56:55Z jpuente $
-- Project SCADA
-- Display task body
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Parameters, Temperatures, Measurements, Buffer, Screen;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Calendar;
package body Display_Task is -- cyclic

   --------------------
   -- Specifications --
   --------------------

   -- OBCS is not needed

   -- thread
   task Thread is
      pragma Priority(Thread_Priority);
   end Thread;

   -- OPCS
   package OPCS is
      procedure Display;  -- periodic activity
   end OPCS;

   ------------
   -- Bodies --
   ------------

   -- Thread

   task body Thread is
      Next_Time : Time := Parameters.Start_Time;
   begin
      loop
         delay until Next_Time;
         OPCS.Display;
         Next_Time := Next_Time + Milliseconds(Period);
      end loop;
   end Thread;

      -- OPCS
   package body OPCS is

      procedure Display is
         use Temperatures, Measurements;
         M       : Measurement;
         Average : Float := 0.0;
         N       : Natural := 0;
      begin
         Average := 0.0; N := 0;
         while not Buffer.Empty loop
            Buffer.Extract(M);
            Average := Average + Float(M.Value);
            N := N + 1;
         end loop;
         Screen.Put(Ada.Calendar.Clock);
         if N > 0 then
            Average := Average/Float(N);
            Screen.Put(Temperature(Average));
            Screen.Put(" (" & Integer'Image(N) & " values)");
         else
            Screen.Put(" -- no value available --");
         end if;
         Screen.New_Line;
      end Display;

   end OPCS;

end Display_Task;
