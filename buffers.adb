--------------------------------------------------------------------------------
-- $Id: buffers.adb 8 2009-10-02 09:56:55Z jpuente $
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
package body Buffers is

   ------------
   -- Insert --
   ------------

   procedure Insert
     (B:    in out Buffer;
      Item: in     Element)
   is
   begin
      if B.Full then
         raise Constraint_Error;
      end if;
      B.Data(B.Next_In) := Item;
      B.Next_In := (B.Next_In mod B.Capacity) +1;
      B.Count   := B.Count + 1;
   end Insert;

   ------------
   -- Remove --
   ------------

   procedure Remove
     (B:    in out Buffer;
      Item: out    Element)
   is
   begin
      if B.Empty then
         raise Constraint_Error;
      end if;
      Item := B.Data(B.Next_Out);
      B.Next_Out := (B.Next_Out mod B.Capacity) +1;
      B.Count := B.Count - 1;
   end Remove;

   -----------
   -- Empty --
   -----------

   function Empty (B: Buffer) return Boolean is
   begin
      return B.Count = 0;
   end Empty;

   ----------
   -- Full --
   ----------

   function Full (B: Buffer) return Boolean is
   begin
      return B.Count = B.Capacity;
   end Full;

   ------------
   -- Extent --
   ------------

   function Extent (B: Buffer) return Natural is
   begin
      return B.Count;
   end Extent;

end Buffers;
