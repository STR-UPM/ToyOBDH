--------------------------------------------------------------------------------
-- $Id$
-- Project OBSW
-- HK task task body
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Buffer, TM, Measurements;
with Ada.Real_Time;

package body HK_TM_Task is -- sporadic

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
      procedure Send_HK_Data;  -- sporadic activity
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
         OPCS.Send_HK_Data;
      end loop;
   end Thread;

   -- OPCS
   package body OPCS is

      procedure Send_HK_Data is
         use Measurements, TM;
         M : Measurement;
         Message : TM_Message(HK);
      begin
         Message.Timestamp := Ada.Real_Time.Clock;
         for I in Message.Data_Log'Range loop
            exit when Buffer.Empty;
            Buffer.Get(M);
            Message.Data_Log(I) := M;
            Message.Length := I;
         end loop;
         TM.Send(Message);
      end Send_HK_Data;

   end OPCS;

end HK_TM_Task;
