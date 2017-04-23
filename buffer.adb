-- $Id$
--------------------------------------------------------------------------------
-- Project OBSW
-- Buffer for measurement data
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use  Measurements;
with Ada.Text_IO; use Ada.Text_IO;
package body Buffer is

   -- OBCS spec
   type Index is mod Capacity;
   type Store is array (Index) of Measurement;

   protected OBCS is
      procedure Put (M: in  Measurement);
      procedure Get (M: out Measurement);
      function  Last  return Measurement;
      function  Empty return Boolean;
      function  Full  return Boolean;
   private
      Data     :  Store;
      Next_In  :  Index   := 0; -- next new item
      Last_In  :  Index   := 0; -- newest item in buffer
      Next_Out :  Index   := 0; -- oldest item in buffer
      Count    :  Natural := 0;
   end OBCS;

   -- Provided interface
   procedure Put  (M: in  Measurement) is
   begin
      OBCS.Put(M);
   end Put;

   procedure Get (M: out Measurement) is
   begin
      OBCS.Get(M);
   end Get;

   function Last return Measurement is
   begin
      return OBCS.Last;
   end Last;

   function  Empty return Boolean is
   begin
      return OBCS.Empty;
   end Empty;

   function  Full return Boolean is
   begin
      return OBCS.Full;
   end Full;

   -- OBCS body

   protected body OBCS is

      procedure Put (M: in  Measurement) is
      begin
         Data(Next_In) := M;
         Last_In := Next_In;
         Next_In := Next_In + 1;
         if Count < Capacity then
            Count   := Count + 1;
         else -- buffer full, forget oldest measurement
            Next_Out := Next_Out + 1;
         end if;
      end Put;

      procedure Get (M: out Measurement) is
      begin
         if Empty then
            raise Constraint_Error;
         end if;
         M := Data(Next_Out);
         Next_Out := Next_Out + 1;
         Count := Count - 1;
      end Get;

      function Last return Measurement is
      begin
        return data(Last_In);
      end Last;

      function Empty return Boolean is
      begin
         return Count = 0;
      end Empty;

      function Full return Boolean is
      begin
         return Count = Capacity;
      end Full;

   end OBCS;

end Buffer;
