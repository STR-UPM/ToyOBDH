--------------------------------------------------------------------------------
-- $Id$
-- Package Buffers
-- Generic bounded buffers with no tasking protection
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
generic
   type Element is private; -- the type of the elements stored in the buffer
package Buffers is
   pragma Pure;

   type Buffer (Capacity : Positive) is tagged limited private;

   procedure Insert (B:    in out Buffer;
                     Item: in     Element);
   -- raises Constraint_Error if the buffer is full

   procedure Remove (B:    in out Buffer;
                     Item: out    Element);
   -- raises Constraint_Error if the buffer is empty

   function Empty(  B: Buffer) return Boolean;
   function Full   (B: Buffer) return Boolean;
   function Extent (B: Buffer) return Natural; -- number of elements stored

private
   type Store is array (Positive range <>) of Element;
   type Buffer (Capacity: Positive) is tagged limited
      record
         Data     :  Store (1..Capacity);
         Next_In  :  Positive := 1;
         Next_Out :  Positive := 1;
         Count    :  Natural  := 0;
      end record;
end Buffers;
