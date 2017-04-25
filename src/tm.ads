-- $Id$
-- Project OBSW
-- TM specification
-- Copyright (c) 2008 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use Measurements;
with Ada.Real_Time; use Ada.Real_Time;
package TM is -- protected

   type TM_Type is (Basic, HK);

   type TM_Message (Kind : TM_Type) is
      record
         Timestamp : Time;
         case Kind is
            when Basic =>
               Data  : Measurement;
            when HK =>
               Data_Log  : HK_Data;
               Length    : Positive;
         end case;
      end record;


   -- Send TM message
   procedure Send (Message : TM_Message);

end TM;
