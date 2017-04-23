-- $Id$
-- Project SCADA
-- Buffer for measurement data
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use  Measurements;
with Buffers;
with Ada.Text_IO; use Ada.Text_IO;
package body Buffer is
   package Measurement_Buffers is new Buffers(Measurement);
   use Measurement_Buffers;

   -- OBCS
   protected OBCS is
      procedure Insert(M: in  Measurement);
      procedure Extract (M: out Measurement);
      function  Empty return Boolean;
      function  Full  return Boolean;
   end OBCS;

   -- Provided interface
   procedure Insert  (M: in  Measurement) is
   begin
      OBCS.Insert(M);
   end Insert;

   procedure Extract (M: out Measurement) is
   begin
      OBCS.Extract(M);
   end Extract;

   function  Empty return Boolean is
   begin
      return OBCS.Empty;
   end Empty;

   function  Full return Boolean is
   begin
      return OBCS.Full;
   end Full;

   -- OPCS
   B : Measurement_Buffers.Buffer(Capacity => Buffer_Capacity);
   -- operations provided by package Measurement_Buffers

   -- OBCS body

   protected body OBCS is

      procedure Insert(M: in  Measurement) is
      begin
         B.Insert(M);
      end Insert;

      procedure Extract (M: out Measurement) is
      begin
         B.Remove(M);
      end Extract;

      function Empty return Boolean is
      begin
         return B.Empty;
      end Empty;

      function Full return Boolean is
      begin
         return B.Full;
      end Full;

   end OBCS;

end Buffer;
