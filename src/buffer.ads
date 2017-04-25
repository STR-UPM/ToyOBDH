-- $Id$
--------------------------------------------------------------------------------
-- Project OBDH
-- Buffer for measurement data
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements;

-- Measurement buffer. Measurements are inserted and extracted in
-- FIFO order.
package Buffer is -- protected
   use  Measurements;

   -- Insert a measurement into the buffer.
   -- Overwrite the oldest element if the buffer is full.
   procedure Put  (M: in  Measurement);

   -- Extract a measurement from the buffer.
   -- Raise Constraint_Error if the buffer is empty.
   procedure Get (M: out Measurement);

   -- Get most recent measurement. The data is not erased.
   -- Raise Constraint_Error if no data have been input.
   function Last return Measurement;

   -- Test for empty buffer
   function  Empty return Boolean;

   -- Test for full bufer
   function  Full  return Boolean;

   Capacity : constant Positive := 5;

end Buffer;
