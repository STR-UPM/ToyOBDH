-- $Id$
-- Project SCADA
-- Screen body
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Parameters, Measurements;
use  Parameters, Measurements;
with Ada.Text_IO, Ada.Calendar, Ada.Calendar.Formatting;
with Ada.Real_Time;
package body Screen is
   package Calendar  renames Ada.Calendar;
   package Real_Time renames Ada.Real_Time;

   -- OBCS
   protected OBCS is
      procedure Put(T: Temperature);
      procedure Put(M : Measurement);
      procedure Put(T : Calendar.Time);
      procedure Put(S : String);
      procedure New_Line;
   end OBCS;

   -- Provided interface
   procedure Put(T: Temperature) is
   begin
      OBCS.Put(T);
   end Put;

   procedure Put(M : Measurement) is
   begin
      OBCS.Put(M);
   end Put;

   procedure Put(T: Calendar.Time) is
   begin
      OBCS.Put(T);
   end Put;

   procedure Put(S : String) is
   begin
      OBCS.Put(S);
   end Put;

   procedure New_Line is
   begin
      OBCS.New_Line;
   end New_Line;

   -- OPCS
   package OPCS is
      procedure Put(T: Temperature);
      procedure Put(M : Measurement);
      procedure Put(T : Calendar.Time);
      procedure Put(S : String);
      procedure New_Line;
   end OPCS;

   ------------
   -- Bodies --
   ------------

   protected body OBCS is

      procedure Put(T: Temperature) is
      begin
         OPCS.Put(T);
      end Put;

      procedure Put(M : Measurement) is
      begin
         OPCS.Put(M);
      end Put;

      procedure Put(T : Calendar.Time) is
      begin
         OPCS.Put(T);
      end Put;

      procedure Put(S : String) is
      begin
         OPCS.Put(S);
      end Put;

      procedure New_Line is
      begin
         OPCS.New_Line;
      end New_Line;

   end OBCS;

   package body OPCS is
      use Ada.Text_IO;
      package Temperature_IO is new Ada.Text_IO.Fixed_IO(Temperature);

      procedure Put(T: Temperature) is
      begin
         Temperature_IO.Put(T);
      end Put;

      procedure Put(M : Measurement) is
         use Ada.Real_Time;
         SC : Seconds_Count;
         TS : Time_Span;
      begin
         Split(M.Timestamp,SC,TS);
         Ada.Text_IO.Put(SC'Img);
--           Ada.Text_IO.Put(To_Duration(TS)'Img);
         Put(M.Value);
         Ada.Text_IO.New_line;
      end Put;

      procedure Put(T : Calendar.Time) is
         use Ada.Calendar.Formatting;
      begin
         Ada.Text_IO.Put(Image(T));
      end Put;

      procedure Put(S : String) is
      begin
         Ada.Text_IO.Put(S);
      end Put;

      procedure New_Line is
      begin
         Ada.Text_IO.New_Line;
      end New_Line;

   end OPCS;


end Screen;
