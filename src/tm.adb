-- $Id$
-- Project OBSW
-- TM body - simulation version
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements;
with Ada.Real_Time;
with System.IO;

package body TM is
   use  Measurements;

   -- OBCS
   protected OBCS is
      procedure Send (Message : TM_Message);
   end OBCS;

   -- Provided interface
   procedure Send (Message : TM_Message) is
   begin
      OBCS.Send(Message);
   end Send;

   -- OPCS
   package OPCS is
      procedure Send (Message : TM_Message);
   end OPCS;

   ------------
   -- Bodies --
   ------------

   protected body OBCS is

      procedure Send (Message : TM_Message) is
      begin
         OPCS.Send(Message);
      end Send;
   end OBCS;

   package body OPCS is

      procedure Send (Message : TM_Message) is
         use Ada.Real_Time;

         SC : Seconds_Count;
         TS : Time_Span;
         M  : Measurement;
      begin
         case Message.Kind is
            when Basic =>
               M := Message.Data;
               Split(M.Timestamp, SC, TS);
               System.IO.Put_Line(SC'Img & " " & M.Value'Img);
            when HK =>
               System.IO.Put_Line("----- HK data -----");
               for i in 1..Message.Length loop
                  M := Message.Data_Log(i);
                  Split(M.Timestamp, SC, TS);
                  System.IO.Put_Line(SC'Img & " " & M.Value'Img);
               end loop;
               System.IO.Put_Line("--------------------");
         end case;
      end Send;

   end OPCS;

end TM;
