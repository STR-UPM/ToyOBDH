-- $Id$
-- Project SCADA
-- Reader task body
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Parameters, Temperatures, Measurements, Sensor, Buffer;
--with Screen;
with Ada.Real_Time; use Ada.Real_Time;
package body Reader_Task is -- cyclic

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
      procedure Read;  -- periodic activity
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
         OPCS.Read;
         Next_Time := Next_Time + Milliseconds(Period);
      end loop;
   end Thread;

   -- OPCS
   package body OPCS is

      procedure Read is
         use Temperatures, Measurements, Sensor,  Buffer;
         T : Temperature := Temperature'First;
         M : Measurement;
      begin
         Sensor.Get(T);
         M := (T, Timestamp => Ada.Real_Time.Clock);
         Buffer.Insert(M);
         --Screen.Put(M); Screen.New_line;
      end Read;

   end OPCS;

end Reader_Task;
