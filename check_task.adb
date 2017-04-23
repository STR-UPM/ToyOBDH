--------------------------------------------------------------------------------
-- $Id$
-- Project SCADA
-- Check task body
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Buffer, Screen, Measurements;
package body Check_Task is -- sporadic
--------------------
   -- Specifications --
   --------------------

   -- OBCS
   protected OBCS is
      pragma Priority (OBCS_Ceiling);
      procedure Signal; -- not used
      entry Wait;
   private
      Occurred : Boolean := False;
   end OBCS;

   -- thread
   task Thread is
      pragma Priority(Thread_Priority);
   end Thread;

   -- OPCS
   package OPCS is
      procedure Check;  -- sporadic activity
   end OPCS;

   ------------------------
   -- Provided interface --
   ------------------------

   procedure Start is
   begin
      OBCS.Signal;
   end Start;

   ------------
   -- Bodies --
   ------------

   -- OBCS
   protected body OBCS is

      procedure Signal is
      begin
         Occurred := True;
      end Signal;

      entry Wait when Occurred is
      begin
         Occurred := False;
      end Wait;

   end OBCS;

   -- Thread

   task body Thread is
   begin
      loop
         OBCS.Wait;
         OPCS.Check;
      end loop;
   end Thread;

   -- OPCS
   package body OPCS is

      procedure Check is
         use Measurements;
         M : Measurement;
      begin
         Screen.Put("------ stored measurements ------");
         Screen.New_Line;
         while not Buffer.Empty loop
            Buffer.Extract(M);
            Screen.Put(M);
            Screen.New_Line;
         end loop;
         Screen.Put("------ end -----------------------");
         Screen.New_Line;
      end Check;

   end OPCS;

end Check_Task;
