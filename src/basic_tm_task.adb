-- $Id$
-- Project OBSW
-- Basic TM task body
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Parameters, Measurements, Buffer;
with Ada.Real_Time;
with Ada.Calendar;
with Screen;
package body Basic_TM_Task is -- cyclic

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
      procedure Basic_TM;  -- periodic activity
   end OPCS;

   ------------
   -- Bodies --
   ------------

   -- Thread

   task body Thread is
      use Ada.Real_Time;
      Next_Time : Time := Parameters.Start_Time +  Milliseconds(6000);
   begin
      loop
         delay until Next_Time;
         OPCS.Basic_TM;
         Next_Time := Next_Time + Milliseconds(Period);
      end loop;
   end Thread;

      -- OPCS
   package body OPCS is

      procedure Basic_TM is
         use Measurements, Ada.Real_Time;
         M  : Measurement;
      begin
         M := Buffer.Last;
         Screen.Put(M);
      end Basic_TM;

   end OPCS;

end Basic_TM_Task;
