-- $Id$
--------------------------------------------------------------------------------
-- Project OBDH
-- Temperature sensor body -- simulation version
-- Copyright (c) 20q7 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
with Measurements; use Measurements;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions, Ada.Numerics.Float_Random;
use Ada.Numerics,
    Ada.Numerics.Elementary_Functions, Ada.Numerics.Float_Random;
package body Sensor is

   Min_T : Temperature :=  5.0; -- Celsius
   Max_T : Temperature := 25.0;

   Min_Time : Day_Duration :=  7.0*3600.0; -- 7 am
   Max_Time : Day_Duration := 15.0*3600.0; -- 3 pm

   Noise : Generator;

   T_Range  : Float := Float(Max_T - Min_T)/2.0;
   T_Average: Float := Float(Max_T + Min_T)/2.0;
   T_Period : Float := 86_400.0;  -- 1 day

   ---------
   -- Get --
   ---------

   procedure Get (T : out Temperature) is
      T_Phase  : Float := Float(Seconds(Clock)- Min_Time)/T_Period;
   begin
      T := Temperature(T_Average + T_Range*sin(2.0*Pi*T_Phase)
                       + Random(Noise) - 0.5);
   end Get;

end Sensor;
