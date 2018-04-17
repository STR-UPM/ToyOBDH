------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2017, Universidad Politécnica de Madrid           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

--  Temperature sensor implementation.

--  This version is for a SunFounder DS18B20 sensor connected
--  to a RaspberryPi board through GPIO pin 4.

--  The board OS is Raspbian Linux. The following linux
--  commands must be executed in order to load the sensor driver
--  into the linux kernel:
--    $ sudo modprobe w1-gpio
--    $ sudo modprobe w1-therm

--  The sensor is read by reading the following file:
--  "/sys/bus/w1/devices/"&ID&"/w1_slave";
--  Where ID is a string with identity of the sensor (e.g. "28-0516a0ef7bff")
--  In order to find the ID of your device read the following file:
--  $ cat /sys/bus/w1/devices/w1_bus_master1/w1_master_slaves

--  If the file is not found, a simulated sensor is used instead to provide
--  the readings.

--  The implementation of this package is hardware- and operating system-
--  dependent. This version is for a SunFounder DS18B20 sensor connected
--  to a RaspberryPi board through GPIO pin 4.

--  The board OS is Raspbian Linux. The following linux
--  commands must be executed in order to load the sensor driver
--  into the linux kernel:
--    $ sudo modprobe w1-gpio
--    $ sudo modprobe w1-therm

with Measurements;                      use Measurements;
with Ada.Directories;                   use Ada.Directories;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;

with Ada.Numerics;                      use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Float_Random;         use Ada.Numerics.Float_Random;

package body Sensor is

   -- DS18B20 id code and value path
   ID    : constant String := "28-0516a0ef7bff";
   Path  : constant String := "/sys/bus/w1/devices/"&ID&"/w1_slave";
   File  : File_Type;

   HW    : Boolean := False;
   Noise : Generator;

   -- get temperature value from hw sensor
   procedure Get_HW (T : out Temperature) is
      Line        : String(1..80);
      First, Last : Natural;
      IT          : Integer;
   begin
      Open (File, In_File, Path);
      Get_Line (File, Line, Last);
      Get_Line (File, Line, Last);
      Close(File);
      First := Index(Line, "t=") + 2;
      IT := Integer'Value(Line(First..Last));
      T  := Temperature(Float(IT)/1000.0);
   exception
      when E : others =>
         Put_Line("Sensor error");
         Close(File);
   end Get_HW;

   -- get temperature value from simulator
   procedure Get_Simulated (T : out Temperature) is

      -- Parameters for simulation
      T0    : Temperature :=  25.0; -- Celsius

   begin
      T := T0 + Temperature(Random(Noise)) - 0.5;
   end Get_Simulated;

   ---------
   -- Get --
   ---------

   procedure Get (T: out Temperature) is
   begin
      if HW then
         Get_HW(T);
      else
         Get_Simulated(T);
      end if;
   end Get;

begin
   if Exists (Path) then
      HW := True;
      pragma Debug(Put_Line("... using DS18B20 sensor"));
   else
      HW := False;
      pragma Debug(Put_Line("... using simulated sensor"));
   end if;
end Sensor;
